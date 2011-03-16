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
        return false unless values

        values = _.flatten(values)

        defaults =
          image:      $n "none"
          repeat:     $n "repeat"
          attachment: $n "scroll"
          position:   [$n("0%"), $n("0%")]
          clip:       $n "border-box"
          origin:     $n "padding-box"
          size:       $n "auto"

        result = {
          color:      [$n "transparent"]
          image:      []
          repeat:     []
          attachment: []
          position:   []
          clip:       []
          origin:     []
          size:       []
        }

        for layer in values
          continue if layer.value == ","
          result.color = [layer.color] if layer.color

          for key, value of defaults
            result[key].push($n(",")) unless result[key].length == 0
            result[key].push(layer[key] || value)

        $n("attribute", "#{attribute.name}-#{key}", _.flatten(value)) for key, value of result

    border:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "border")
        return false unless values

        items = []
        for key, item of values
          items.push(item) if item

        attributes = for dir, i in ["top", "right", "bottom", "left"]
          $n("attribute", "#{attribute.name}-#{dir}", items)

        attributes.push($n("attribute", "#{attribute.name}-image", [$n("none")])) # border specification says to reset border-image when setting border property
        attributes

    borderDirection:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "border")
        return false unless values

        defaults =
          color: $n "currentColor"
          style: $n "none"
          width: $n "medium"

        for key, value of defaults
          $n("attribute", "#{attribute.name}-#{key}", [values[key] || value])

    borderColor:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "border-color-attr")
        return false unless values

        comp = Expanders.helpers.computeDirections(values[0])

        for dir, i in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("border-#{dir}-color", [comp[i]])

    borderStyle:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "border-style-attr")
        return false unless values

        comp = Expanders.helpers.computeDirections(values[0])

        for dir, i in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("border-#{dir}-style", [comp[i]])

    borderWidth:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "border-width-attr")
        return false unless values

        comp = Expanders.helpers.computeDirections(values[0])

        for dir, i in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("border-#{dir}-width", [comp[i]])

    borderRadius:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "border-radius")
        return false unless values

        horizontal = ([h] for h, i in ScriptedCss.Expanders.helpers.computeDirections(values.horizontal))

        if values.vertical
          vertical = ScriptedCss.Expanders.helpers.computeDirections(values.vertical)
          horizontal[i].push(v) for v, i in vertical

        for dir, i in ["top-left", "top-right", "bottom-right", "bottom-left"]
          $n("attribute", "border-#{dir}-radius", horizontal[i])

    borderImage:
      explode: (attribute) ->
        values = ScriptedCss.parseAttributes(attribute.values, "border-image")
        return false unless values and !values.string

        defaults =
          source: $n "none"
          slice:  $n "100%"
          width:  $n "1"
          outset: $n "0"
          repeat: $n "stretch"

        for key, value of values
          $n("attribute", "border-image-#{key}", _.flatten([value || defaults[key]]))
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

  ScriptedCss.Nodes.AttributeSet.registerExpansion "background",    Expanders.background
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border",        Expanders.border
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-top",    Expanders.borderDirection
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-right",  Expanders.borderDirection
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-bottom", Expanders.borderDirection
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-left",   Expanders.borderDirection
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-color",  Expanders.borderColor
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-style",  Expanders.borderStyle
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-width",  Expanders.borderWidth
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-image",  Expanders.borderImage
  ScriptedCss.Nodes.AttributeSet.registerExpansion "border-radius", Expanders.borderRadius
  ScriptedCss.Nodes.AttributeSet.registerExpansion "font",          Expanders.font
  ScriptedCss.Nodes.AttributeSet.registerExpansion "list-style",    Expanders.listStyle
  ScriptedCss.Nodes.AttributeSet.registerExpansion "margin",        Expanders.margin
  ScriptedCss.Nodes.AttributeSet.registerExpansion "outline",       Expanders.outline
  ScriptedCss.Nodes.AttributeSet.registerExpansion "padding",       Expanders.padding
)(jQuery)
