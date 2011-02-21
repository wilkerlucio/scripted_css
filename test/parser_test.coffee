parser = require "scripted_css/parser"

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

  "test it parsing simple": (test) ->
    css = parser.parse("body:before {}")
    test.same(css.rules[0].selectors[0].selector, "body")
    test.same(css.rules[0].selectors[0].meta, "before")
    test.done()

  "test it parsing metaselector": (test) ->
    css = parser.parse("body::slot(a) {}")
    test.same(css.rules[0].selectors[0].selector, "body")
    test.same(css.rules[0].selectors[0].meta.name, "slot")
    test.same(css.rules[0].selectors[0].meta.argumentsString(), "a")
    test.done()

  "test simple attribute": (test) ->
    css = parser.parse("body {background: #fff}")
    test.same(css.rules[0].attributes[0].name, "background")
    test.same(css.rules[0].attributes[0].value(), "#fff")
    test.done()

  "test multiple values": (test) ->
    css = parser.parse("body {background: #fff; color: #000;}")
    test.same(css.rules[0].attributes[0].name, "background")
    test.same(css.rules[0].attributes[0].value(), "#fff")
    test.same(css.rules[0].attributes[1].name, "color")
    test.same(css.rules[0].attributes[1].value(), "#000")
    test.done()

  "test identifier value": (test) ->
    css = parser.parse("body {background: white;}")
    test.same(css.rules[0].attributes[0].value(), "white")
    test.done()

  "test string value": (test) ->
    css = parser.parse("body {font-family: 'Times New Roman';}")
    test.same(css.rules[0].attributes[0].value(), "'Times New Roman'")
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

  "test full complex attribute": (test) ->
    css = parser.parse("body {display: 'aaa' / 20px 'bcc' 100px * minmax(80px, 120px);}")
    test.same(css.rules[0].attributes[0].value(), "'aaa' / 20px 'bcc' 100px * minmax(80px,120px)")
    test.done()

global.testWrapper(suite)
module.exports = suite
