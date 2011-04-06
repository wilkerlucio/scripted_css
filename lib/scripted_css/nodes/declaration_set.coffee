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

class DeclarationSet extends ScriptedCss.Nodes.Base
  @expanders = {}

  @registerExpansion: (property, expander) ->
    DeclarationSet.expanders[property] = expander

  constructor: (declarations) ->
    @type         = "declaration_set"
    @hash         = {}
    @declarations = []

    F.map(F.compose(@index.bind(this), @factory.bind(this)), declarations)

  get: (property) -> @hash[property] || null

  index: (declaration) ->
    unless @expandDeclaration(declaration)
      @declarations.push(declaration)
      @hash[declaration.property] = declaration

  expandDeclaration: (declaration) ->
    expander = DeclarationSet.expanders[declaration.property]
    return false unless expander

    expanded = expander.explode(declaration)
    return false unless expanded

    for dec in expanded
      dec = _.extend({"type": "declaration", important: declaration.important || false}, dec)
      @index(@factory(dec))

    true

  stringify: -> @stringifyArray(@declarations).join("; ")

window.ScriptedCss.Nodes.DeclarationSet = DeclarationSet if window?
