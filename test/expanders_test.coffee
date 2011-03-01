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

module "Common Expansions"

parser    = ScriptedCss.CssParser

testExpansion = (attr, expected) ->
  css  = parser.parse "* {#{attr}}"
  attr = css.rules[0].attributes

  for item, i in expected
    same(attr.items[i].name,    item[0])
    same(attr.items[i].value(), item[1])

testImplosion = (attrs, expected) ->
  css  = parser.parse "* {#{attrs}}"
  attr = css.rules[0].attributes

  same(attr.get(expected[0]).value(), expected[1])

test "test expanding background", ->
  testExpansion "background: #000 url('test.gif') no-repeat fixed center", [
    ["background-attachment", "fixed"]
    ["background-color",      "#000"]
    ["background-image",      "url('test.gif')"]
    ["background-position",   "center"]
    ["background-repeat",     "no-repeat"]
  ]

test "test imploding background", ->
  testImplosion(
    "background-color: #000; background-image: url('some.png'); background-repeat: repeat-x",
    ["background", "#000 url('some.png') repeat-x"]
  )

test "test expanding border", ->
  testExpansion "border: 1px solid #000", [
    ["border-top-color",    "#000"]
    ["border-top-style",    "solid"]
    ["border-top-width",    "1px"]
    ["border-right-color",  "#000"]
    ["border-right-style",  "solid"]
    ["border-right-width",  "1px"]
    ["border-bottom-color", "#000"]
    ["border-bottom-style", "solid"]
    ["border-bottom-width", "1px"]
    ["border-left-color",   "#000"]
    ["border-left-style",   "solid"]
    ["border-left-width",   "1px"]
  ]

for attribute in ["margin", "padding"]
  (->
    attr = attribute

    test "test expanding #{attr} with 1 value", ->
      testExpansion "#{attr}: 10px", [
        ["#{attr}-top",    "10px"]
        ["#{attr}-right",  "10px"]
        ["#{attr}-bottom", "10px"]
        ["#{attr}-left",   "10px"]
      ]

    test "test expanding #{attr} with 2 values", ->
      testExpansion "#{attr}: 10px 8px", [
        ["#{attr}-top",    "10px"]
        ["#{attr}-right",  "8px"]
        ["#{attr}-bottom", "10px"]
        ["#{attr}-left",   "8px"]
      ]

    test "test expanding #{attr} with 3 values", ->
      testExpansion "#{attr}: 10px 8px 6px", [
        ["#{attr}-top",    "10px"]
        ["#{attr}-right",  "8px"]
        ["#{attr}-bottom", "6px"]
        ["#{attr}-left",   "8px"]
      ]

    test "test expanding #{attr} with 4 values", ->
      testExpansion "#{attr}: 10px 8px 6px 4px", [
        ["#{attr}-top",    "10px"]
        ["#{attr}-right",  "8px"]
        ["#{attr}-bottom", "6px"]
        ["#{attr}-left",   "4px"]
      ]
  )()
