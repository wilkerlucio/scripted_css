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
    ScriptedCss.bind 'stylesheetDetailsIndexed', (css) => @parseCss(css)

  parseCss: (css) ->
    for attr in css.property("border-top-left-radius")
      attr.parent.add("-moz-border-radius-topleft", attr.expression, attr.important)
      attr.parent.add("-webkit-border-top-left-radius", attr.expression, attr.important)

    for attr in css.property("border-top-right-radius")
      attr.parent.add("-moz-border-radius-topright", attr.expression, attr.important)
      attr.parent.add("-webkit-border-top-right-radius", attr.expression, attr.important)

    for attr in css.property("border-bottom-right-radius")
      attr.parent.add("-moz-border-radius-bottomright", attr.expression, attr.important)
      attr.parent.add("-webkit-border-bottom-right-radius", attr.expression, attr.important)

    for attr in css.property("border-bottom-left-radius")
      attr.parent.add("-moz-border-radius-bottomleft", attr.expression, attr.important)
      attr.parent.add("-webkit-border-bottom-left-radius", attr.expression, attr.important)

ScriptedCss.Modules.register(ScriptedCss.Modules.BorderRadius)
