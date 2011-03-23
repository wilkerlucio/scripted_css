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
  @register ":nth-child",        (element) -> false
  @register ":nth-last-child",   (element) -> false
  @register ":nth-of-type",      (element) -> false
  @register ":nth-last-of-type", (element) -> false
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
