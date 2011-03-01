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
    background:
      explode: (attribute) ->
        attachment = color = image = repeat = null
        position = []

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

        items = []
        items.push(new CssAST.AttributeNode("#{attribute.name}-attachment", [attachment]))       if attachment
        items.push(new CssAST.AttributeNode("#{attribute.name}-color", [color]))                 if color
        items.push(new CssAST.AttributeNode("#{attribute.name}-image", [image]))                 if image
        items.push(new CssAST.AttributeNode("#{attribute.name}-position", position.slice(0, 2))) if position.length > 0
        items.push(new CssAST.AttributeNode("#{attribute.name}-repeat", [repeat]))               if repeat

        items

      implode: (attributes, property) ->
        items = []

        for p in ["color", "image", "repeat", "attachment", "position"]
          attr = attributes.get("#{property}-#{p}")
          items.push(value) for value in attr.values if attr

        new CssAST.AttributeNode(property, items)

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

    borderValue:
      explode: (attribute) ->
        color = style = width = null

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

        attributes = []
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-color", [color])) if color
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-style", [style])) if style
        attributes.push(new CssAST.AttributeNode("#{attribute.name}-width", [width])) if width

        attributes

      implode: (attributes, property) ->
        items = []

        for part in ["width", "style", "color"]
          attr = attributes.get("#{property}-#{part}")
          items.push(attr.values[0]) if attr

        new CssAST.AttributeNode(property, items)

  CssAST.AttributeSet.registerExpansion "background",    Expanders.background
  CssAST.AttributeSet.registerExpansion "border",        Expanders.simpleDirections
  CssAST.AttributeSet.registerExpansion "border-top",    Expanders.borderValue
  CssAST.AttributeSet.registerExpansion "border-right",  Expanders.borderValue
  CssAST.AttributeSet.registerExpansion "border-bottom", Expanders.borderValue
  CssAST.AttributeSet.registerExpansion "border-left",   Expanders.borderValue
  CssAST.AttributeSet.registerExpansion "border-color",  Expanders.sulfixDirections
  CssAST.AttributeSet.registerExpansion "border-style",  Expanders.sulfixDirections
  CssAST.AttributeSet.registerExpansion "border-width",  Expanders.sulfixDirections
  CssAST.AttributeSet.registerExpansion "margin",        Expanders.directions
  CssAST.AttributeSet.registerExpansion "padding",       Expanders.directions
)(jQuery)
