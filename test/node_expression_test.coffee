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

module("Expression Node Test")

g = (values) -> new ScriptedCss.Nodes.Expression(values)

test "initialize", ->
  e = g([{type: "plain"}])

  same(e.type, "expression")
  ok(e.values[0].plain)

test "parse", ->
  e = g([
    {type: "plain", stringify: -> "a"}
    {type: "plain", stringify: -> "b"}
  ])

  r = e.parse("one:a || two:c")

  same(r.one.stringify(), "a")
  same(r.two, false)

test "parse use defaultDict by default", ->
  ScriptedCss.Nodes.Expression.defaultDict.add("test-sample-info": "o:a || t:b")

  e = g([
    {type: "plain", stringify: -> "a"}
    {type: "plain", stringify: -> "b"}
  ])

  r = e.parse("<test-sample-info>")

  same(r.o.stringify(), "a")
  same(r.t.stringify(), "b")

test "stringify", ->
  e = g([{type: "plain", stringify: -> "a"}, {type: "plain", stringify: -> "b"}])

  same(e.stringify(), "a b")
