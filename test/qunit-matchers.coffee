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

window.contains = (object, properties) ->
    same(object[key], value, "object contains '#{key}' with value '#{value}'") for key, value of properties

window.cancelEvents = (callback) ->
  stub = sinon.stub(ScriptedCss, 'trigger')
  callback()
  stub.restore()

window.runAttributeTransaction = (obj, attribute, fn, start = null) ->
  oldValue = obj[attribute]
  obj[attribute] = start
  fn()
  obj[attribute] = oldValue

window.runMacro = (values, expression) ->
  css = ScriptedCss.Nodes.factory(ScriptedCss.CssParser.parse("* {test: #{values}}"))
  css.rules[0].declarations.declarations[0].expression.parse(expression)

window.testAddedAttributes = (attr, expected, step = 1) ->
  css = ScriptedCss.CssParser.parse "* {#{attr}}"
  css = ScriptedCss.Nodes.factory(css)

  attr = css.rules[0].declarations

  for item, i in expected
    same(attr.declarations[i + step].property, item[0])
    same(attr.declarations[i + step].expression.stringify(), item[1])

window.createStylesheet = (string) ->
  css = ScriptedCss.CssParser.parse(string)
  css = ScriptedCss.Nodes.factory(css)
  css
