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

module("AttributeSelector Node Test")

attr = ScriptedCss.Nodes.AttributeSelector
ga = (name, op = null, val = null) -> new attr(type: "attribute_selector", attribute: name, operator: op, value: val)

test "initialize", ->
  a = ga("type", "=", "text")

  same(a.type, "attribute_selector")
  same(a.attribute, "type")
  same(a.operator, "=")
  same(a.value, "text")

test "matching attribute existance", ->
  a = ga("type")

  ok(a.match($("<div />", type: "tt")[0]))
  ok(a.match($("<div />", type: "")[0]))
  ok(!a.match($("<div />")[0]))

test "matching attribute equallity", ->
  a = ga("type", "=", "text")

  ok(a.match($("<div />", type: "text")[0]))
  ok(!a.match($("<div />", type: "tex")[0]))
  ok(!a.match($("<div />")[0]))

test "matching attribute inclusion", ->
  a = ga("type", "~=", "text")

  ok(a.match($("<div />", type: "some text value")[0]))
  ok(a.match($("<div />", type: "text")[0]))
  ok(!a.match($("<div />", type: "non tex value")[0]))
  ok(!a.match($("<div />", type: "")[0]))
  ok(!a.match($("<div />")[0]))

test "matching attribute begins", ->
  a = ga("type", "^=", "text")

  ok(a.match($("<div />", type: "textes")[0]))
  ok(a.match($("<div />", type: "text")[0]))
  ok(!a.match($("<div />", type: "tex")[0]))
  ok(!a.match($("<div />")[0]))

test "matching attribute ends", ->
  a = ga("type", "$=", "text")

  ok(a.match($("<div />", type: "aatext")[0]))
  ok(a.match($("<div />", type: "text")[0]))
  ok(!a.match($("<div />", type: "texty")[0]))
  ok(!a.match($("<div />")[0]))

test "matching attribute contains", ->
  a = ga("type", "*=", "text")

  ok(a.match($("<div />", type: "aatextaa")[0]))
  ok(a.match($("<div />", type: "atext")[0]))
  ok(a.match($("<div />", type: "texta")[0]))
  ok(!a.match($("<div />", type: "aatexaa")[0]))
  ok(!a.match($("<div />")[0]))

test "matching attribute hypen separated starting with", ->
  a = ga("type", "|=", "en")

  ok(a.match($("<div />", type: "en")[0]))
  ok(a.match($("<div />", type: "en-US")[0]))
  ok(!a.match($("<div />", type: "US-en")[0]))
  ok(!a.match($("<div />", type: "ens-US")[0]))
  ok(!a.match($("<div />")[0]))

  a = ga("type", "|=", "en-US")

  ok(a.match($("<div />", type: "en-US")[0]))
  ok(a.match($("<div />", type: "en-US-O")[0]))
  ok(!a.match($("<div />", type: "en")[0]))

test "stringify", ->
  a = ga("type", "=", "text")

  same(a.stringify(), "[type=text]")
