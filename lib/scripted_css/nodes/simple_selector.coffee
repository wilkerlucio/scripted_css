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

class SimpleSelector extends ScriptedCss.Nodes.Base
  constructor: (object) ->
    @init(object, "simple_selector")

    @qualifiers = _.map @qualifiers, _.bind(@factory, this)

  selections: ->
    _.reduce @qualifiers, ((memo, qualifier) ->
      memo.push(".#{qualifier.class}") if qualifier.type == "class_selector"
      memo.push("##{qualifier.id}")    if qualifier.type == "id_selector"
      memo
    ), [@element.toUpperCase()]

  weight: ->
    _.reduce @qualifiers, ((memo, qualifier) ->
      switch qualifier.type
        when 'id_selector'        then memo += 100
        when 'class_selector'     then memo += 10
        when 'attribute_selector' then memo += 10
        when 'pseudo_selector'    then memo += 1
        else memo
    ), if @element == "*" then 0 else 1

  match: (element) ->
    tagMatch = if @element == "*" then true else @element.toUpperCase() == element.tagName

    tagMatch && _.all(_.invoke(@qualifiers, 'match', element))

  stringify: -> @element + @stringifyArray(@qualifiers, '')

window.ScriptedCss.Nodes.SimpleSelector = SimpleSelector if window?
