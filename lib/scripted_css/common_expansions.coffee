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
    background:
      explode: (attribute) ->
        attachment = new CssAST.LiteralNode("scroll")
        color      = new CssAST.LiteralNode("transparent")
        image      = new CssAST.LiteralNode("none")
        repeat     = new CssAST.LiteralNode("repeat")
        position   = []

        for v in attribute.values
          switch v.type
            when "HEXNUMBER"
              color = v
              break
            when "NUMBER"
              position.push(v)
              break
            when "UNIT_NUMBER"
              position.push(v)
              break
            when "FUNCTION"
              image = v
              break
            when "LITERAL"
              str = v.string()

              if ScriptedCss.Utils.backgroundAttachments[str]
                attachment = v
              else if ScriptedCss.Utils.backgroundRepeats[str]
                repeat = v
              else if ScriptedCss.Utils.backgroundPositions[str]
                position.push(v)
              else if ScriptedCss.Utils.colors[str]
                color = v

        position = [new CssAST.NumberNode("0"), new CssAST.NumberNode("0")] if position.length == 0

        items = []
        items.push(new CssAST.AttributeNode("#{attribute.name}-attachment", [attachment]))
        items.push(new CssAST.AttributeNode("#{attribute.name}-color", [color]))
        items.push(new CssAST.AttributeNode("#{attribute.name}-image", [image]))
        items.push(new CssAST.AttributeNode("#{attribute.name}-position", position.slice(0, 2)))
        items.push(new CssAST.AttributeNode("#{attribute.name}-repeat", [repeat]))

        items

      implode: (attributes, property) ->
        concatImplode attributes, property, ["color", "image", "repeat", "attachment", "position"]

    directions:
      explode: (attribute) ->
        v = attribute.values
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

        for dir, i in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("#{attribute.name}-#{dir}", [comp[i]])

      implode: (attributes, property) ->
        items = []

        for dir in ["top", "right", "bottom", "left"]
          attr = attributes.get("#{property}-#{dir}")?.values[0] || new CssAST.LiteralNode("0")
          items.push(attr)

        if items[0].string() == items[1].string() == items[2].string() == items[3].string()
          items = [items[0]]
        else if items[0].string() == items[2].string() and items[1].string() == items[3].string()
          items = [items[0], items[1]]
        else if items[1].string() == items[3].string()
          items = [items[0], items[1], items[2]]

        new CssAST.AttributeNode(property, items)

    simpleDirections:
      explode: (attribute) ->
        for dir in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("#{attribute.name}-#{dir}", attribute.values)

      implode: (attributes, property) ->
        new CssAST.AttributeNode(property, [new CssAST.LiteralNode("")])

    sulfixDirections:
      explode: (attribute) ->
        name   = attribute.name.split("-")
        sulfix = name.pop()
        name   = name.join("-")

        attr = new CssAST.AttributeNode(name, attribute.values)
        items = Expanders.directions.explode(attr)

        for item in items
          item.name = item.name + "-" + sulfix

        items

      implode: (attributes, property) ->
        new CssAST.AttributeNode(property, [new CssAST.LiteralNode("")])

    line:
      explode: (attribute, defaults = {}) ->
        for v in attribute.values
          switch v.type
            when "HEXNUMBER"
              color = v
              break
            when "NUMBER"
              width = v
              break
            when "UNIT_NUMBER"
              width = v
              break
            when "LITERAL"
              str = v.string()

              if ScriptedCss.Utils.colors[str]
                color = v
              else if ScriptedCss.Utils.borderStyles[str]
                style = v
              else if ScriptedCss.Utils.borderWidths[str]
                width = v
              else if str == "inherit"
                color = v unless color
                style = v unless style
                width = v unless width

        color = new CssAST.LiteralNode(defaults.color || "") unless color
        style = new CssAST.LiteralNode(defaults.style || "") unless style
        width = new CssAST.LiteralNode(defaults.width || "") unless width

        attributes = []
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-color", [color]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-style", [style]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-width", [width]))

        attributes

      implode: (attributes, property) ->
        concatImplode attributes, property, ["width", "style", "color"]

    borderValue:
      explode: (attribute) ->
        Expanders.line.explode(attribute, {width: "medium"})

      implode: (attributes, property) ->
        Expanders.line.implode(attributes, property)

    outline:
      explode: (attribute) ->
        Expanders.line.explode(attribute, {color: "invert", style: "none", width: "medium"})

      implode: (attributes, property) ->
        Expanders.line.implode(attributes, property)

    listStyle:
      explode: (attribute) ->
        image = position = type = null

        for v in attribute.values
          switch v.type
            when "FUNCTION"
              image = v
              break
            when "LITERAL"
              str = v.string()

              if ScriptedCss.Utils.listTypes[str]
                type = v
              else if ScriptedCss.Utils.listPositions[str]
                position = v
              else if str == "inherit" or str == "none"
                image    = v unless image
                position = v unless position or str == "none"
                type     = v unless type

        image    = new CssAST.LiteralNode("none") unless image
        position = new CssAST.LiteralNode("outside") unless position
        type     = new CssAST.LiteralNode("disc") unless type

        attributes = []
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-image", [image]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-position", [position]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-type", [type]))

        attributes

      implode: (attributes, property) ->
        concatImplode attributes, property, ["type", "position", "image"]

    font:
      explode: (attribute) ->
        family = size = line_height = style = variant = weight = null

        i = 0
        values = attribute.values

        while parts = values.slice(i)
          console.log(i)

          v = parts[0]
          break unless v

          switch v.type
            when "NUMBER"
              weight = v if ScriptedCss.Utils.fontWeights[v.string()]

              break
            when "UNIT_NUMBER"
              size = v

              if parts[1].string() == "/" and parts[2].type == "UNIT_NUMBER"
                line_height = parts[2]
                i += 2

              break
            when "STRING"
              family = v
              break
            when "MULTI_VALUE"
              family = v
              break
            when "LITERAL"
              str = v.string()

              if ScriptedCss.Utils.fontStyles[str]
                style = v
              else if ScriptedCss.Utils.fontSizes[str]
                size = v
              else if ScriptedCss.Utils.fontVariants[str]
                variant = v
              else if ScriptedCss.Utils.fontWeights[str]
                weight = v
              else if str == "inherit"
                family      = v unless family
                size        = v unless size
                line_height = v unless line_height
                style       = v unless style
                variant     = v unless variant
                weight      = v unless weight

          i += 1

        family      = new CssAST.LiteralNode("")       unless family
        size        = new CssAST.LiteralNode("medium") unless size
        style       = new CssAST.LiteralNode("normal") unless style
        variant     = new CssAST.LiteralNode("normal") unless variant
        weight      = new CssAST.LiteralNode("normal") unless weight

        attributes = []
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-family", [family]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-size", [size]))
        attributes.push(new CssAST.AttributeNode("line-height", [line_height])) if line_height
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-style", [style]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-variant", [variant]))
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-weight", [weight]))

        attributes

      implode: (attributes, property) ->

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
  CssAST.AttributeSet.registerExpansion "margin",        Expanders.directions
  CssAST.AttributeSet.registerExpansion "outline",       Expanders.outline
  CssAST.AttributeSet.registerExpansion "padding",       Expanders.directions
)(jQuery)
