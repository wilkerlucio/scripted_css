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

parser = ScriptedCss.CssParser

testExpansion = (attr, expected) ->
  css  = parser.parse "* {#{attr}}"
  attr = css.rules[0].attributes

  equal(attr.items.length, expected.length)

  for item, i in expected
    same(attr.items[i].name,    item[0])
    same(attr.items[i].value(), item[1])

test "test expanding background", ->
  testExpansion "background: url('test.gif') center center / 50% no-repeat fixed padding-box border-box #000", [
    ["background-color",      "#000"]
    ["background-image",      "url('test.gif')"]
    ["background-repeat",     "no-repeat"]
    ["background-attachment", "fixed"]
    ["background-position",   "center center"]
    ["background-clip",       "padding-box"]
    ["background-origin",     "border-box"]
    ["background-size",       "50%"]
  ]

  testExpansion "background: transparent", [
    ["background-color",      "transparent"]
    ["background-image",      "none"]
    ["background-repeat",     "repeat"]
    ["background-attachment", "scroll"]
    ["background-position",   "0% 0%"]
    ["background-clip",       "border-box"]
    ["background-origin",     "padding-box"]
    ["background-size",       "auto"]
  ]

test "expanding multiple backgrounds", ->
  testExpansion "background: url('test.gif') no-repeat, #aaa url('other.gif') center repeat-x", [
    ["background-color",      "#aaa"]
    ["background-image",      "url('test.gif') , url('other.gif')"]
    ["background-repeat",     "no-repeat , repeat-x"]
    ["background-attachment", "scroll , scroll"]
    ["background-position",   "0% 0% , center"]
    ["background-clip",       "border-box , border-box"]
    ["background-origin",     "padding-box , padding-box"]
    ["background-size",       "auto , auto"]
  ]

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
    ["border-image-source", "none"]
    ["border-image-slice",  "100%"]
    ["border-image-width",  "1"]
    ["border-image-outset", "0"]
    ["border-image-repeat", "stretch"]
  ]

for property, value of {color: ["#000", "#111", "#222", "#333"], style: ["solid", "none", "dashed", "dotted"], width: ["2px", "3px", "4px", "5px"]}
  test "expanding border #{property} with 1 value", ->
    testExpansion "border-#{property}: #{value[0]}", [
      ["border-top-#{property}",    value[0]]
      ["border-right-#{property}",  value[0]]
      ["border-bottom-#{property}", value[0]]
      ["border-left-#{property}",   value[0]]
    ]

  test "expanding border #{property} with 2 values", ->
    testExpansion "border-#{property}: #{value[0]} #{value[1]}", [
      ["border-top-#{property}",    value[0]]
      ["border-right-#{property}",  value[1]]
      ["border-bottom-#{property}", value[0]]
      ["border-left-#{property}",   value[1]]
    ]

  test "expanding border #{property} with 3 values", ->
    testExpansion "border-#{property}: #{value[0]} #{value[1]} #{value[2]}", [
      ["border-top-#{property}",    value[0]]
      ["border-right-#{property}",  value[1]]
      ["border-bottom-#{property}", value[2]]
      ["border-left-#{property}",   value[1]]
    ]

  test "expanding border #{property} with 4 values", ->
    testExpansion "border-#{property}: #{value[0]} #{value[1]} #{value[2]} #{value[3]}", [
      ["border-top-#{property}",    value[0]]
      ["border-right-#{property}",  value[1]]
      ["border-bottom-#{property}", value[2]]
      ["border-left-#{property}",   value[3]]
    ]

test "test expanding border radius with one value", ->
  testExpansion "border-radius: 10px", [
    ["border-top-left-radius",     "10px"]
    ["border-top-right-radius",    "10px"]
    ["border-bottom-right-radius", "10px"]
    ["border-bottom-left-radius",  "10px"]
  ]

test "test expanding border radius with two values", ->
  testExpansion "border-radius: 10px 5px", [
    ["border-top-left-radius",     "10px"]
    ["border-top-right-radius",    "5px"]
    ["border-bottom-right-radius", "10px"]
    ["border-bottom-left-radius",  "5px"]
  ]

test "test expanding border radius with three values", ->
  testExpansion "border-radius: 10px 5px 8px", [
    ["border-top-left-radius",     "10px"]
    ["border-top-right-radius",    "5px"]
    ["border-bottom-right-radius", "8px"]
    ["border-bottom-left-radius",  "5px"]
  ]

test "test expanding border radius with four values", ->
  testExpansion "border-radius: 10px 5px 8px 2px", [
    ["border-top-left-radius",     "10px"]
    ["border-top-right-radius",    "5px"]
    ["border-bottom-right-radius", "8px"]
    ["border-bottom-left-radius",  "2px"]
  ]

test "test expanding border radius with one second value", ->
  testExpansion "border-radius: 10px / 5px", [
    ["border-top-left-radius",     "10px 5px"]
    ["border-top-right-radius",    "10px 5px"]
    ["border-bottom-right-radius", "10px 5px"]
    ["border-bottom-left-radius",  "10px 5px"]
  ]

test "test expanding border radius with two second values", ->
  testExpansion "border-radius: 10px / 5px 8px", [
    ["border-top-left-radius",     "10px 5px"]
    ["border-top-right-radius",    "10px 8px"]
    ["border-bottom-right-radius", "10px 5px"]
    ["border-bottom-left-radius",  "10px 8px"]
  ]

test "test expanding border radius with three second values", ->
  testExpansion "border-radius: 10px / 5px 8px 4px", [
    ["border-top-left-radius",     "10px 5px"]
    ["border-top-right-radius",    "10px 8px"]
    ["border-bottom-right-radius", "10px 4px"]
    ["border-bottom-left-radius",  "10px 8px"]
  ]

test "test expanding border radius with four second values", ->
  testExpansion "border-radius: 10px / 5px 8px 4px 6px", [
    ["border-top-left-radius",     "10px 5px"]
    ["border-top-right-radius",    "10px 8px"]
    ["border-bottom-right-radius", "10px 4px"]
    ["border-bottom-left-radius",  "10px 6px"]
  ]

test "don't expand border-radius if it's invalid", ->
  testExpansion "border-radius: none", [
    ["border-radius", "none"]
  ]

test "expanding border-image", ->
  testExpansion "border-image: url(test.png) 50% fill / 10px / 5px round", [
    ["border-image-source", "url('test.png')"]
    ["border-image-slice",  "50% fill"]
    ["border-image-width",  "10px"]
    ["border-image-outset", "5px"]
    ["border-image-repeat", "round"]
  ]

for direction in ["top", "right", "bottom", "left"]
  (->
    dir = direction

    test "test expanding border-#{dir}", ->
      testExpansion "border-#{dir}: 1px solid #000", [
        ["border-#{dir}-color", "#000"]
        ["border-#{dir}-style", "solid"]
        ["border-#{dir}-width", "1px"]
      ]

      testExpansion "border-#{dir}: none", [
        ["border-#{dir}-color", "currentColor"]
        ["border-#{dir}-style", "none"]
        ["border-#{dir}-width", "medium"]
      ]
  )()

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

test "expanding list-style", ->
  testExpansion "list-style: square inside url('/images/blueball.gif');", [
    ["list-style-image",    "url('/images/blueball.gif')"]
    ["list-style-position", "inside"]
    ["list-style-type",     "square"]
  ]

test "expanding list-style with none", ->
  testExpansion "list-style: none;", [
    ["list-style-image",    "none"]
    ["list-style-position", "outside"]
    ["list-style-type",     "none"]
  ]

test "expanding outline", ->
  testExpansion "outline: #00ff00 dotted thick", [
    ["outline-color", "#00ff00"]
    ["outline-style", "dotted"]
    ["outline-width", "thick"]
  ]

test "expanding outline with none", ->
  testExpansion "outline: none", [
    ["outline-color", "invert"]
    ["outline-style", "none"]
    ["outline-width", "medium"]
  ]

test "expanding font", ->
  testExpansion "font: italic bold 12px/30px Georgia, serif", [
    ["font-family",  "Georgia , serif"]
    ["font-size",    "12px"]
    ["line-height",  "30px"]
    ["font-style",   "italic"]
    ["font-variant", "normal"]
    ["font-weight",  "bold"]
  ]

  testExpansion "font: Courier 12px;", [
    ["font-family",  "Courier"]
    ["font-size",    "12px"]
    ["font-style",   "normal"]
    ["font-variant", "normal"]
    ["font-weight",  "normal"]
  ]

  testExpansion "font: caption;", [
    ["font",  "caption"]
  ]
