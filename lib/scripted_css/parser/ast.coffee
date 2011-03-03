# Copyright (c) 2011 Wilker Lúcio
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

collectStrings = (list) -> (item.string() for item in list)

Array.prototype.isArray = -> true

CssAST =
  createNode: (args...) ->
    expressions = ScriptedCss.CssParser.Lexer.expressions

    nodes =
      "rules":              RulesNode
      "rule":               RuleNode
      "attributes":         AttributeSet
      "meta":               MetaNode
      "selector":           SelectorNode
      "meta-selector":      MetaSelectorNode
      "attribute":          AttributeNode
      "function":           FunctionNode
      "attribute-selector": AttributeSelectorNode
      "string":             StringNode
      "arg":                NamedArgumentNode
      "important":          ImportantNode
      "literal":            LiteralNode
      "number":             NumberNode
      "unit":               UnitNumberNode
      "hex":                HexnumberNode
      "multi-value":        MultiValue

    type = args.shift()

    if args.length == 0
      type += "" # ensure its a string

      if type == "!"
        new ImportantNode()
      else if type.match(expressions.hexnumber)
        new HexnumberNode(type)
      else if type.match(expressions.unitnumber)
        new UnitNumberNode(type)
      else if type.match(expressions.number)
        new NumberNode(type)
      else
        new LiteralNode(type)
    else
      if nodes[type]
        args[0] = "'#{args[0]}'" if type == "string"

        new nodes[type](args...)
      else
        return new MultiValue(type, args[0]) if type.isArray() and args[0]

        throw "Can't create node for type #{type}"

  RulesNode: class RulesNode
    constructor: (rules) ->
      @type         = "RULES"
      @rules        = []
      @metaRules    = []
      @elementRules = {}

      @merge(rules)

    merge: (rules) ->
      if rules.type == "RULES"
        @merge(rules.rules)
      else
        @meta = {}

        for rule in rules
          if rule.selector?
            @rules.push(rule) if @indexRule(rule)
          else
            @rules.push(rule)
            @meta[rule.name] = rule.value
            @metaRules.push(rule)

        @indexAttributesAndSelectors()

    indexRule: (rule) ->
      if @elementRules[rule.selector.string()]
        @elementRules[rule.selector.string()].meta = @meta
        @elementRules[rule.selector.string()].attributes.merge(rule.attributes)
        false
      else
        rule.meta = @meta
        @elementRules[rule.selector.string()] = rule
        true

    indexAttributesAndSelectors: ->
      @attributes    = {}
      @selectorIndex = {}

      for selector, rule of @elementRules
        for indexItem in rule.selector.lastSelector().parts()
          indexItem = indexItem.toUpperCase() unless indexItem.match(/^[#.]/)
          @selectorIndex[indexItem] ?= []
          @selectorIndex[indexItem].push(rule)

        for name, attribute of rule.attributes.hash
          @attributes[attribute.name] ?= []
          @attributes[attribute.name].push(attribute)

    rulesForElement: (element) ->
      rules           = []
      rulesHash       = {}
      relativeIndexes = ["*"]

      elementClasses = if element.className then element.className.split(" ") else []
      elementClasses = ("." + klass for klass in elementClasses)

      relativeIndexes.push(element.tagName)
      relativeIndexes.push("#" + element.id) if element.id
      relativeIndexes.push(klass) for klass in elementClasses

      for index in relativeIndexes
        for rule in (@selectorIndex[index] || [])
          rulesHash[rule.selector.string()] = rule if rule.selector.isCompatible(element)

      for selector, rule of rulesHash
        rules.push(rule)

      rules

    attributeForElement: (element, attribute, stringify = true) ->
      rules = @rulesForElement(element)
      value = [new AttributeNode(attribute, []), 0]

      for rule in rules
        attr = rule.attributes.hash[attribute]
        if attr
          weight = attr.weight()
          value = [attr, weight] if weight > value[1]

      if stringify then value[0].value() else value[0]

    attribute: (name) -> @attributes[name] || []

    string: -> (rule.string() for rule in @rules).join("\n")

  RuleNode: class RuleNode
    constructor: (@selector, attributes) ->
      @type = "RULE"
      @attributes = new AttributeSet(this, attributes)

    cssAttributes: ->
      hash = {}

      for name, attr of @attributes.hash
        hash[name] = attr.value()

      hash

    string:           -> "#{@selector.string()} #{@attributes.string()}"

  AttributeSet: class AttributeSet
    @expansions: {}
    @registerExpansion: (property, expansion) -> @expansions[property] = expansion

    expansion: (name) ->
      AttributeSet.expansions[name]

    constructor: (@owner, attributes) ->
      @type = "ATTRIBUTE_SET"
      @items        = []
      @hash         = {}
      @merge(attributes)

    merge: (attributes) ->
      if attributes.type == "ATTRIBUTE_SET"
        @merge(attributes.items)
      else
        @add(attribute) for attribute in attributes

    add: (attribute) ->
      if @expansion(attribute.name)
        @merge(@expansion(attribute.name).explode(attribute))
      else
        attribute.rule = @owner
        @items.push(attribute)
        @hash[attribute.name] = attribute

    addFilter: (node) ->
      filterAttribute = @hash["filter"]

      if filterAttribute
        filterAttribute.values.push(node)
      else
        @add(new AttributeNode("filter", [node]))

    get: (name) ->
      if @expansion(name)
        attr = @expansion(name).implode(this, name)
        attr.rule = @owner
        attr
      else
        @hash[name] || null

    string: -> "{ " + collectStrings(@items).join("; ") + " }"

  MetaNode: class MetaNode
    constructor: (@name, @value) ->
      @type = "META"

      if @value.isArray
        @value = new AttributeSet(this, @value)
    string: -> "@#{@name} #{@value.string()}"

  SelectorNode: class SelectorNode
    constructor: (@selector, @attributes = null, @meta = null) ->
      @type   = "SELECTOR"
      @next   = null
      @parent = null

    nestSelector: (selector, rule = " ") ->
      if @next
        @next.nestSelector.call(@next, selector, rule)
      else
        @next        = selector
        @next.parent = this
        @nextRule    = rule

      this

    lastSelector: ->
      last = this
      last = last.next while last.next?
      last

    parts: ->
      parts = []
      i = 0

      while chunk = @selector.slice(i)
        part = chunk.match(/[#.]?[^#.]+/)[0]
        parts.push(part)
        i += part.length

      parts

    isCompatible: (element, sel = @lastSelector()) ->
      return false unless @isDirectCompatible(element, sel)
      sel = sel.parent

      if sel
        previous = null

        switch sel.nextRule
          when "+"
            while previous = element.previousNode
              break if previous.nodeType == 1

            return false unless previous and previous.nodeType == 1
            return @isCompatible(previous, sel)
            break
          when ">"
            previous = element.parentNode

            return false unless previous
            return @isCompatible(previous, sel)
            break
          when " "
            parts = sel.parts()
            previous = element

            while previous = previous.parentNode
              return @isCompatible(previous, sel) if @isDirectCompatible(previous, sel)

            return false

      true

    isDirectCompatible: (element, selector) ->
      parts = selector.parts()

      elementTag     = element.tagName
      elementId      = element.id
      elementClasses = element.className?.split(" ") || []

      for part in parts
        switch part.charAt(0)
          when "#"
            return false unless elementId == part.slice(1)
            break
          when "."
            klass = part.slice(1)
            hasClass = false

            for c in elementClasses
              if c == klass
                hasClass = true
                break

            return false unless hasClass
            break
          else
            return false unless part == "*" or part.toUpperCase() == elementTag

      true

    weight: ->
      weight = 0

      for part in @parts()
        switch part.charAt(0)
          when "#" then weight += 100; break
          when "." then weight += 10; break
          else weight += 1

      weight += @next.weight() if @next?
      weight

    nextString: ->
      if @next
        operatorString = if @nextRule == " " then " " else " #{@nextRule} "
        operatorString + @next.string()
      else
        ""

    attributeString: -> if @attributes then "[#{@attributes.string()}]" else ""
    metaString:      -> if @meta then @meta.string() else ""
    string:          -> "#{@selector}#{@attributeString()}#{@metaString()}#{@nextString()}"

  MetaSelectorNode: class MetaSelectorNode
    constructor: (@value, @operator) ->
      @type = "META_SELECTOR"

    string: -> "#{@operator}#{@value.string()}"

  AttributeNode: class AttributeNode
    constructor: (@name, @values) ->
      @type = "ATTRIBUTE"

    isImportant: ->
      for value in @values
        return true if value.important
      false

    weight: ->
      throw "Can't calculate weight of an deatached attribute" unless @rule
      w = @rule.selector.weight()
      w += 1000 if @isImportant()
      w

    groupMultiValues: ->
      groups = []
      currentGroup = []

      for value in @values
        if value.type == "MULTI_VALUE"
          for item in value.literals
            currentGroup.push(item)
            groups.push(currentGroup)
            currentGroup = []
        else
          currentGroup.push(value)

      groups.push(currentGroup)
      groups

    value:  -> collectStrings(@values).join(" ")
    string: -> "#{@name}: #{@value()}"

  FunctionNode: class FunctionNode
    constructor: (@name, @arguments) ->
      @type = "FUNCTION"
      @namedArguments = {}

      for arg in @arguments
        if arg.type == "NAMED_ARGUMENT"
          @namedArguments[arg.name] = arg.value

    argumentsString: -> collectStrings(@arguments).join(",")
    string: -> "#{@name}(#{@argumentsString()})"

  AttributeSelectorNode: class AttributeSelectorNode
    constructor: (@name, @operator, @value) ->
      @type = "ATTRIBUTE_SELECTOR"

    string: -> "#{@name}#{@operator}#{@value.string()}"

  LiteralNode: class LiteralNode
    constructor: (@value) ->
      @type = "LITERAL"

    string: -> @value.toString()

  StringNode: class StringNode
    constructor: (@value) ->
      @type = "STRING"
      @text = @value.substr(1, @value.length - 2)

    string: -> @value.toString()

  NumberNode: class NumberNode
    constructor: (@value) ->
      @type = "NUMBER"

    number: -> parseFloat(@value)
    string: -> @value.toString()

  UnitNumberNode: class UnitNumberNode
    constructor: (@value) ->
      @type = "UNIT_NUMBER"

      [@value, @number, @unit] = value.match(/(.+?)([a-zA-Z%]+)/)
      @number = parseFloat(@number)

    string: -> @value.toString()

  HexnumberNode: class HexnumberNode
    constructor: (@value) ->
      @type = "HEXNUMBER"

    string: -> @value

  MultiValue: class MultiValue
    constructor: (@literals, @separator) ->
      @type = "MULTI_VALUE"
    string: -> collectStrings(@literals).join(@separator)

  NamedArgumentNode: class NamedArgumentNode
    constructor: (@name, @value) ->
      @type = "NAMED_ARGUMENT"
    string: -> "#{@name}=#{@value.string()}"

  ImportantNode: class ImportantNode
    constructor: ->
      @type = "IMPORTANT"
      @important = true
    string: -> "!important"

window.CssAST = CssAST if window?
window.$n = CssAST.createNode if window?
module.exports = CssAST if module?
