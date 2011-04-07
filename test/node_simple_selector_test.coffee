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

module "Simple Selector Node"

s = ScriptedCss.Nodes.SimpleSelector

test "initialize", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: [
      {
        type: "plain"
      }
    ]
  )

  same(sel.type, "simple_selector")
  same(sel.element, "*")
  ok(sel.qualifiers[0].plain)
  ok(sel.qualifiers[0].parent == sel)

test "selections", ->
  sel = new s(
    type: "simple_selector"
    element: "tag"
    qualifiers: [
      {
        type: "plain"
        stubType: "id_selector"
        id: "menu"
      }
      {
        type: "plain"
        stubType: "class_selector"
        class: "blue"
      }
    ]
  )

  same(sel.selections(), ["TAG", "#menu", ".blue"])

test "weight for * tag", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: [
    ]
  )

  equal(sel.weight(), 0)

test "weight for simple tag", ->
  sel = new s(
    type: "simple_selector"
    element: "tag"
    qualifiers: [
    ]
  )

  equal(sel.weight(), 1)

test "weight for class qualifier", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: [
      {
        type: "plain"
        stubType: "class_selector"
      }
    ]
  )

  equal(sel.weight(), 10)

test "weight for id qualifier", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: [
      {
        type: "plain"
        stubType: "id_selector"
      }
    ]
  )

  equal(sel.weight(), 100)

test "weight for pseudo qualifier", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: [
      {
        type: "plain"
        stubType: "pseudo_selector"
      }
    ]
  )

  equal(sel.weight(), 1)

test "weight for attribute qualifier", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: [
      {
        type: "plain"
        stubType: "attribute_selector"
      }
    ]
  )

  equal(sel.weight(), 10)

test "weight sum varios terms", ->
  sel = new s(
    type: "simple_selector"
    element: "body"
    qualifiers: [
      {
        type: "plain"
        stubType: "attribute_selector"
      }
      {
        type: "plain"
        stubType: "id_selector"
      }
      {
        type: "plain"
        stubType: "class_selector"
      }
      {
        type: "plain"
        stubType: "pseudo_selector"
      }
    ]
  )

  equal(sel.weight(), 122)

test "match element against tag *", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: []
  )

  el = $("<div />")[0]
  ok(sel.match(el))

test "match element against a real tag", ->
  sel = new s(
    type: "simple_selector"
    element: "span"
    qualifiers: []
  )

  el = $("<span />")[0]
  ok(sel.match(el))
  el = $("<div />")[0]
  ok(!sel.match(el))

test "match element with qualifiers", ->
  sel = new s(
    type: "simple_selector"
    element: "span"
    qualifiers: [
      {
        type: "plain"
        match: (element) -> element.className == "hi"
      }
      {
        type: "plain"
        match: -> true
      }
    ]
  )

  el = $("<span />", class: "hi")[0]
  ok(sel.match(el))
  el = $("<span />")[0]
  ok(!sel.match(el))
  el = $("<div />", class: "hi")[0]
  ok(!sel.match(el))

test "stringify", ->
  sel = new s(
    type: "simple_selector"
    element: "body"
    qualifiers: [
      {
        type: "plain"
        stringify: -> ".class"
      }
      {
        type: "plain"
        stringify: -> ".other"
      }
    ]
  )

  same(sel.stringify(), "body.class.other")

test "stringify simple", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: []
  )

  same(sel.stringify(), "*")

test "stringify global selector with qualifier", ->
  sel = new s(
    type: "simple_selector"
    element: "*"
    qualifiers: [
      {
        type: "plain"
        stringify: -> ".class"
      }
    ]
  )

  same(sel.stringify(), ".class")
