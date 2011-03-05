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

(($) ->
  concatImplode = (attributes, property, sulfixes) ->
    items = []

    for p in sulfixes
      attr = attributes.get("#{property}-#{p}")
      items.push(value) for value in attr.values if attr

    new CssAST.AttributeNode(property, items)

  window.ScriptedCss.Expanders = Expanders =
    helpers:
      computeDirections: (v) ->
        comp = null

        switch v.length
          when 1
            comp = [v[0], v[0], v[0], v[0]]
            break
          when 2
            comp = [v[0], v[1], v[0], v[1]]
            break
          when 3
            comp = [v[0], v[1], v[2], v[1]]
            break
          else
            comp = [v[0], v[1], v[2], v[3]]
            break

        comp

    background:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "background")
        # console.log(attribute.values)
        console.dir(values[0])
        return false unless values and !values.string

        defaults =
          color:      "transparent"
          image:      "none"
          repeat:     "repeat"
          attachment: "scroll"
          position:   "0% 0%"
          clip:       "border-box"
          origin:     "padding-box"
          size:       "auto"

        layers = []

    margin:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "margin")
        return false unless values and !values.string

        comp = Expanders.helpers.computeDirections(values[0])

        for dir, i in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("#{attribute.name}-#{dir}", [comp[i]])

    padding:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "padding")
        return false unless values and !values.string

        comp = Expanders.helpers.computeDirections(values[0])

        for dir, i in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("#{attribute.name}-#{dir}", [comp[i]])

    outline:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "outline")
        return false unless values and !values.string

        color = values.color || $n("invert")
        style = values.style || $n("none")
        width = values.width || $n("medium")

        [
          $n("attribute", "#{attribute.name}-color", [color])
          $n("attribute", "#{attribute.name}-style", [style])
          $n("attribute", "#{attribute.name}-width", [width])
        ]

    listStyle:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "list-style")
        return false unless values and !values.string

        image    = values.image    or $n("none")
        position = values.position or $n("outside")
        type     = values.type     or $n("disc")

        attributes = []
        attributes.push($n("attribute", "#{attribute.name}-image", [image]))
        attributes.push($n("attribute", "#{attribute.name}-position", [position]))
        attributes.push($n("attribute", "#{attribute.name}-type", [type]))

        attributes

    font:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "font")
        return false unless values and !values.string

        family     = values.family
        size       = values.size or $n("medium")
        style      = values.style or $n("normal")
        variant    = values.variant or $n("normal")
        weight     = values.weight or $n("normal")
        lineHeight = values.lineHeight

        attributes = []
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-family", family))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-size", [size]))
        attributes.push(new CssAST.AttributeNode("line-height", [lineHeight])) if lineHeight
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-style", [style]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-variant", [variant]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-weight", [weight]))

        attributes

  CssAST.AttributeSet.registerExpansion "background",    Expanders.background
  CssAST.AttributeSet.registerExpansion "border",        Expanders.simpleDirections
  CssAST.AttributeSet.registerExpansion "border-top",    Expanders.borderValue
  CssAST.AttributeSet.registerExpansion "border-right",  Expanders.borderValue
  CssAST.AttributeSet.registerExpansion "border-bottom", Expanders.borderValue
  CssAST.AttributeSet.registerExpansion "border-left",   Expanders.borderValue
  CssAST.AttributeSet.registerExpansion "border-color",  Expanders.sulfixDirections
  CssAST.AttributeSet.registerExpansion "border-style",  Expanders.sulfixDirections
  CssAST.AttributeSet.registerExpansion "border-width",  Expanders.sulfixDirections
  CssAST.AttributeSet.registerExpansion "font",          Expanders.font
  CssAST.AttributeSet.registerExpansion "list-style",    Expanders.listStyle
  CssAST.AttributeSet.registerExpansion "margin",        Expanders.margin
  CssAST.AttributeSet.registerExpansion "outline",       Expanders.outline
  CssAST.AttributeSet.registerExpansion "padding",       Expanders.padding
)(jQuery)
