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

module("DeclarationSet Node Test")

g = (list) -> new ScriptedCss.Nodes.DeclarationSet(list)

test "initialize", ->
  ds = g([{type: "plain", property: "a"}])

  same(ds.type, "declaration_set")
  ok(ds.declarations[0].parent == ds)
  ok(ds.declarations[0].plain)

test "generate attribute hash", ->
  ds = g([
    {type: "plain", property: "a", stringify: -> "0"}
    {type: "plain", property: "a", stringify: -> "10px"}
    {type: "plain", property: "b", stringify: -> "left"}
  ])

  same(ds.hash["a"].stringify(), "10px")
  same(ds.hash["b"].stringify(), "left")

test "stringify", ->
  ds = g([
    {type: "plain", property: "a", stringify: -> "a: 0"}
    {type: "plain", property: "a", stringify: -> "a: 10px"}
    {type: "plain", property: "b", stringify: -> "b: left"}
  ])

  same(ds.stringify(), "a: 0; a: 10px; b: left")
