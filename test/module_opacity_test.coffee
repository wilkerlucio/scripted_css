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

testAddedAttributes = (attr, expected, step = 1) ->
  css  = parser.parse "* {#{attr}}"
  ScriptedCss.trigger("scriptLoaded", css)

  attr = css.rules[0].attributes

  for item, i in expected
    same(attr.items[i + step].name,    item[0])
    same(attr.items[i + step].value(), item[1])

test "add IE filter", ->
  testAddedAttributes "opacity: .6", [
    ["filter", "progid:DXImageTransform.Microsoft.Alpha(opacity=60)"]
  ]
