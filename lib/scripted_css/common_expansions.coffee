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
        defaults =
          color:      "transparent"
          image:      "none"
          repeat:     "repeat"
          attachment: "scroll"
          position:   "0% 0%"
          clip:       "border-box"
          origin:     "padding-box"
          size:       "auto"

        backgroundParser =
          grammar:
            "background":
              value:    "[<bg-layer> , ]* <final-bg-layer>"
              response: (r) -> r.get(0).push(r.get(1))

            "bg-layer":
              value:    "<bg-image> || <bg-position> [ / <bg-size> ]? || <repeat-style> || <attachment> || <box>{1,2}"
              response: (r) ->
                image:      r.get(0)
                position:   r.get(3)
                size:       r.get(4, 1)
                style:      r.get(6)
                attachment: r.get(8)
                origin:     r.get(10, 0)
                clip:       r.get(10, 1) || r.get(10, 0)

            "final-bg-layer":
              value:    "<bg-image> || <bg-position> [ / <bg-size> ]? || <repeat-style> || <attachment> || <box>{1,2} || <color>"
              response: (r) ->
                image:      r.get(0)
                position:   r.get(3)
                size:       r.get(4, 1)
                style:      r.get(6)
                attachment: r.get(8)
                origin:     r.get(10, 0)
                clip:       r.get(10, 1) || r.get(10, 0)
                color:      r.get(11)

            "bg-image":       "<image> | none"
            "repeat-style":   "repeat-x | repeat-y | [ repeat | space | round | no-repeat ]{1,2}"

            "image":
              value: "<url> | <image-list> | <element-reference> | <image-combination> | <gradient>"

            "url":
              value: (nodes) ->
                node = nodes[0]

                if node.type == "FUNCTION" and node.name == "url"
                  node
                else
                  false

        backgrounds   = attribute.groupMultiValues()
        expansions    = [] # store first expansion lopp
        modifications = {} # store modified attributes
        items         = [] # store final attributes

        for values, i in backgrounds
          attributes = {}
          last = i == backgrounds.length - 1

          for v in values
            if last # special rules for last item
              if v.type == "HEXNUMBER"
                items.push($n("attribute", "background-color", [v]))
              else if ScriptedCss.Utils.colors[v.string()]
                items.push($n("attribute", "background-color", [v]))

            switch v.type
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

        attachment = $n("scroll")
        color      = $n("transparent")
        image      = $n("none")
        repeat     = $n("repeat")
        position   = []

        position = [new CssAST.NumberNode("0"), new CssAST.NumberNode("0")] if position.length == 0

        items = []
        items.push(new CssAST.AttributeNode("#{attribute.name}-attachment", [attachment]))
        items.push(new CssAST.AttributeNode("#{attribute.name}-color", [color]))
        items.push(new CssAST.AttributeNode("#{attribute.name}-image", [image]))
        items.push(new CssAST.AttributeNode("#{attribute.name}-position", position.slice(0, 2)))
        items.push(new CssAST.AttributeNode("#{attribute.name}-repeat", [repeat]))

        items

    directions:
      explode: (attribute) ->
        v = attribute.values
        comp = Expanders.helpers.computeDirections(v)

        for dir, i in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("#{attribute.name}-#{dir}", [comp[i]])

    simpleDirections:
      explode: (attribute) ->
        for dir in ["top", "right", "bottom", "left"]
          new CssAST.AttributeNode("#{attribute.name}-#{dir}", attribute.values)

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

    borderValue:
      explode: (attribute) ->
        Expanders.line.explode(attribute, {width: "medium"})

    outline:
      explode: (attribute) ->
        Expanders.line.explode(attribute, {color: "invert", style: "none", width: "medium"})

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
  CssAST.AttributeSet.registerExpansion "margin",        Expanders.directions
  CssAST.AttributeSet.registerExpansion "outline",       Expanders.outline
  CssAST.AttributeSet.registerExpansion "padding",       Expanders.directions
)(jQuery)
