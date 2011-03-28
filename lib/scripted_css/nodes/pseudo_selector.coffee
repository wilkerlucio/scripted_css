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

class PseudoSelector extends ScriptedCss.Nodes.Base
  @parseNth = (fn) ->
    str = fn.params.stringify().replace(/\s+/g, "")
    pos = {slice: 0, index: 0}

    if match = str.match(/^([+-]?\d+)?n([+-]\d+)?$/)
      pos.slice = parseInt(match[1]) || 1
      pos.index = parseInt(match[2]) || 0
      return pos

    if match = str.match(/^([+-])n([+-]\d+)?$/)
      pos.slice = parseInt(match[1] + "1")
      pos.index = parseInt(match[2]) || 0
      return pos

    if match = str.match(/^[+-]?\d+$/)
      pos.index = parseInt(match[0])
      return pos

    if str == "odd"
      pos.slice = 2
      pos.index = 1
      return pos

    if str == "even"
      pos.slice = 2
      pos.index = 0
      return pos

    throw new TypeError("Can't parse #{str}")

  @checkNth = (distance, slice, index) ->
    if slice == 0
      return distance == index

    if slice > 0
      distance = distance % slice
      distance = distance - slice if index < 0
      return distance == index

    if slice < 0
      return distance < index

  @pseudos = {}
  @register = (id, matcher) -> @pseudos[id] = matcher

  constructor: (object) ->
    @init(object, "pseudo_selector")

    if _.isString(@value)
      @value = new ScriptedCss.Nodes.Identifier(type: "ident", value: @value, name: @value)
    else
      @value = @factory(@value)

    @id = @symbol + @value.name

  match: (element) ->
    matcher = PseudoSelector.pseudos[@id]
    if matcher then matcher(element, @value) else false

  stringify: -> @symbol + @value.stringify()

  @register ":root",             (element) -> !element.parentNode
  @register ":nth-child",        (element, fn) ->
    distance = F.collectUntil("!x", '.previousSibling', F.collect('+1', 0))(element.previousSibling)
    info = PseudoSelector.parseNth(fn)
    PseudoSelector.checkNth(distance, info.slice, info.index)

  @register ":nth-last-child",   (element, fn) ->
    distance = F.collectUntil("!x", '.nextSibling', F.collect('+1', 0))(element.nextSibling)
    info = PseudoSelector.parseNth(fn)
    PseudoSelector.checkNth(distance, info.slice, info.index)

  @register ":nth-of-type",      (element, fn) ->
    col = (x, y) ->
      x += 1 if y.tagName == element.tagName
      x

    distance = F.collectUntil("!x", '.previousSibling', F.collect(col, 0))(element.previousSibling)
    info = PseudoSelector.parseNth(fn)
    PseudoSelector.checkNth(distance, info.slice, info.index)

  @register ":nth-last-of-type", (element, fn) ->
    col = (x, y) ->
      x += 1 if y.tagName == element.tagName
      x

    distance = F.collectUntil("!x", '.nextSibling', F.collect(col, 0))(element.nextSibling)
    info = PseudoSelector.parseNth(fn)
    PseudoSelector.checkNth(distance, info.slice, info.index)

  @register ":first-child",      (element) -> !element.previousSibling
  @register ":last-child",       (element) -> !element.nextSibling
  @register ":first-of-type",    (element) -> F.every(".tagName != '#{element.tagName}'", F.collectUntilLeaf(element, 'previousSibling'))
  @register ":last-of-type",     (element) -> F.every(".tagName != '#{element.tagName}'", F.collectUntilLeaf(element, 'nextSibling'))
  @register ":only-child",       (element) -> !element.previousSibling && !element.nextSibling
  @register ":only-of-type",     (element) -> F.every(".tagName != '#{element.tagName}'", F.collectUntilLeaf(element, "previousSibling").concat(F.collectUntilLeaf(element, "nextSibling")))
  @register ":empty",            (element) -> element.childNodes.length == 0
  @register ":enabled",          (element) -> !_.isString(element.getAttribute("disabled"))
  @register ":disabled",         (element) -> _.isString(element.getAttribute("disabled"))
  @register ":checked",          (element) -> _.isString(element.getAttribute("checked"))
  @register ":not",              (element, value) ->
    throw new TypeError(":not pseudo selectors needs to be a function") unless value.type == "function"
    selector = ScriptedCss.Nodes.factory(value.params)
    !selector.match(element)

window.ScriptedCss.Nodes.PseudoSelector = PseudoSelector if window?
