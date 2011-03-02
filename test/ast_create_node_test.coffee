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

module "AST fast nodes"

test "creating rules node", ->
  node = $n("rules", [])
  same(node.type, "RULES")
  same(node.rules, [])

test "creating rule node", ->
  node = $n("rule", "body", [])
  same(node.type, "RULE")
  same(node.selector, "body")

test "creating attribute set", ->
  node = $n("attributes", null, [])
  same(node.type, "ATTRIBUTE_SET")

test "creating meta node", ->
  node = $n("meta", "media", $n("screen"))
  same(node.type, "META")
  same(node.name, "media")

test "creating selector node", ->
  node = $n("selector", "body")
  same(node.type, "SELECTOR")
  same(node.selector, "body")

test "creating meta selector node", ->
  node = $n("meta-selector", $n("filter"), ":")
  same(node.type, "META_SELECTOR")
  same(node.value.string(), "filter")
  same(node.operator, ":")

test "creating attribute node", ->
  node = $n("attribute", "display", [$n("none")])
  same(node.type, "ATTRIBUTE")
  same(node.name, "display")
  same(node.value(), "none")

test "creating function node", ->
  node = $n("function", "url", [$n("string", "something.png")])
  same(node.type, "FUNCTION")
  same(node.name, "url")
  same(node.arguments.length, 1)

test "creating attribute selector node", ->
  node = $n("attribute-selector", "type", "=", $n("text"))
  same(node.type, "ATTRIBUTE_SELECTOR")
  same(node.string(), "type=text")

test "creating string node", ->
  node = $n("string", "test")
  same(node.type, "STRING")
  same(node.text, "test")

test "creating named argument node", ->
  node = $n("arg", "test", $n("thing"))
  same(node.type, "NAMED_ARGUMENT")
  same(node.string(), "test=thing")

test "creating important node", ->
  node = $n("important", true)
  same(node.type, "IMPORTANT")

test "creating literal node", ->
  node = $n("literal", "literal")
  same(node.type, "LITERAL")
  same(node.value, "literal")

test "creating number node", ->
  node = $n("number", "5")
  same(node.type, "NUMBER")
  same(node.value, "5")

test "creating unit number node", ->
  node = $n("unit", "5px")
  same(node.type, "UNIT_NUMBER")
  same(node.value, "5px")

test "creating hex number node", ->
  node = $n("hex", "#000")
  same(node.type, "HEXNUMBER")
  same(node.value, "#000")

test "creating multi value node", ->
  node = $n("multi-value", [$n("one"), $n("two")], ",")
  same(node.type, "MULTI_VALUE")
  same(node.separator, ",")
  same(node.literals.length, 2)

test "alias recognition for literals", ->
  node = $n("literal")
  same(node.type, "LITERAL")
  same(node.value, "literal")

test "alias recognition for important", ->
  node = $n("!")
  same(node.type, "IMPORTANT")

test "alias recognition for numbers", ->
  node = $n("5")
  same(node.type, "NUMBER")
  same(node.value, "5")

test "alias recognition for unit numbers", ->
  node = $n("5px")
  same(node.type, "UNIT_NUMBER")
  same(node.value, "5px")

test "alias recognition for hex numbers", ->
  node = $n("#000")
  same(node.type, "HEXNUMBER")
  same(node.value, "#000")

test "alias recognition for multi value", ->
  node = $n([$("one"), $n("two")], ",")
  same(node.type, "MULTI_VALUE")
  same(node.literals.length, 2)
