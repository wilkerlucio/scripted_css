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

module("PseudoSelector Node Test")

PseudoSelector = ScriptedCss.Nodes.PseudoSelector
g = (value, symbol = ":") -> new PseudoSelector(type: "pseudo_selector", symbol: symbol, value: value)

pseudoTransaction = (fn) ->
  pseudos = PseudoSelector.pseudos
  PseudoSelector.pseudos = {}

  fn()

  PseudoSelector.pseudos = pseudos

test "initialize with identifier value", ->
  p = g("first")

  same(p.type, "pseudo_selector")
  same(p.symbol, ":")
  same(p.value.name, "first")
  same(p.value.stringify(), "first")
  same(p.id, ":first")

test "initialize with a function value", ->
  p = g({type: "plain", stubType: "function", name: "fn"}, "::")

  same(p.type, "pseudo_selector")
  same(p.symbol, "::")
  ok(p.value.plain)
  same(p.id, "::fn")

test "registering pseudo matchers", ->
  pseudoTransaction ->
    PseudoSelector.register("on", "hi")
    same(PseudoSelector.pseudos["on"], "hi")

test "match", ->
  pseudoTransaction ->
    PseudoSelector.register(":true",  -> true)
    PseudoSelector.register(":false", -> false)

    ok(g("true").match(null))
    ok(!g("false").match(null))
    ok(!g("unavailable").match(null))

test "stringify", ->
  same(g("first").stringify(), ":first")
  same(g("after", "::").stringify(), "::after")

module("PseudoSelector Node Modules Test")

e = (string, filter = null, attr = undefined) ->
  context = $(string, attr)
  context = context.find(filter) if filter
  context[0]

ps = (id, string, filter = null, attr = undefined, value = undefined) ->
  PseudoSelector.pseudos[id](e(string, filter, attr), value)

test ":root", ->
  ok(ps(":root", "<div></div>"))
  ok(!ps(":root", "<div><span></span></div>", "span"))

test ":nth-child", ->
  ok(false)

test ":nth-last-child", ->
  ok(false)

test ":nth-of-type", ->
  ok(false)

test ":nth-last-of-type", ->
  ok(false)

test ":first-child", ->
  ok(ps(":first-child", "<div></div>"))
  ok(ps(":first-child", "<div><span></span></div>", "span"))
  ok(!ps(":first-child", "<div>other<span></span></div>", "span"))

test ":last-child", ->
  ok(ps(":last-child", "<div></div>"))
  ok(ps(":last-child", "<div><span></span></div>", "span"))
  ok(!ps(":last-child", "<div><span></span>other</div>", "span"))

test ":first-of-type", ->
  ok(ps(":first-of-type", "<div></div>"))
  ok(ps(":first-of-type", "<div><span></span></div>", "span"))
  ok(ps(":first-of-type", "<div>other<span></span></div>", "span"))
  ok(!ps(":first-of-type", "<div><span></span><b></b><span></span></div>", "span:eq(1)"))

test ":last-of-type", ->
  ok(ps(":last-of-type", "<div></div>"))
  ok(ps(":last-of-type", "<div><span></span></div>", "span"))
  ok(ps(":last-of-type", "<div><span></span>other</div>", "span"))
  ok(!ps(":last-of-type", "<div><span></span><b></b><span></span></div>", "span:eq(0)"))

test ":only-child", ->
  ok(ps(":only-child", "<div></div>"))
  ok(ps(":only-child", "<div><span></span></div>", "span"))
  ok(!ps(":only-child", "<div><span></span>other</div>", "span"))
  ok(!ps(":only-child", "<div>other<span></span></div>", "span"))
  ok(!ps(":only-child", "<div>other<span></span>other</div>", "span"))

test ":only-of-type", ->
  ok(ps(":only-of-type", "<div></div>"))
  ok(ps(":only-of-type", "<div><span></span></div>", "span"))
  ok(ps(":only-of-type", "<div><span></span>other</div>", "span"))
  ok(ps(":only-of-type", "<div>other<span></span></div>", "span"))
  ok(ps(":only-of-type", "<div>other<span></span>other</div>", "span"))
  ok(!ps(":only-of-type", "<div><span></span>other<span></span>other</div>", "span"))

test ":empty", ->
  ok(ps(":empty", "<div></div>"))
  ok(!ps(":empty", "<div><span></span></div>"))
  ok(!ps(":empty", "<div>other</div>"))

test ":enabled", ->
  ok(ps(":enabled", "<input />", null, type: "text"))
  ok(!ps(":enabled", "<input />", null, type: "text", disabled: "disabled"))

test ":disabled", ->
  ok(!ps(":disabled", "<input />", null, type: "text"))
  ok(ps(":disabled", "<input />", null, type: "text", disabled: "disabled"))

test ":checked", ->
  ok(ps(":checked", '<input type="checkbox" checked="checked" />'))
  ok(!ps(":checked", '<input type="checkbox" />'))

test ":not", ->
  fakeNot = (m) ->
    type: "function"
    name: "not"
    params:
      type: "plain"
      match: -> m

  ok(ps(":not", "<input type='text' />", null, undefined, fakeNot(false)))
  ok(!ps(":not", "<input type='text' />", null, undefined, fakeNot(true)))
