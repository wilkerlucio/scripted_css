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

module "Module - Border Radius"

parser = ScriptedCss.CssParser

testExpansion = (attr, expected) ->
  css  = parser.parse "* {#{attr}}"
  attr = css.rules[0].attributes

  for item, i in expected
    same(attr.items[i].name,    item[0])
    same(attr.items[i].value(), item[1])

testAddedAttributes = (attr, expected, step = 1) ->
  css  = parser.parse "* {#{attr}}"
  ScriptedCss.trigger("scriptLoaded", css)

  attr = css.rules[0].attributes

  for item, i in expected
    same(attr.items[i + step].name,    item[0])
    same(attr.items[i + step].value(), item[1])

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

test "adding browser specific rounded borders for top left", ->
  testAddedAttributes "border-top-left-radius: 5px", [
    ["-moz-border-radius-topleft",     "5px"]
    ["-webkit-border-top-left-radius", "5px"]
  ]

test "adding browser specific rounded borders for top right", ->
  testAddedAttributes "border-top-right-radius: 5px", [
    ["-moz-border-radius-topright",     "5px"]
    ["-webkit-border-top-right-radius", "5px"]
  ]

test "adding browser specific rounded borders for bottom right", ->
  testAddedAttributes "border-bottom-right-radius: 5px", [
    ["-moz-border-radius-bottomright",     "5px"]
    ["-webkit-border-bottom-right-radius", "5px"]
  ]

test "adding browser specific rounded borders for bottom left", ->
  testAddedAttributes "border-bottom-left-radius: 5px", [
    ["-moz-border-radius-bottomleft",     "5px"]
    ["-webkit-border-bottom-left-radius", "5px"]
  ]
