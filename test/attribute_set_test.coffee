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

module "Attribute Set"

test "test initializing attributes", ->
  css = parser.parse("body { margin-top: 10px }")
  attributes = css.rules[0].attributes
  same(attributes.items[0].name, "margin-top")
  same(attributes.items[0].value(), "10px")
  same(attributes.hash["margin-top"].name, "margin-top")

test "test expanding attributes", ->
  ast.AttributeSet.registerExpansion "expansion-test",
    explode: (attribute) ->
      values = attribute.values
      exploded = []

      for direction in ["top", "right", "bottom", "left"]
        exploded.push(new ast.AttributeNode("#{attribute.name}-#{direction}", values))

      exploded

    implode: (attributes, property) ->
      attributes.get("#{property}-top")

  css = parser.parse("body { expansion-test: 10px }")
  attributes = css.rules[0].attributes
  same(attributes.items.length, 4)
  same(attributes.items[0].name, "expansion-test-top")
  same(attributes.items[0].value(), "10px")
  same(attributes.items[1].name, "expansion-test-right")
  same(attributes.items[1].value(), "10px")
  same(attributes.items[2].name, "expansion-test-bottom")
  same(attributes.items[2].value(), "10px")
  same(attributes.items[3].name, "expansion-test-left")
  same(attributes.items[3].value(), "10px")
  same(attributes.hash['expansion-test-top'].value(), "10px")
  same(attributes.hash['expansion-test-right'].value(), "10px")
  same(attributes.hash['expansion-test-bottom'].value(), "10px")
  same(attributes.hash['expansion-test-left'].value(), "10px")
  same(attributes.get("expansion-test").value(), "10px")

  ast.AttributeSet.expansions = {} # reset expansions
