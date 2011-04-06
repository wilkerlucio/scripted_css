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

Nodes =
  factory: (object) ->
    if object.nodeInitialized
      result = object
    else
      result = switch object.type
        when "stylesheet"         then new Nodes.Stylesheet(object)
        when "import_rule"        then new Nodes.Import(object)
        when "media_rule"         then new Nodes.Media(object)
        when "keyframes"          then new Nodes.KeyFrames(object)
        when "keyframe_block"     then new Nodes.KeyFrameBlock(object)
        when "font-face"          then new Nodes.FontFace(object)
        when "page_rule"          then new Nodes.Page(object)
        when "ruleset"            then new Nodes.Rule(object)
        when "selector"           then new Nodes.Selector(object)
        when "simple_selector"    then new Nodes.SimpleSelector(object)
        when "id_selector"        then new Nodes.IdSelector(object)
        when "class_selector"     then new Nodes.ClassSelector(object)
        when "attribute_selector" then new Nodes.AttributeSelector(object)
        when "pseudo_selector"    then new Nodes.PseudoSelector(object)
        when "declaration"        then new Nodes.Declaration(object)
        when "function"           then new Nodes.Function(object)
        when "value"              then new Nodes.Value(object)
        when "uri"                then new Nodes.Uri(object)
        when "operator"           then new Nodes.Operator(object)
        when "string"             then new Nodes.String(object)
        when "ident"              then new Nodes.Identifier(object)
        when "hexcolor"           then new Nodes.Hexcolor(object)
        when "plain" # this one is just for test porpuses
          object.type = object.stubType if object.stubType
          object.plain = true
          object
        else throw new TypeError("can't factory type #{object.type}")

    result.parent = this
    result

window.ScriptedCss.Nodes = Nodes if window?
