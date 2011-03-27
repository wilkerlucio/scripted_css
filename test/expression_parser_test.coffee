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

module "Expression Parser - Syntax"

parse = ScriptedCss.ExpressionParser.parse

for op in [["multi", " || "], ["or", " | "], ["and", " "]]
  test "parse simple #{op[0]}", ->
    c = parse("a#{op[1]}b")

    same(c.type, op[0])
    same(c.left.value.value, "a")
    same(c.right.value.value, "b")

test "parse a expression", ->
  c = parse("[a]")

  same(c.type, "expression")
  same(c.quantity, [1, 1])
  same(c.value.value.type, "value")
  same(c.value.value.value, "a")

test "parse a simple value", ->
  c = parse("a").value

  same(c.type, "value")
  same(c.value, "a")

test "quantity *", ->
  c = parse("a*")

  same(c.type, "expression")
  same(c.value.value, "a")
  same(c.quantity, [0, 0])

test "quantity +", ->
  c = parse("a+")

  same(c.type, "expression")
  same(c.value.value, "a")
  same(c.quantity, [1, 0])

test "quantity ?", ->
  c = parse("a?")

  same(c.type, "expression")
  same(c.value.value, "a")
  same(c.quantity, [0, 1])

test "quantity custom", ->
  c = parse("a{2}")

  same(c.type, "expression")
  same(c.value.value, "a")
  same(c.quantity, [2, 2])

test "quantity custom range", ->
  c = parse("a{2, 4}")

  same(c.type, "expression")
  same(c.value.value, "a")
  same(c.quantity, [2, 4])

test "quantity custom min range", ->
  c = parse("a{2,}")

  same(c.type, "expression")
  same(c.value.value, "a")
  same(c.quantity, [2, 0])

test "parse macro", ->
  c = parse("<a>").value

  same(c.type, "macro")
  same(c.value, "a")

test "labelling a value", ->
  c = parse("label:a")

  same(c.label, "label")
  same(c.value.value, "a")
