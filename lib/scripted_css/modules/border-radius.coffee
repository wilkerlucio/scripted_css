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
      attr.rule.attributes.add($n("attribute", "-moz-border-radius-topleft", attr.values, attr.important))
      attr.rule.attributes.add($n("attribute", "-webkit-border-top-left-radius", attr.values, attr.important))

    for attr in css.attribute("border-top-right-radius")
      attr.rule.attributes.add($n("attribute", "-moz-border-radius-topright", attr.values, attr.important))
      attr.rule.attributes.add($n("attribute", "-webkit-border-top-right-radius", attr.values, attr.important))

    for attr in css.attribute("border-bottom-right-radius")
      attr.rule.attributes.add($n("attribute", "-moz-border-radius-bottomright", attr.values, attr.important))
      attr.rule.attributes.add($n("attribute", "-webkit-border-bottom-right-radius", attr.values, attr.important))

    for attr in css.attribute("border-bottom-left-radius")
      attr.rule.attributes.add($n("attribute", "-moz-border-radius-bottomleft", attr.values, attr.important))
      attr.rule.attributes.add($n("attribute", "-webkit-border-bottom-left-radius", attr.values, attr.important))

ScriptedCss.Modules.register(ScriptedCss.Modules.BorderRadius)
