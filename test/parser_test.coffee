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

parse = ScriptedCss.CssParser.parse
ast   = ScriptedCss.Nodes

module "Parser"

test "parsing imports", ->
  css = parse("@import 'files.css';")
  contains(css.imports[0], {"href": "files.css"})

test "parsing font face", ->
  css = parse("@font-face { font-family: 'scarface'; src: url(scarface-webfont.eot); src: local('scarface'), url('scarface-webfont.ttf') format('truetype'); }")
  same(css.fonts[0].declarations[0].property, 'font-family')
  contains(css.fonts[0].declarations[0].expression[0], value: 'scarface')
  contains(css.fonts[0].declarations[1].expression[0], type: 'uri', value: 'scarface-webfont.eot')
  contains(css.fonts[0].declarations[2].expression[0], type: 'function', name: 'local', params: [type: "string", value: "scarface"])
  contains(css.fonts[0].declarations[2].expression[1], value: ',')
  contains(css.fonts[0].declarations[2].expression[2], type: 'uri', value: 'scarface-webfont.ttf')
  contains(css.fonts[0].declarations[2].expression[3], type: 'function', name: 'format', params: [type: "string", value: "truetype"])

test "parsing simple selector", ->
  css = parse("body {}")
  same(css.rules[0].selectors[0].element, "body")

test "parsing id selector", ->
  css = parse("#body {}")
  same(css.rules[0].selectors[0].element, "*")
  same(css.rules[0].selectors[0].qualifiers[0], type: 'id_selector', id: 'body')

test "parsing class selector", ->
  css = parse(".body {}")
  same(css.rules[0].selectors[0].element, "*")
  same(css.rules[0].selectors[0].qualifiers[0], type: 'class_selector', class: 'body')

test "parsing multiple selectors", ->
  css = parse("body, div {}")
  same(css.rules[0].selectors[0].element, "body")
  same(css.rules[0].selectors[1].element, "div")

test "compound selections", ->
  css = parse("div#hello.some.thing, other {}")
  same(css.rules[0].selectors[0].element, "div")
  contains(css.rules[0].selectors[0].qualifiers[0], id: "hello")
  contains(css.rules[0].selectors[0].qualifiers[1], class: "some")
  contains(css.rules[0].selectors[0].qualifiers[2], class: "thing")
  same(css.rules[0].selectors[1].element, "other")

test "mix correctly multiple and compound", ->
  css = parse("#menu body, ul > li {}")
  same(css.rules[0].selectors[0].combinator, " ")
  same(css.rules[0].selectors[0].left.element, "*")
  contains(css.rules[0].selectors[0].left.qualifiers[0], id: "menu")
  same(css.rules[0].selectors[0].right.element, "body")

  same(css.rules[0].selectors[1].combinator, ">")
  same(css.rules[0].selectors[1].left.element, "ul")
  same(css.rules[0].selectors[1].right.element, "li")

test "parsing compound rules", ->
  separators = [" ", ">", "+", "~"]

  for sep in separators
    css = parse("body #{sep} div {}")
    same(css.rules[0].selectors[0].combinator, sep)
    same(css.rules[0].selectors[0].left.element, "body")
    same(css.rules[0].selectors[0].right.element, "div")

test "parsing attribute selectors", ->
  operators = ["=", "~=", "|=", "^=", "$=", "*="]

  for op in operators
    css = parse("input[type#{op}text] {}")
    contains(css.rules[0].selectors[0].qualifiers[0], type: "attribute_selector", attribute: "type", operator: op, value: "text")

test "parsing simple metaselector", ->
  css = parse("body:before {}")
  same(css.rules[0].selectors[0].element, "body")
  contains(css.rules[0].selectors[0].qualifiers[0], type: "pseudo_selector", value: "before")

test "parsing metaselector function", ->
  css = parse("body::slot(a) {}")
  same(css.rules[0].selectors[0].element, "body")
  same(css.rules[0].selectors[0].qualifiers[0], type: "pseudo_selector", value: {type: "function", name: "slot", params: [{type: "ident", value: "a"}]})

test "parsing meta selector without tag", ->
  css = parse(":focus {}")
  same(css.rules[0].selectors[0].element, "*")
  contains(css.rules[0].selectors[0].qualifiers[0], type: "pseudo_selector", value: "focus")

test "parsing selector with a meta selector as nested one", ->
  css = parse("body :focus {}")
  same(css.rules[0].selectors[0].combinator, " ")
  same(css.rules[0].selectors[0].left.element, "body")
  same(css.rules[0].selectors[0].right.element, "*")
  contains(css.rules[0].selectors[0].right.qualifiers[0], type: "pseudo_selector", value: "focus")

# test "test simple attribute", ->
#   css = parser.parse("body {color: #fff}")
#   same(css.rules[0].attributes.items[0].name, "color")
#   same(css.rules[0].attributes.items[0].value(), "#fff")
#
# test "test attributes hash", ->
#   css = parser.parse("body {color: #fff; display: none; color: #000;}")
#   same(css.rules[0].attributes.hash["color"].value(), "#000")
#   same(css.rules[0].attributes.hash["display"].value(), "none")
#
# test "test multiple values", ->
#   css = parser.parse("body {background-color: #fff; color: #000;}")
#   same(css.rules[0].attributes.items[0].name, "background-color")
#   same(css.rules[0].attributes.items[0].value(), "#fff")
#   same(css.rules[0].attributes.items[1].name, "color")
#   same(css.rules[0].attributes.items[1].value(), "#000")
#
# test "test unit value", ->
#   css = parser.parse("body {testing: 10px;}")
#   same(css.rules[0].attributes.items[0].value(), "10px")
#   same(css.rules[0].attributes.items[0].values[0].number, 10)
#   same(css.rules[0].attributes.items[0].values[0].unit, "px")
#
# test "test identifier value", ->
#   css = parser.parse("body {color: white;}")
#   same(css.rules[0].attributes.items[0].value(), "white")
#
# test "test string value", ->
#   css = parser.parse("body {font-family: 'Times New Roman';}")
#   same(css.rules[0].attributes.items[0].value(), "'Times New Roman'")
#   same(css.rules[0].attributes.items[0].values[0].text, "Times New Roman")
#
# test "test 3 digit hex number value", ->
#   css = parser.parse("body {color: #f00;}")
#   same(css.rules[0].attributes.items[0].value(), "#f00")
#
# test "test 6 digit hex number value", ->
#   css = parser.parse("body {color: #f00f12;}")
#   same(css.rules[0].attributes.items[0].value(), "#f00f12")
#
# test "test number value", ->
#   css = parser.parse("body {margin: 0;}")
#   same(css.rules[0].attributes.items[0].value(), "0")
#
# test "test unit number value", ->
#   css = parser.parse("body {testing: 10px;}")
#   same(css.rules[0].attributes.items[0].value(), "10px")
#
# test "test function value", ->
#   css = parser.parse("body {margin: minmax(100px, 200px);}")
#   same(css.rules[0].attributes.items[0].values[0].name, "minmax")
#   same(css.rules[0].attributes.items[0].values[0].argumentsString(), "100px,200px")
#
# test "test function with multi-item params", ->
#   css = parser.parse("body {background-image: gradient(linear, left top, left bottom);}")
#   same(css.rules[0].attributes.items[0].values[0].name, "gradient")
#   same(css.rules[0].attributes.items[0].values[0].arguments[0].string(), "linear")
#   same(css.rules[0].attributes.items[0].values[0].arguments[1].string(), "left top")
#   same(css.rules[0].attributes.items[0].values[0].arguments[2].string(), "left bottom")
#
# test "test IE filter function", ->
#   css = parser.parse("body {filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#f4f4f4',endColorstr='#ececec');}")
#   same(css.rules[0].attributes.items[0].values[0].name, "progid:DXImageTransform.Microsoft.gradient")
#   same(css.rules[0].attributes.items[0].values[0].namedArguments["GradientType"].string(), "0")
#   same(css.rules[0].attributes.items[0].values[0].namedArguments["startColorstr"].string(), "'#f4f4f4'")
#   same(css.rules[0].attributes.items[0].values[0].namedArguments["endColorstr"].string(), "'#ececec'")
#
# test "test url function", ->
#   css = parser.parse("body {background-image: url(../testing/file.png)}")
#   same(css.rules[0].attributes.items[0].values[0].name, "url")
#   same(css.rules[0].attributes.items[0].values[0].argumentsString(), "'../testing/file.png'")
#
# test "test full complex attribute", ->
#   css = parser.parse("body {display: 'aaa' / 20px 'bcc' 100px * minmax(80px, 120px);}")
#   same(css.rules[0].attributes.items[0].value(), "'aaa' / 20px 'bcc' 100px * minmax(80px,120px)")
#
# test "test selector generating string", ->
#   selector = new ast.SelectorNode("body")
#   selector.nestSelector(
#     new ast.SelectorNode(
#       "p",
#       new ast.AttributeSelectorNode("type", "=", new ast.LiteralNode("text")),
#       new ast.MetaSelectorNode(new ast.LiteralNode("before"), ":")
#     ),
#     ">")
#
#   same(selector.string(), "body > p[type=text]:before")

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
