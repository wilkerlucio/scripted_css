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

parser = ScriptedCss.CssParser
AST    = CssAST

module "Rule Node"

test "test spliting meta things from real rules", ->
  css = parser.parse("@media screen body { background: red; } @media print body { background: white } p { color: #000 }")
  equals(css.metaRules.length, 2)

test "test indexing attributes", ->
  css = parser.parse("body {background: #000; display: block} div {display: \"aa\" \"bc\";}")
  equals(css.attribute("display").length, 2)
  same(css.attribute("display")[0].value(), "block")
  equals(css.attribute("background").length, 1)
  equals(css.attribute("font").length, 0)

test "test merging rules attributes", ->
  css = parser.parse("body {background: #000; display: block} body {display: inline; color: #fff}")
  same(css.attribute("display").length, 1)
  same(css.elementRules["body"].attributes.get("background").value(), "#000")
  same(css.elementRules["body"].attributes.get("display").value(), "inline")
  same(css.elementRules["body"].attributes.get("color").value(), "#fff")

test "test selector index", ->
  css = parser.parse("body div {background: #000; display: block} p.test {} .test.other {} #header {} div:nth-child(2) {display: block}")
  same(css.selectorIndex["DIV"][0].selector.string(), "body div")
  same(css.selectorIndex["DIV"][1].selector.string(), "div:nth-child(2)")
  same(css.selectorIndex[".test"][0].selector.string(), "p.test")
  same(css.selectorIndex[".test"][1].selector.string(), ".test.other")
  same(css.selectorIndex[".other"][0].selector.string(), ".test.other")
  same(css.selectorIndex["#header"][0].selector.string(), "#header")
