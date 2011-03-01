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

  CssAST.AttributeSet.registerExpansion "margin", Expanders.directions
  CssAST.AttributeSet.registerExpansion "padding", Expanders.directions
)(jQuery)
