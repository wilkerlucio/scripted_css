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

window.ScriptedCss.AttributesParser.yy =
  Optional: class Optional
    constructor: (@v1, @v2) ->
      @type = "OPTIONAL"

    parse: (nodes, grammar) ->
      r1 = @v1.parse(nodes, grammar)
      r2 = @v2.parse(nodes, grammar)

      if r1 or r2 then [r1, r2] else false

  Or: class Or
    constructor: (@v1, @v2) ->
      @type = "OR"

    parse: (nodes, grammar) ->
      @v1.parse(nodes, grammar) or @v2.parse(nodes, grammar)

  And: class And
    constructor: (@v1, @v2) ->
      @type = "AND"

    parse: (nodes, grammar) ->
      r1 = @v1.parse(nodes, grammar)
      r2 = @v2.parse(nodes, grammar)

      if r1 and r2 then [r1, r2] else false

  Value: class Value
    constructor: (@value, @quantity = new Quantity(1)) ->
      @type = "VALUE"

    parse: (nodes, grammar) ->
      @value.parse(nodes, grammar)

  Macro: class Macro
    constructor: (@value) ->
      @type = "MACRO"

  Literal: class Literal
    constructor: (@value) ->
      @type = "LITERAL"

    parse: (nodes, grammar) ->
      for node in nodes
        if node.string() == @value
          return node

      false

  Quantity: class Quantity
    constructor: (@min, @max = @min) ->

window.ScriptedCss.AttributesParser.parseNodes = (nodes, rule, grammar = null) ->
  rule = grammar[rule]

  unless rule.parser
    rule.parser = ScriptedCss.AttributesParser.parse(rule.value)

  result = rule.parser.parse(nodes)

  if result
    if _.isArray(result) then _.flatten(result) else result
  else
    false
