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

# test "test expanding background", ->
#   testExpansion "background: #000 url('test.gif') no-repeat fixed center", [
#     ["background-attachment", "fixed"]
#     ["background-color",      "#000"]
#     ["background-image",      "url('test.gif')"]
#     ["background-position",   "center"]
#     ["background-repeat",     "no-repeat"]
#   ]
#
#   testExpansion "background: transparent", [
#     ["background-color", "transparent"]
#   ]
#
# test "expanding multiple backgrounds", ->
#   testExpansion "background: url('test.gif') no-repeat, #aaa url('other.gif') center repeat-x", [
#     ["background-color",    "#aaa"]
#     ["background-image",    "url('test.gif'), url('other.gif')"]
#     ["background-position", "0 0, center"]
#     ["background-repeat",   "no-repeat, repeat-x"]
#   ]

# test "test expanding border", ->
#   testExpansion "border: 1px solid #000", [
#     ["border-top-color",    "#000"]
#     ["border-top-style",    "solid"]
#     ["border-top-width",    "1px"]
#     ["border-right-color",  "#000"]
#     ["border-right-style",  "solid"]
#     ["border-right-width",  "1px"]
#     ["border-bottom-color", "#000"]
#     ["border-bottom-style", "solid"]
#     ["border-bottom-width", "1px"]
#     ["border-left-color",   "#000"]
#     ["border-left-style",   "solid"]
#     ["border-left-width",   "1px"]
#   ]
#
# for direction in ["top", "right", "bottom", "left"]
#   (->
#     dir = direction
#
#     test "test expanding border-#{dir}", ->
#       testExpansion "border-#{dir}: 1px solid #000", [
#         ["border-#{dir}-color", "#000"]
#         ["border-#{dir}-style", "solid"]
#         ["border-#{dir}-width", "1px"]
#       ]
#
#       testExpansion "border-#{dir}: none", [
#         ["border-#{dir}-color", ""]
#         ["border-#{dir}-style", "none"]
#         ["border-#{dir}-width", "medium"]
#       ]
#   )()
#
# for attribute in ["margin", "padding"]
#   (->
#     attr = attribute
#
#     test "test expanding #{attr} with 1 value", ->
#       testExpansion "#{attr}: 10px", [
#         ["#{attr}-top",    "10px"]
#         ["#{attr}-right",  "10px"]
#         ["#{attr}-bottom", "10px"]
#         ["#{attr}-left",   "10px"]
#       ]
#
#     test "test expanding #{attr} with 2 values", ->
#       testExpansion "#{attr}: 10px 8px", [
#         ["#{attr}-top",    "10px"]
#         ["#{attr}-right",  "8px"]
#         ["#{attr}-bottom", "10px"]
#         ["#{attr}-left",   "8px"]
#       ]
#
#     test "test expanding #{attr} with 3 values", ->
#       testExpansion "#{attr}: 10px 8px 6px", [
#         ["#{attr}-top",    "10px"]
#         ["#{attr}-right",  "8px"]
#         ["#{attr}-bottom", "6px"]
#         ["#{attr}-left",   "8px"]
#       ]
#
#     test "test expanding #{attr} with 4 values", ->
#       testExpansion "#{attr}: 10px 8px 6px 4px", [
#         ["#{attr}-top",    "10px"]
#         ["#{attr}-right",  "8px"]
#         ["#{attr}-bottom", "6px"]
#         ["#{attr}-left",   "4px"]
#       ]
#   )()

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

# test "expanding outline", ->
#   testExpansion "outline: #00ff00 dotted thick", [
#     ["outline-color", "#00ff00"]
#     ["outline-style", "dotted"]
#     ["outline-width", "thick"]
#   ]
#
#   testExpansion "outline: none", [
#     ["outline-color", "invert"]
#     ["outline-style", "none"]
#     ["outline-width", "medium"]
#   ]

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
