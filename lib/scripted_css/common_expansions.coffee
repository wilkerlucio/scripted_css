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
        values = attribute.expression.parse("<background>")._result
        return false unless values

        defaults =
          image:      {type: "ident", value: "none"}
          repeat:     {type: "ident", value: "repeat"}
          attachment: {type: "ident", value: "scroll"}
          position:   [{type: "value", value: "0%"}, {type: "value", value: "0%"}]
          origin:     {type: "ident", value: "padding-box"}
          clip:       {type: "ident", value: "border-box"}
          size:       {type: "ident", value: "auto"}

        result = {
          color:      [{type: "ident", value: "transparent"]}
          image:      []
          repeat:     []
          attachment: []
          position:   []
          origin:     []
          clip:       []
          size:       []
        }

        for layer in values
          continue if layer.value == ","
          result.color = [layer.color] if layer.color

          for key, value of defaults
            result[key].push({type: "operator", value: ","}) unless result[key].length == 0
            result[key] = result[key].concat(_.flatten([layer[key] || value]))

        {property: "background-#{key}", expression: value} for key, value of result

    border:
      explode: (attribute) ->
        values = attribute.expression.parse("<border>")
        return false unless values._result

        items = []
        items.push(values.width) if values.width
        items.push(values.style) if values.style
        items.push(values.color) if values.color

        attributes = for dir, i in ["top", "right", "bottom", "left"]
          {property: "#{attribute.property}-#{dir}", expression: items}

        attributes.push({property: "#{attribute.property}-image", expression: [{type: "ident", value: "none"}]})
        attributes

    borderDirection:
      explode: (attribute) ->
        values = attribute.expression.parse("<border>")
        return false unless values._result

        defaults =
          color: {type: "ident", value: "currentColor"}
          style: {type: "ident", value: "none"}
          width: {type: "ident", value: "medium"}

        for key, value of defaults
          {property: "#{attribute.property}-#{key}", expression: [values[key] || value]}

    borderColor:
      explode: (attribute) ->
        values = attribute.expression.parse("<border-color-attr>")
        return false unless values._result

        comp = Expanders.helpers.computeDirections(values._result)

        for dir, i in ["top", "right", "bottom", "left"]
          {property: "border-#{dir}-color", expression: [comp[i]]}

    borderStyle:
      explode: (attribute) ->
        values = attribute.expression.parse("<border-style-attr>")
        return false unless values._result

        comp = Expanders.helpers.computeDirections(values._result)

        for dir, i in ["top", "right", "bottom", "left"]
          {property: "border-#{dir}-style", expression: [comp[i]]}

    borderWidth:
      explode: (attribute) ->
        values = attribute.expression.parse("<border-width-attr>")
        return false unless values._result

        comp = Expanders.helpers.computeDirections(values._result)

        for dir, i in ["top", "right", "bottom", "left"]
          {property: "border-#{dir}-width", expression: [comp[i]]}

    borderRadius:
      explode: (attribute) ->
        values = attribute.expression.parse("<border-radius>")
        return false unless values._result

        horizontal = ([h] for h, i in ScriptedCss.Expanders.helpers.computeDirections(values.horizontal))

        if values.vertical
          vertical = ScriptedCss.Expanders.helpers.computeDirections(values.vertical)
          horizontal[i].push(v) for v, i in vertical

        for dir, i in ["top-left", "top-right", "bottom-right", "bottom-left"]
          {property: "border-#{dir}-radius", expression: horizontal[i]}

    borderImage:
      explode: (attribute) ->
        values = attribute.expression.parse("<border-image>")
        return false unless values._result

        defaults =
          source: {type: "ident", value: "none"}
          slice:  {type: "value", value: "100%"}
          width:  {type: "value", value: "1"}
          outset: {type: "value", value: "0"}
          repeat: {type: "ident", value: "stretch"}

        for key, value of defaults
          {property: "border-image-#{key}", expression: _.flatten([values[key] || value])}

    margin:
      explode: (attribute) ->
        values = attribute.expression.parse("<margin>")
        return false unless values._result

        comp = Expanders.helpers.computeDirections(values._result)

        for dir, i in ["top", "right", "bottom", "left"]
          {property: "#{attribute.property}-#{dir}", expression: [comp[i]]}

    padding:
      explode: (attribute) ->
        values = attribute.expression.parse("<padding>")
        return false unless values._result

        comp = Expanders.helpers.computeDirections(values._result)

        for dir, i in ["top", "right", "bottom", "left"]
          {property: "#{attribute.property}-#{dir}", expression: [comp[i]]}

    outline:
      explode: (attribute) ->
        values = attribute.expression.parse("<outline>")
        return false unless values._result

        color = values.color or {type: "ident", value: "invert"}
        style = values.style or {type: "ident", value: "none"}
        width = values.width or {type: "ident", value: "medium"}

        [
          {property: "#{attribute.property}-color", expression: [color]}
          {property: "#{attribute.property}-style", expression: [style]}
          {property: "#{attribute.property}-width", expression: [width]}
        ]

    listStyle:
      explode: (attribute) ->
        values = attribute.expression.parse("<list-style>")
        return false unless values._result

        image    = values.image    or {type: "ident", value: "none"}
        position = values.position or {type: "ident", value: "outside"}
        type     = values.type     or {type: "ident", value: "disc"}

        [
          {property: "#{attribute.property}-image", expression: [image]}
          {property: "#{attribute.property}-position", expression: [position]}
          {property: "#{attribute.property}-type", expression: [type]}
        ]

    font:
      explode: (attribute) ->
        values = attribute.expression.parse("<font>")
        return false if !values._result or values._result.type == "ident"

        family     = values.family or [{type: "ident", value: "inherit"}]
        size       = values.size or {type: "ident", value: "medium"}
        style      = values.style or {type: "ident", value: "normal"}
        variant    = values.variant or {type: "ident", value: "normal"}
        weight     = values.weight or {type: "ident", value: "normal"}
        lineHeight = values.lineHeight

        attributes = []
        attributes.push({property: "#{attribute.property}-family", expression: family})
        attributes.push({property: "#{attribute.property}-size", expression: [size]})
        attributes.push({property: "line-height", expression: [lineHeight]}) if lineHeight
        attributes.push({property: "#{attribute.property}-style", expression: [style]})
        attributes.push({property: "#{attribute.property}-variant", expression: [variant]})
        attributes.push({property: "#{attribute.property}-weight", expression: [weight]})

        attributes

  ScriptedCss.Nodes.DeclarationSet.registerExpansion "background",    Expanders.background
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border",        Expanders.border
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-top",    Expanders.borderDirection
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-right",  Expanders.borderDirection
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-bottom", Expanders.borderDirection
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-left",   Expanders.borderDirection
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-color",  Expanders.borderColor
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-style",  Expanders.borderStyle
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-width",  Expanders.borderWidth
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-image",  Expanders.borderImage
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "border-radius", Expanders.borderRadius
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "font",          Expanders.font
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "list-style",    Expanders.listStyle
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "margin",        Expanders.margin
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "outline",       Expanders.outline
  ScriptedCss.Nodes.DeclarationSet.registerExpansion "padding",       Expanders.padding
)(jQuery)
