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

exports.RulesNode = class RulesNode
  constructor: (@rules) ->
  string: -> (rule.string() for rule in @rules).join("\n")

exports.RuleNode = class RuleNode
  constructor: (@selectors, @attributes) ->

  selectorsString:  -> collectStrings(@selectors).join(" , ")
  attributesString: -> collectStrings(@attributes).join("; ")
  string:           -> "#{@selectorsString()} { #{@attributesString()} }"

exports.MetaNode = class MetaNode
  constructor: (@name, @value) ->
  string: -> "@#{@name} #{@value}"

exports.SelectorNode = class SelectorNode
  constructor: (@selector, @attributes = null, @meta = null) ->
    @next = null

  nestSelector: (selector, rule = " ") ->
    if @next
      @next.nestSelector.call(@next, selector, rule)
    else
      @next     = selector
      @nextRule = rule

    this

  nextString:      -> if @next then " #{@nextRule} #{@next.string()}" else ""
  attributeString: -> if @attributes then "[#{@attributes.string()}]" else ""
  metaString:      -> if @meta then @meta.string() else ""
  string:          -> "#{@selector}#{@attributeString()}#{@metaString()}#{@nextString()}"

exports.MetaSelectorNode = class MetaSelectorNode
  constructor: (@value, @operator) ->

  string: -> "#{@operator}#{@value.string()}"

exports.AttributeNode = class AttributeNode
  constructor: (@name, @values) ->

  value:  -> collectStrings(@values).join(" ")
  string: -> "#{@name}: #{@value()}"

exports.FunctionNode = class FunctionNode
  constructor: (@name, @arguments) ->

  argumentsString: -> collectStrings(@arguments).join(",")
  string: -> "#{@name}(#{@argumentsString()})"

exports.AttributeSelectorNode = class AttributeSelectorNode
  constructor: (@name, @operator, @value) ->
  string: -> "#{@name}#{@operator}#{@value.string()}"

exports.LiteralNode = class LiteralNode
  constructor: (@value) ->
  string: -> @value.toString()
