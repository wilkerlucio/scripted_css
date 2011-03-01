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
ast    = CssAST

module "Parser"

test "test it parsing metadata", ->
  css = parser.parse("@media screen")
  same(css.rules[0].name, "media")
  same(css.rules[0].value.string(), "screen")

test "test it parsing complex metadata", ->
  css = parser.parse("@font-face { font-family: 'scarface'; src: url(scarface-webfont.eot); src: local('scarface'), url('scarface-webfont.ttf') format('truetype'); }")
  same(css.rules[0].name, "font-face")
  same(css.rules[0].value.items[0].name, "font-family")
  same(css.rules[0].value.items[0].value(), "'scarface'")
  same(css.rules[0].value.items[1].name, "src")
  same(css.rules[0].value.items[1].value(), "url('scarface-webfont.eot')")
  same(css.rules[0].value.items[2].name, "src")
  same(css.rules[0].value.items[2].value(), "local('scarface'), url('scarface-webfont.ttf') format('truetype')")

test "test it parsing simple selector", ->
  css = parser.parse("body {}")
  same(css.rules[0].selector.string(), "body")

test "test parsing id selector", ->
  css = parser.parse("#body {}")
  same(css.rules[0].selector.string(), "#body")

test "test parsing class selector", ->
  css = parser.parse(".body {}")
  same(css.rules[0].selector.string(), ".body")

test "test it parsing multiple selectors", ->
  css = parser.parse("body, div { background: black }")
  same(css.rules[0].selector.string(), "body")
  same(css.rules[1].selector.string(), "div")
  same(css.rules[0].attributes.string(), "{ background: black }")
  same(css.rules[1].attributes.string(), "{ background: black }")

test "test compound selections", ->
  css = parser.parse("div#hello.some.thing, other {}")
  same(css.rules[0].selector.string(), "div#hello.some.thing")
  same(css.rules[1].selector.string(), "other")

test "test it should mix correctly multiple and compound", ->
  css = parser.parse("#menu body, ul > li {}")
  same(css.rules[0].selector.selector, "#menu")
  same(css.rules[0].selector.next.selector, "body")
  same(css.rules[0].selector.nextRule, " ")

  same(css.rules[1].selector.selector, "ul")
  same(css.rules[1].selector.next.selector, "li")
  same(css.rules[1].selector.nextRule, ">")

test "test it parsing compound rules", ->
  separators = [" ", ">", "+", "~"]

  for sep in separators
    css = parser.parse("body #{sep} div {}")
    same(css.rules[0].selector.selector, "body")
    same(css.rules[0].selector.next.selector, "div")
    same(css.rules[0].selector.nextRule, sep)


test "test it parsing compound multiple", ->
  separators = [">", "+", "~"]

  for sep in separators
    css = parser.parse("body #{sep} div #{sep} p {}")
    same(css.rules[0].selector.selector, "body")
    same(css.rules[0].selector.next.selector, "div")
    same(css.rules[0].selector.nextRule, sep)
    same(css.rules[0].selector.next.next.selector, "p")
    same(css.rules[0].selector.next.nextRule, sep)


test "test it split multiple rules", ->
  css = parser.parse("body, div {}")
  same(css.rules[0].selector.selector, "body")
  same(css.rules[1].selector.selector, "div")

test "test it parsing attribute selectors", ->
  operators = ["=", "~=", "|=", "^=", "$=", "*="]

  for op in operators
    css = parser.parse("input[type#{op}text] {}")
    attr = css.rules[0].selector.attributes
    same(attr.name,        "type")
    same(attr.operator,    op)
    same(attr.value.value, "text")


test "test it parsing simple metaselector", ->
  css = parser.parse("body:before {}")
  same(css.rules[0].selector.selector, "body")
  same(css.rules[0].selector.meta.string(), ":before")

test "test it parsing metaselector", ->
  css = parser.parse("body::slot(a) {}")
  same(css.rules[0].selector.selector, "body")
  same(css.rules[0].selector.meta.string(), "::slot(a)")

test "test it parsing meta selector without tag", ->
  css = parser.parse(":focus {}")
  same(css.rules[0].selector.selector, "*")
  same(css.rules[0].selector.meta.string(), ":focus")

test "test it parsing selector with a meta selector as nested one", ->
  css = parser.parse("body :focus {}")
  same(css.rules[0].selector.selector, "body")
  same(css.rules[0].selector.next.selector, "*")
  same(css.rules[0].selector.next.meta.string(), ":focus")

test "test simple attribute", ->
  css = parser.parse("body {background: #fff}")
  same(css.rules[0].attributes.items[0].name, "background")
  same(css.rules[0].attributes.items[0].value(), "#fff")

test "test attributes hash", ->
  css = parser.parse("body {background: #fff; display: none; background: #000;}")
  same(css.rules[0].attributes.hash["background"].value(), "#000")
  same(css.rules[0].attributes.hash["display"].value(), "none")

test "test multiple values", ->
  css = parser.parse("body {background: #fff; color: #000;}")
  same(css.rules[0].attributes.items[0].name, "background")
  same(css.rules[0].attributes.items[0].value(), "#fff")
  same(css.rules[0].attributes.items[1].name, "color")
  same(css.rules[0].attributes.items[1].value(), "#000")

test "test unit value", ->
  css = parser.parse("body {margin: 10px;}")
  same(css.rules[0].attributes.items[0].value(), "10px")
  same(css.rules[0].attributes.items[0].values[0].number, 10)
  same(css.rules[0].attributes.items[0].values[0].unit, "px")

test "test identifier value", ->
  css = parser.parse("body {background: white;}")
  same(css.rules[0].attributes.items[0].value(), "white")

test "test string value", ->
  css = parser.parse("body {font-family: 'Times New Roman';}")
  same(css.rules[0].attributes.items[0].value(), "'Times New Roman'")
  same(css.rules[0].attributes.items[0].values[0].text, "Times New Roman")

test "test 3 digit hex number value", ->
  css = parser.parse("body {color: #f00;}")
  same(css.rules[0].attributes.items[0].value(), "#f00")

test "test 6 digit hex number value", ->
  css = parser.parse("body {color: #f00f12;}")
  same(css.rules[0].attributes.items[0].value(), "#f00f12")

test "test number value", ->
  css = parser.parse("body {margin: 0;}")
  same(css.rules[0].attributes.items[0].value(), "0")

test "test unit number value", ->
  css = parser.parse("body {margin: 10px;}")
  same(css.rules[0].attributes.items[0].value(), "10px")

test "test function value", ->
  css = parser.parse("body {margin: minmax(100px, 200px);}")
  same(css.rules[0].attributes.items[0].values[0].name, "minmax")
  same(css.rules[0].attributes.items[0].values[0].argumentsString(), "100px,200px")

test "test function with multi-item params", ->
  css = parser.parse("body {background: gradient(linear, left top, left bottom);}")
  same(css.rules[0].attributes.items[0].values[0].name, "gradient")
  same(css.rules[0].attributes.items[0].values[0].arguments[0].string(), "linear")
  same(css.rules[0].attributes.items[0].values[0].arguments[1].string(), "left top")
  same(css.rules[0].attributes.items[0].values[0].arguments[2].string(), "left bottom")

test "test IE filter function", ->
  css = parser.parse("body {filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#f4f4f4',endColorstr='#ececec');}")
  same(css.rules[0].attributes.items[0].values[0].name, "progid:DXImageTransform.Microsoft.gradient")
  same(css.rules[0].attributes.items[0].values[0].namedArguments["GradientType"].string(), "0")
  same(css.rules[0].attributes.items[0].values[0].namedArguments["startColorstr"].string(), "'#f4f4f4'")
  same(css.rules[0].attributes.items[0].values[0].namedArguments["endColorstr"].string(), "'#ececec'")

test "test url function", ->
  css = parser.parse("body {background: url(../testing/file.png)}")
  same(css.rules[0].attributes.items[0].values[0].name, "url")
  same(css.rules[0].attributes.items[0].values[0].argumentsString(), "'../testing/file.png'")

test "test full complex attribute", ->
  css = parser.parse("body {display: 'aaa' / 20px 'bcc' 100px * minmax(80px, 120px);}")
  same(css.rules[0].attributes.items[0].value(), "'aaa' / 20px 'bcc' 100px * minmax(80px,120px)")

test "test multi-item value", ->
  css = parser.parse("body {display: a, b, c d;}")
  same(css.rules[0].attributes.items[0].values[0].string(), "a, b, c")
  same(css.rules[0].attributes.items[0].values[1].string(), "d")

test "test selector generating string", ->
  selector = new ast.SelectorNode("body")
  selector.nestSelector(
    new ast.SelectorNode(
      "p",
      new ast.AttributeSelectorNode("type", "=", new ast.LiteralNode("text")),
      new ast.MetaSelectorNode(new ast.LiteralNode("before"), ":")
    ),
    ">")

  same(selector.string(), "body > p[type=text]:before")

# uses to much time
# asyncTest "test compiling a full sized css", ->
#   examples = [
#     "coffeescript_docs.css"
#     "docco.css"
#     "github_common.css"
#   ]
#
#   total = examples.length
#
#   for example in examples
#     path = "fixtures/css_examples/#{example}"
#
#     $.ajax
#       url:      path
#       dataType: "text"
#       success:  (content) ->
#         parser.parse(content)
#       complete: ->
#         total -= 1
#         start() if total == 0
