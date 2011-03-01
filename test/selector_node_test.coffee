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

SelectorNode = CssAST.SelectorNode

module "Selector Node"

test "test spliting selector parts", ->
  selector = new SelectorNode("div#id.name.other")
  same(selector.parts(), ["div", "#id", ".name", ".other"])

test "test calculating selector weight use 1 for tag selection", ->
  selector = new SelectorNode("div")
  same(selector.weight(), 1)

test "test calculating selector weight use 10 for class selection", ->
  selector = new SelectorNode(".something")
  same(selector.weight(), 10)

test "test calculating selector weight use 100 for id selection", ->
  selector = new SelectorNode("#menu")
  same(selector.weight(), 100)

test "test calculating selector weight accumulate items", ->
  selector = new SelectorNode("div.name.other")
  same(selector.weight(), 21)

test "test calculating selector weight accumulate nested items", ->
  selector = new SelectorNode("#menu")
  selector.nestSelector(new SelectorNode("div.name.other"))
  same(selector.weight(), 121)
