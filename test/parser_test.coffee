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
ast    = require "scripted_css/parser/ast"
fs     = require "fs"

suite =
  "test it parsing metadata": (test) ->
    css = parser.parse("@media screen")
    test.same(css.rules[0].name, "media")
    test.same(css.rules[0].value, "screen")
    test.done()

  "test it parsing simple selector": (test) ->
    css = parser.parse("body {}")
    test.same(css.rules[0].selectors[0].selector, "body")
    test.done()

  "test parsing id selector": (test) ->
    css = parser.parse("#body {}")
    test.same(css.rules[0].selectors[0].selector, "#body")
    test.done()

  "test parsing class selector": (test) ->
    css = parser.parse(".body {}")
    test.same(css.rules[0].selectors[0].selector, ".body")
    test.done()

  "test it parsing multiple selectors": (test) ->
    css = parser.parse("body, div {}")
    test.same(css.rules[0].selectors[0].selector, "body")
    test.same(css.rules[0].selectors[1].selector, "div")
    test.done()

  "test compound selections": (test) ->
    css = parser.parse("div#hello.some.thing, other {}")
    test.same(css.rules[0].selectors[0].selector, "div#hello.some.thing")
    test.same(css.rules[0].selectors[1].selector, "other")
    test.done()

  "test it should mix correctly multiple and compound": (test) ->
    css = parser.parse("#menu body, ul > li {}")
    test.same(css.rules[0].selectors[0].selector, "#menu")

    test.same(css.rules[0].selectors[0].next.selector, "body")
    test.same(css.rules[0].selectors[0].nextRule, " ")


    test.same(css.rules[0].selectors[1].selector, "ul")

    test.same(css.rules[0].selectors[1].next.selector, "li")
    test.same(css.rules[0].selectors[1].nextRule, ">")
    test.done()

  "test it parsing compound rules": (test) ->
    separators = [" ", ">", "+", "~"]

    for sep in separators
      css = parser.parse("body #{sep} div {}")
      test.same(css.rules[0].selectors[0].selector, "body")
      test.same(css.rules[0].selectors[0].next.selector, "div")
      test.same(css.rules[0].selectors[0].nextRule, sep)

    test.done()

  "test it parsing compound multiple": (test) ->
    separators = [">", "+", "~"]

    for sep in separators
      css = parser.parse("body #{sep} div #{sep} p {}")
      test.same(css.rules[0].selectors[0].selector, "body")
      test.same(css.rules[0].selectors[0].next.selector, "div")
      test.same(css.rules[0].selectors[0].nextRule, sep)
      test.same(css.rules[0].selectors[0].next.next.selector, "p")
      test.same(css.rules[0].selectors[0].next.nextRule, sep)

    test.done()

  "test it split multiple rules": (test) ->
    css = parser.parse("body, div {}")
    test.same(css.rules[0].selectors[0].selector, "body")
    test.same(css.rules[0].selectors[1].selector, "div")
    test.done()

  "test it parsing attribute selectors": (test) ->
    operators = ["=", "~=", "|=", "^=", "$=", "*="]

    for op in operators
      css = parser.parse("input[type#{op}text] {}")
      attr = css.rules[0].selectors[0].attributes
      test.same(attr.name,     "type")
      test.same(attr.operator, op)
      test.same(attr.value.value,    "text")

    test.done()

  "test it parsing simple metaselector": (test) ->
    css = parser.parse("body:before {}")
    test.same(css.rules[0].selectors[0].selector, "body")
    test.same(css.rules[0].selectors[0].meta.string(), ":before")
    test.done()

  "test it parsing metaselector": (test) ->
    css = parser.parse("body::slot(a) {}")
    test.same(css.rules[0].selectors[0].selector, "body")
    test.same(css.rules[0].selectors[0].meta.string(), "::slot(a)")
    test.done()

  "test simple attribute": (test) ->
    css = parser.parse("body {background: #fff}")
    test.same(css.rules[0].attributes[0].name, "background")
    test.same(css.rules[0].attributes[0].value(), "#fff")
    test.done()

  "test attributes hash": (test) ->
    css = parser.parse("body {background: #fff; display: none; background: #000;}")
    test.same(css.rules[0].attributesHash["background"].value(), "#000")
    test.same(css.rules[0].attributesHash["display"].value(), "none")
    test.done()

  "test multiple values": (test) ->
    css = parser.parse("body {background: #fff; color: #000;}")
    test.same(css.rules[0].attributes[0].name, "background")
    test.same(css.rules[0].attributes[0].value(), "#fff")
    test.same(css.rules[0].attributes[1].name, "color")
    test.same(css.rules[0].attributes[1].value(), "#000")
    test.done()

  "test unit value": (test) ->
    css = parser.parse("body {margin: 10px;}")
    test.same(css.rules[0].attributes[0].value(), "10px")
    test.same(css.rules[0].attributes[0].values[0].number, 10)
    test.same(css.rules[0].attributes[0].values[0].unit, "px")
    test.done()

  "test identifier value": (test) ->
    css = parser.parse("body {background: white;}")
    test.same(css.rules[0].attributes[0].value(), "white")
    test.done()

  "test string value": (test) ->
    css = parser.parse("body {font-family: 'Times New Roman';}")
    test.same(css.rules[0].attributes[0].value(), "'Times New Roman'")
    test.same(css.rules[0].attributes[0].values[0].text, "Times New Roman")
    test.done()

  "test 3 digit hex number value": (test) ->
    css = parser.parse("body {color: #f00;}")
    test.same(css.rules[0].attributes[0].value(), "#f00")
    test.done()

  "test 6 digit hex number value": (test) ->
    css = parser.parse("body {color: #f00f12;}")
    test.same(css.rules[0].attributes[0].value(), "#f00f12")
    test.done()

  "test number value": (test) ->
    css = parser.parse("body {margin: 0;}")
    test.same(css.rules[0].attributes[0].value(), "0")
    test.done()

  "test unit number value": (test) ->
    css = parser.parse("body {margin: 10px;}")
    test.same(css.rules[0].attributes[0].value(), "10px")
    test.done()

  "test function value": (test) ->
    css = parser.parse("body {margin: minmax(100px, 200px);}")
    test.same(css.rules[0].attributes[0].values[0].name, "minmax")
    test.same(css.rules[0].attributes[0].values[0].argumentsString(), "100px,200px")
    test.done()

  "test function with multi-item params": (test) ->
    css = parser.parse("body {background: gradient(linear, left top, left bottom);}")
    test.same(css.rules[0].attributes[0].values[0].name, "gradient")
    test.same(css.rules[0].attributes[0].values[0].arguments[0].string(), "linear")
    test.same(css.rules[0].attributes[0].values[0].arguments[1].string(), "left top")
    test.same(css.rules[0].attributes[0].values[0].arguments[2].string(), "left bottom")
    test.done()

  "test IE filter function": (test) ->
    # css = parser.parse("body {filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#f4f4f4',endColorstr='#ececec');}")
    # test.same(css.rules[0].attributes[0].values[0].name, "progid:DXImageTransform.Microsoft.gradient")
    # test.same(css.rules[0].attributes[0].values[0].arguments[0].string(), "GradientType=0")
    # test.same(css.rules[0].attributes[0].values[0].arguments[0].string(), "startColorstr='#f4f4f4'")
    # test.same(css.rules[0].attributes[0].values[0].arguments[0].string(), "endColorstr='#ececec'")
    test.done()


  "test url function": (test) ->
    css = parser.parse("body {background: url(../testing/file.png)}")
    test.same(css.rules[0].attributes[0].values[0].name, "url")
    test.same(css.rules[0].attributes[0].values[0].argumentsString(), "../testing/file.png")
    test.done()

  "test full complex attribute": (test) ->
    css = parser.parse("body {display: 'aaa' / 20px 'bcc' 100px * minmax(80px, 120px);}")
    test.same(css.rules[0].attributes[0].value(), "'aaa' / 20px 'bcc' 100px * minmax(80px,120px)")
    test.done()

  "test multi-item value": (test) ->
    css = parser.parse("body {display: a, b, c d;}")
    test.same(css.rules[0].attributes[0].values[0].string(), "a, b, c")
    test.same(css.rules[0].attributes[0].values[1].string(), "d")
    test.done()

  "test selector generating string": (test) ->
    selector = new ast.SelectorNode("body")
    selector.nestSelector(
      new ast.SelectorNode(
        "p",
        new ast.AttributeSelectorNode("type", "=", new ast.LiteralNode("text")),
        new ast.MetaSelectorNode(new ast.LiteralNode("before"), ":")
      ),
      ">")

    test.same(selector.string(), "body > p[type=text]:before")
    test.done()

  "test compiling a full sized css": (test) ->
    fixturesDir = "#{__dirname}/fixtures/css_examples"

    fs.readdir fixturesDir, (err, files) ->
      for file in files
        filePath = "#{fixturesDir}/#{file}"
        fileContent = fs.readFileSync(filePath).toString()

        parser.parse(fileContent)

      test.done()

global.testWrapper(suite)
module.exports = suite
