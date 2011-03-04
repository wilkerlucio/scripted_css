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

module "Attribute Node"

test "it should remove !important but set it as important and append again on string", ->
  css = parser.parse "body { display: none !important }"
  attribute = css.rules[0].attributes.items[0]

  same(attribute.values.length, 1)
  same(attribute.important, true)
  same(attribute.value(), "none")
  same(attribute.value(true), "none !important")
  same(attribute.string(), "display: none !important")

test "calculating weight", ->
  css = parser.parse "body.something { attr: value }"
  same(css.rules[0].attributes.items[0].weight(), 11)

test "calculating weight when its important", ->
  css = parser.parse "body.something { attr: value !important }"
  same(css.rules[0].attributes.items[0].weight(), 1011)
