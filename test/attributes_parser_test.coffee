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

parser = ScriptedCss.AttributesParser

grammar =
  _ignoreList: ["/"]

  quickEntry: "a b"

  andOne:
    value: "a b"

  andTwo:
    value: "a b c"

  orOne:
    value: "a | b"

  orOneInverted:
    value: "b | a"

  orLoss: "[ a || a ] | b"

  quantityMany:
    value: "a* b"

  quantityOptional:
    value: "a? b"

  groupQuantityMany:
    value: "a [ b c ]+"

  andOr:
    value: "a b | c"

  orAnd:
    value: "a | b c"

  opt:
    value: "a || b || c"

  optPrecedence:
    value: "a || b | c"

  optPrecedenceAnd:
    value: "a || b c"

  customReturn:
    value: "a b"
    return: (v) ->
      first:  v.get(0)
      second: v.get(1)

  withMacro:
    value: "<andOne>"

  functionValue:
    value: (nodes, grammar) ->
      @collect nodes, (node) -> node.type == "FUNCTION" and node.name == "url"

  ignoredValues:
    value: "one / two"

  complexOptional: "[ a || b || c ]? d"
  complexOptionalWithOr: "[ a || b ] | c"

module "Attributes Parser"

test "parsing an and list", ->
  out = parser.parseNodes([$n("a"), $n("b")], "andOne", grammar)
  same(out[0].string(), "a")
  same(out[1].string(), "b")

test "parsing an and invalid list", ->
  out = parser.parseNodes([$n("a"), $n("c")], "andOne", grammar)
  same(out, false)

test "parsing a triple and", ->
  out = parser.parseNodes([$n("a"), $n("b"), $n("c")], "andTwo", grammar)
  same(out[0].string(), "a")
  same(out[1].string(), "b")
  same(out[2].string(), "c")

test "parsing a triple invalid and", ->
  out = parser.parseNodes([$n("a"), $n("d"), $n("c")], "andTwo", grammar)
  same(out, false)

test "or operation", ->
  out = parser.parseNodes([$n("a"), $n("b")], "orOne", grammar)
  same(out.string(), "a")

test "or with first invalid and second valid", ->
  out = parser.parseNodes([$n("c"), $n("b")], "orOne", grammar)
  same(out.string(), "b")

test "or with elements inverted", ->
  out = parser.parseNodes([$n("a"), $n("b")], "orOneInverted", grammar)
  same(out.string(), "b")

test "or with only invalid items", ->
  out = parser.parseNodes([$n("c"), $n("d")], "orOne", grammar)
  same(out, false)

test "or don't lose values", ->
  out = parser.parseNodes([$n("a")], "orLoss", grammar)
  same(out[0].string(), "a")
  same(out[1], null)

  out = parser.parseNodes([$n("b")], "orLoss", grammar)
  same(out.string(), "b")

test "quantity many having one", ->
  out = parser.parseNodes([$n("a"), $n("b")], "quantityMany", grammar)
  same(out[0].length, 1)
  same(out[0][0].string(), "a")
  same(out[1].string(), "b")

test "quantity many having many", ->
  out = parser.parseNodes([$n("a"), $n("a"), $n("b")], "quantityMany", grammar)
  same(out[0].length, 2)
  same(out[0][0].string(), "a")
  same(out[0][1].string(), "a")
  same(out[1].string(), "b")

test "quantity many having none", ->
  out = parser.parseNodes([$n("b")], "quantityMany", grammar)
  same(out[0].length, 0)
  same(out[1].string(), "b")

test "quantity optional having the value", ->
  out = parser.parseNodes([$n("a"), $n("b")], "quantityOptional", grammar)
  console.log(out)
  same(out[0].string(), "a")
  same(out[1].string(), "b")

test "quantity optional not having the value", ->
  out = parser.parseNodes([$n("b")], "quantityOptional", grammar)
  console.log(out)
  same(out[0], [])
  same(out[1].string(), "b")

test "group quantity many having one", ->
  out = parser.parseNodes([$n("a"), $n("b"), $n("c")], "groupQuantityMany", grammar)
  same(out[0].string(), "a")
  same(out[1][0][0].string(), "b")
  same(out[1][0][1].string(), "c")

test "group quantity many having many", ->
  out = parser.parseNodes([$n("a"), $n("b"), $n("c"), $n("b"), $n("c")], "groupQuantityMany", grammar)
  same(out[0].string(), "a")
  same(out[1][0][0].string(), "b")
  same(out[1][0][1].string(), "c")
  same(out[1][1][0].string(), "b")
  same(out[1][1][1].string(), "c")

test "group quantity many having none", ->
  out = parser.parseNodes([$n("a"), $n("b")], "groupQuantityMany", grammar)
  same(out, false)

test "andOr", ->
  out = parser.parseNodes([$n("a"), $n("b"), $n("c")], "andOr", grammar)
  same(out[0].string(), "a")
  same(out[1].string(), "b")

test "andOr on second", ->
  out = parser.parseNodes([$n("a"), $n("x"), $n("c")], "andOr", grammar)
  same(out.string(), "c")

test "orAnd", ->
  out = parser.parseNodes([$n("a"), $n("b"), $n("c")], "orAnd", grammar)
  same(out[0].string(), "a")
  same(out[1].string(), "c")

test "orAnd on second", ->
  out = parser.parseNodes([$n("x"), $n("b"), $n("c")], "orAnd", grammar)
  same(out[0].string(), "b")
  same(out[1].string(), "c")

test "optional", ->
  out = parser.parseNodes([$n("a"), $n("x"), $n("c")], "opt", grammar)
  same(out[0].string(), "a")
  same(out[1], null)
  same(out[2].string(), "c")

test "optional precedence", ->
  out = parser.parseNodes([$n("a"), $n("x"), $n("c")], "optPrecedence", grammar)
  same(out[0].string(), "a")
  same(out[1].string(), "c")

test "custom return", ->
  out = parser.parseNodes([$n("a"), $n("b")], "customReturn", grammar)
  same(out.first.string(), "a")
  same(out.second.string(), "b")

test "simple macro", ->
  out = parser.parseNodes([$n("a"), $n("b")], "withMacro", grammar)
  same(out[0].string(), "a")
  same(out[1].string(), "b")

test "value as a function", ->
  out = parser.parseNodes([$n("function", "url", [$n("string", "hi.png")])], "functionValue", grammar)
  same(out.type, "FUNCTION")
  same(out.name, "url")
  same(out.arguments[0].text, "hi.png")

test "value as a function invalid", ->
  out = parser.parseNodes([$n("wrong")], "functionValue", grammar)
  same(out, false)

test "ignoring some return values", ->
  out = parser.parseNodes([$n("one"), $n("/"), $n("two")], "ignoredValues", grammar)
  same(out[0].string(), "one")
  same(out[1].string(), "two")

test "using quick entries", ->
  out = parser.parseNodes([$n("a"), $n("b")], "quickEntry", grammar)
  same(out[0].string(), "a")
  same(out[1].string(), "b")

test "complex optional with all values", ->
  out = parser.parseNodes([$n("a"), $n("b"), $n("c"), $n("d")], "complexOptional", grammar)
  same(out[0][0].string(), "a")
  same(out[0][1].string(), "b")
  same(out[0][2].string(), "c")
  same(out[1].string(), "d")

test "complex optional with one missing values", ->
  out = parser.parseNodes([$n("a"), $n("c"), $n("d")], "complexOptional", grammar)
  same(out[0][0].string(), "a")
  same(out[0][1], null)
  same(out[0][2].string(), "c")
  same(out[1].string(), "d")

test "complex optional with two missing values", ->
  out = parser.parseNodes([$n("c"), $n("d")], "complexOptional", grammar)
  same(out[0][0], null)
  same(out[0][1], null)
  same(out[0][2].string(), "c")
  same(out[1].string(), "d")

test "complex optional with all optional missing", ->
  out = parser.parseNodes([$n("d")], "complexOptional", grammar)
  same(out[0][0], null)
  same(out[0][1], null)
  same(out[0][2], null)
  same(out[1].string(), "d")

test "complex optional with or", ->
  out = parser.parseNodes([$n("a"), $n("b")], "complexOptionalWithOr", grammar)
  same(out[0].string(), "a")
  same(out[1].string(), "b")

test "complex optional with or failing on first", ->
  out = parser.parseNodes([$n("c")], "complexOptionalWithOr", grammar)
  same(out.string(), "c")

test "caching quick attributes", ->
  out = parser.parseNodes([], "quickEntry", grammar)
  ok(grammar.quickEntry.value, "quick entry was not cached")

test "caching parser", ->
  out = parser.parseNodes([], "quickEntry", grammar)
  ok(grammar.andOne.parser, "parser was not cached")
