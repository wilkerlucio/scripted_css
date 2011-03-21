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

module "Selector Node"

selector = ScriptedCss.Nodes.Selector

test "initialize", ->
  sel = new selector(
    type: "selector"
    combinator: " "
    left:
      type: "plain"
    right:
      type: "plain"
  )

  same(sel.type, "selector")
  same(sel.combinator, " ")
  ok(sel.left.plain)
  ok(sel.right.plain)

test "selections", ->
  sel = new selector(
    type: "selector"
    combinator: " "
    left:
      type: "plain"
    right:
      type: "plain"
      selections: -> ["A"]
  )

  same(sel.selections(), ["A"])

test "weight", ->
  sel = new selector(
    type: "selector"
    combinator: " "
    left:
      type: "plain"
      weight: -> 10
    right:
      type: "plain"
      weight: -> 11
  )

  equal(sel.weight(), 21)

test "stringify", ->
  for combinator in [" ", ">", "+", "~"]
    sel = new selector(
      type: "selector"
      combinator: combinator
      left:
        type: "plain"
        stringify: -> "a"
      right:
        type: "plain"
        stringify: -> "b"
    )

    comb = combinator
    comb = " #{combinator} " unless combinator == " "

    same(sel.stringify(), "a#{comb}b")
