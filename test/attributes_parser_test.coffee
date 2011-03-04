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
  andOne:
    value: "a b"

  andTwo:
    value: "a b c"

  orOne:
    value: "a | b"

  orOneInverted:
    value: "b | a"

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

