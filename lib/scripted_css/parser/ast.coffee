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
    constructor: (@rules) ->
      @metaRules    = []
      @elementRules = []
      @attributes   = {}

      @index()

    index: ->
      meta = {}

      for rule in @rules
        if rule.selectors?
          rule.meta = meta
          @indexRule(rule)
        else
          meta[rule.name] = rule.value
          @metaRules.push(rule)

    indexRule: (rule) ->
      for attribute in rule.attributes
        attribute.rule = rule

        @attributes[attribute.name] ?= []
        @attributes[attribute.name].push(attribute)

      @elementRules.push(rule)

    attribute: (name) -> @attributes[name] || []

    string: -> (rule.string() for rule in @rules).join("\n")

  RuleNode: class RuleNode
    constructor: (@selectors, @attributes) ->

    selectorsString:  -> collectStrings(@selectors).join(" , ")
    attributesString: -> collectStrings(@attributes).join("; ")
    string:           -> "#{@selectorsString()} { #{@attributesString()} }"

  MetaNode: class MetaNode
    constructor: (@name, @value) ->
    string: -> "@#{@name} #{@value}"

  SelectorNode: class SelectorNode
    constructor: (@selector, @attributes = null, @meta = null) ->
      @next = null

    nestSelector: (selector, rule = " ") ->
      if @next
        @next.nestSelector.call(@next, selector, rule)
      else
        @next     = selector
        @nextRule = rule

      this

    parts: ->
      parts = []
      i = 0

      while chunk = @selector.slice(i)
        part = chunk.match(/[#.]?[^#.]+/)[0]
        parts.push(part)
        i += part.length

      parts

    weight: ->
      weight = 0

      for part in @parts()
        switch part.charAt(0)
          when "#" then weight += 100
          when "." then weight += 10
          else weight += 1

      weight += @next.weight() if @next?
      weight

    nextString:      -> if @next then " #{@nextRule} #{@next.string()}" else ""
    attributeString: -> if @attributes then "[#{@attributes.string()}]" else ""
    metaString:      -> if @meta then @meta.string() else ""
    string:          -> "#{@selector}#{@attributeString()}#{@metaString()}#{@nextString()}"

  MetaSelectorNode: class MetaSelectorNode
    constructor: (@value, @operator) ->

    string: -> "#{@operator}#{@value.string()}"

  AttributeNode: class AttributeNode
    constructor: (@name, @values) ->

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
    content: -> @value.substr(1, @value.length - 2)
    string: -> @value.toString()

  MultiLiteral: class MultiLiteral
    constructor: (@literals, @separator) ->
    string: -> collectStrings(@literals).join(@separator)

window.CssAST = CssAST if window?
module.exports = CssAST if module?
