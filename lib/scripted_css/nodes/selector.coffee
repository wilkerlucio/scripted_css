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

class Selector extends ScriptedCss.Nodes.Base
  constructor: (object) ->
    @init(object, "selector")

    @left  = @factory(@left)
    @right = @factory(@right)

  selections: -> @right.selections()

  weight: -> @left.weight() + @right.weight()

  match: (element) ->
    if element = @right.match(element)
      switch @combinator
        when ' '
          while element = element.parentNode
            return element if @left.match(element)

        when '>'
          return element if @left.match(element.parentNode)

        when '+'
          element = F.until(F.or('.nodeType == 1', F.not(F.I)), F.pluck("previousSibling"))(element.previousSibling)
          return element if @left.match(element)

        when '~'
          while element = element.previousSibling
            return element if @left.match(element)

    false

  stringify: ->
    combinator = if @combinator == " " then " " else " #{@combinator} "
    @left.stringify() + combinator + @right.stringify()

window.ScriptedCss.Nodes.Selector = Selector if window?
