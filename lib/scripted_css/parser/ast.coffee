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

CssAST =
  RulesNode: class RulesNode
    constructor: (rules) ->
      @rules        = []
      @metaRules    = []
      @elementRules = {}

      @index(rules)

    index: (rules) ->
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
        @elementRules[rule.selector.string()].mergeAttributes(rule.attributes)
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

        for name, attribute of rule.attributesHash
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
        attr = rule.attributesHash[attribute]
        if attr
          weight = attr.weight()
          value = [attr, weight] if weight > value[1]

      if stringify then value[0].value() else value[0]

    attribute: (name) -> @attributes[name] || []

    string: -> (rule.string() for rule in @rules).join("\n")

  RuleNode: class RuleNode
    constructor: (@selector, attributes) ->
      @attributes     = []
      @attributesHash = {}

      for attribute in attributes
        @addAttribute(attribute)

    addAttribute: (attribute) ->
      attribute.rule = this
      @attributes.push(attribute)
      @attributesHash[attribute.name] = attribute

    mergeAttributes: (attributes) -> @addAttribute(attribute) for attribute in attributes

    cssAttributes: ->
      hash = {}

      for name, attr of @attributesHash
        hash[name] = attr.value()

      hash

    attributesString: -> collectStrings(@attributes).join("; ")
    string:           -> "#{@selector.string()} { #{@attributesString()} }"

  MetaNode: class MetaNode
    constructor: (@name, @value) ->
    string: -> "@#{@name} #{@value}"

  SelectorNode: class SelectorNode
    constructor: (@selector, @attributes = null, @meta = null) ->
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

    string: -> "#{@operator}#{@value.string()}"

  AttributeNode: class AttributeNode
    constructor: (@name, @values) ->

    isImportant: ->
      for value in @values
        return true if value.important
      false

    weight: ->
      throw "Can't calculate weight of an deatached attribute" unless @rule
      w = @rule.selector.weight()
      w += 1000 if @isImportant()
      w

    value:  -> collectStrings(@values).join(" ")
    string: -> "#{@name}: #{@value()}"

  FunctionNode: class FunctionNode
    constructor: (@name, @arguments) ->

    argumentsString: -> collectStrings(@arguments).join(",")
    string: -> "#{@name}(#{@argumentsString()})"

  AttributeSelectorNode: class AttributeSelectorNode
    constructor: (@name, @operator, @value) ->
    string: -> "#{@name}#{@operator}#{@value.string()}"

  LiteralNode: class LiteralNode
    constructor: (@value) ->
    string: -> @value.toString()

  StringNode: class StringNode
    constructor: (@value) ->
      @text = @value.substr(1, @value.length - 2)

    string: -> @value.toString()

  UnitNumberNode: class UnitNumberNode
    constructor: (@value) ->
      [@value, @number, @unit] = value.match(/(.+?)([a-zA-Z%]+)/)
      @number = parseFloat(@number)

    string: -> @value.toString()

  MultiLiteral: class MultiLiteral
    constructor: (@literals, @separator) ->
    string: -> collectStrings(@literals).join(@separator)

  ImportantNode: class ImportantNode
    constructor: ->
      @important = true
    string: -> "!important"

window.CssAST = CssAST if window?
module.exports = CssAST if module?
