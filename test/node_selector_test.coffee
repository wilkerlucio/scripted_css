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

matcherSel = (combinator) ->
  new selector(
    type: "selector"
    combinator: combinator
    left:
      type: "plain"
      match: (el) -> if el.tagName == "DIV" then el else false
    right:
      type: "plain"
      match: (el) -> if el.tagName == "SPAN" then el else false
  )

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

test "match elements with ' ' if has a valid parent", ->
  obj = $("<div><strong><span></span></strong></div>").find("span")[0]
  ok(matcherSel(' ').match(obj))

test "don't match elements with ' ' if has not a valid parent", ->
  obj = $("<body><strong><span></span></strong></body>").find("span")[0]
  ok(!matcherSel(' ').match(obj))

test "match elements with '>' if has a valid direct parent", ->
  obj = $("<div><span></span></div>").find("span")[0]
  ok(matcherSel('>').match(obj))

test "don't match elements with '>' if has not a valid direct parent", ->
  obj = $("<div><strong><span></span></strong></div>").find("span")[0]
  ok(!matcherSel('>').match(obj))

test "match elements with '+' if has a valid direct sibling", ->
  obj = $("<div><div></div><span></span></div>").find("span")[0]
  ok(matcherSel('+').match(obj))

test "don't match elements with '+' if has not a valid direct sibling", ->
  obj = $("<div><div></div><strong>hey</strong><span></span></div>").find("span")[0]
  ok(!matcherSel('+').match(obj))

test "match elements with '~' if has a valid previous sibling", ->
  obj = $("<div><div>ho</div><strong>hey</strong><span></span></div>").find("span")[0]
  ok(matcherSel('~').match(obj))

test "don't match elements with '~' if has not a valid previous sibling", ->
  obj = $("<div><strong>hey</strong><span></span><div></div></div>").find("span")[0]
  ok(!matcherSel('~').match(obj))

test "nest complex matching", ->
  sel = new selector(
    type: "selector"
    combinator: " "
    left:
      type: "plain"
      match: (el) -> if el.tagName == "DIV" then el else false
    right:
      type: "selector"
      combinator: "+"
      left:
        type: "plain"
        match: (el) -> if el.tagName == "STRONG" then el else false
      right:
        type: "plain"
        match: (el) -> if el.tagName == "SPAN" then el else false
  )

  obj = $("<div><ul><li><strong>hey</strong><span>joe</span></li></ul></div>").find("span")[0]
  ok(sel.match(obj))
  obj = $("<div><ul><li><b>hey</b><span>joe</span></li></ul></div>").find("span")[0]
  ok(!sel.match(obj))

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
