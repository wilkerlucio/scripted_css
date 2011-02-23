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

parser = require "scripted_css/parser"
AST    = require "scripted_css/parser/ast"

suite =
  "test spliting meta things from real rules": (test) ->
    css = parser.parse("@media screen body { background: red; } @media print body { background: white } p { color: #000 }")
    test.equal(css.metaRules.length, 2)
    test.equal(css.elementRules.length, 3)
    test.done()

  "test indexing attributes": (test) ->
    css = parser.parse("body {background: #000; display: block} div {display: \"aa\" \"bc\";}")
    test.equal(css.attribute("display").length, 2)
    test.same(css.attribute("display")[0].value(), "block")
    test.equal(css.attribute("background").length, 1)
    test.equal(css.attribute("font").length, 0)
    test.done()

global.testWrapper(suite)
module.exports = suite
