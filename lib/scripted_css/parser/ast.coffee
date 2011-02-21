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

exports.RulesNode = class RulesNode
  constructor: (@rules) ->

exports.RuleNode = class RuleNode
  constructor: (@selectors, @attributes) ->

exports.MetaNode = class MetaNode
  constructor: (@name, @value) ->

exports.SelectorNode = class SelectorNode
  constructor: (@selector, @attributes, @meta) ->
    @next = null

  nestSelector: (selector, rule = " ") ->
    if @next
      @next.nestSelector.call(@next, selector, rule)
    else
      @next     = selector
      @nextRule = rule

    this

exports.AttributeNode = class AttributeNode
  constructor: (@name, @values) ->

  value: ->
    rawValues = (value.string() for value in @values)
    rawValues.join(" ")

exports.FunctionNode = class FunctionNode
  constructor: (@name, @arguments) ->
  argumentsString: ->
    (arg.string() for arg in @arguments).join(",")

  string: -> "#{@name}(#{@argumentsString()})"

exports.AttributeSelectorNode = class AttributeSelectorNode
  constructor: (@name, @operator, @value) ->

exports.LiteralNode = class LiteralNode
  constructor: (@value) ->
  string: -> @value.toString()
