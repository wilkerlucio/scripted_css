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

# mini dsl for PEG.js
dslPeg = (source) ->
  parseValue = (item) -> if _.isFunction(item) then "{ #{extractFunction(item)} }" else item
  extractFunction = (fn) -> fn.toString().match(/^function\s*\(\)\s*\{\s*([\s\S]*)\n?\s*\}/)[1]

  rules = for rule, value of source
    if _.isArray(value)
      result = (parseValue(item) for item in value)
      result = result.join(" ")
    else
      result = parseValue(value)

    "#{rule}\n  = #{result}"

  rules.join("\n\n")

source = dslPeg(
  start: ["W exp:expression", -> exp]

  expression: [
    "  l:or '||' W r:expression", -> type: "multi", left: l, right: r
    "/ or"
  ]

  or: [
    "  l:and '|' W r:or", -> type: "or", left: l, right: r
    "/ and"
  ]

  and: [
    "  l:item W r:and", -> type: "and", left: l, right: r
    "/ item"
  ]

  item: [
    "lbl:LABEL? val:value len:length? W", -> type: "expression", value: val, quantity: len || [1, 1], label: lbl || null
  ]

  value: [
    "  '[' W exp:expression ']'", -> exp
    "/ '<' id:IDENT '>'", -> type: "macro", value: id
    "/ val:(IDENT / NUMBER / OPERATOR)", -> type: "value", value: val
  ]

  length: [
    "  '*'", -> [0, 0]
    "/ '+'", -> [1, 0]
    "/ '?'", -> [0, 1]
    "/ '{' W head:NUMBER W tail:(colon:',' W t:NUMBER? W {return t === \"\" ? 0 : t;})? '}'", ->
      [head, if tail != "" then tail else head]
  ]

  # Tokens

  NUMBER: ['n:SNUMBER', -> parseInt(n)]
  SNUMBER: '[0-9]+'
  OPERATOR: "'/' / ','"
  IDENT: ['h:[a-zA-Z] t:[a-zA-Z0-9-]*', -> h + t.join("")]
  LABEL: ['name:[a-zA-Z]+ ":"', -> name.join("")]
  S: '[ \\t\\r\\n]+'
  W: 'S?'
)

parser = PEG.buildParser(source)

window.ScriptedCss.ExpressionParser = parser
window.ScriptedCss.ExpressionParser.rawSource = PEG.parser.parse(source)
