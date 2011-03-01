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

class ScriptedCss.Modules.BorderRadius
  constructor: ->
    ScriptedCss.bind 'scriptLoaded', (css) => @parseCss(css)

  parseCss: (css) ->
    for attr in css.attribute("border-top-left-radius")
      attr.rule.attributes.add(ScriptedCss.createAttribute("-moz-border-radius-topleft", attr.value()))
      attr.rule.attributes.add(ScriptedCss.createAttribute("-webkit-border-top-left-radius", attr.value()))

    for attr in css.attribute("border-top-right-radius")
      attr.rule.attributes.add(ScriptedCss.createAttribute("-moz-border-radius-topright", attr.value()))
      attr.rule.attributes.add(ScriptedCss.createAttribute("-webkit-border-top-right-radius", attr.value()))

    for attr in css.attribute("border-bottom-right-radius")
      attr.rule.attributes.add(ScriptedCss.createAttribute("-moz-border-radius-bottomright", attr.value()))
      attr.rule.attributes.add(ScriptedCss.createAttribute("-webkit-border-bottom-right-radius", attr.value()))

    for attr in css.attribute("border-bottom-left-radius")
      attr.rule.attributes.add(ScriptedCss.createAttribute("-moz-border-radius-bottomleft", attr.value()))
      attr.rule.attributes.add(ScriptedCss.createAttribute("-webkit-border-bottom-left-radius", attr.value()))

ScriptedCss.Modules.register(ScriptedCss.Modules.BorderRadius)
CssAST.AttributeSet.registerExpansion "border-radius",
  explode: (attribute) ->
    v  = attribute.values
    v2 = null

    for value, i in v
      if value.string() == "/"
        v2 = v.slice(i + 1)
        v  = v.slice(0, i)
        break

    comp = ScriptedCss.Expanders.helpers.computeDirections(v)
    comp = ([c] for c in comp)

    if v2
      v2 = ScriptedCss.Expanders.helpers.computeDirections(v2)
      comp[i].push(vv) for vv, i in v2

    for dir, i in ["top-left", "top-right", "bottom-right", "bottom-left"]
      new CssAST.AttributeNode("border-#{dir}-radius", comp[i])

  implode: (attributes, property) ->
    items  = []
    items2 = []

    for dir in ["top-left", "top-right", "bottom-right", "bottom-left"]
      attr = attributes.get("border-#{dir}-radius")?.values[0] || new CssAST.LiteralNode("0")
      items.push(attr)

    items = ScriptedCss.Expanders.helpers.normalizeDirections(items)

    items.push(new CssAST.LiteralNode("/"))

    for dir in ["top-left", "top-right", "bottom-right", "bottom-left"]
      attr = attributes.get("border-#{dir}-radius")?.values[1] || new CssAST.LiteralNode("0")
      items2.push(attr)

    items2 = ScriptedCss.Expanders.helpers.normalizeDirections(items2)
    items.push(item) for item in items2

    new CssAST.AttributeNode(property, items)
