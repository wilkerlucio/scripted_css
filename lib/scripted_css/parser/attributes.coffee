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

{Parser} = require "jison"

# some helpers, thanks for CoffeeScript source!
unwrap = /^function\s*\(\)\s*\{\s*return\s*([\s\S]*);\s*\}/

o = (patternString, action, options) ->
  patternString = patternString.replace /\s{2,}/g, ' '
  return [patternString, '$$ = $1;', options] unless action
  action = if match = unwrap.exec action then match[1] else "(#{action}())"
  action = action.replace /\bnew /g, '$&yy.'
  action = action.replace /\b(?:Block\.wrap|extend)\b/g, 'yy.$&'
  [patternString, "$$ = #{action};", options]

parser = new Parser(
  tokens: 'IDENTIFIER DEFINITION NUMBER || | [ ] { } * ? +'

  lex:
    macros:
      id: "[a-zA-Z-][a-zA-Z0-9-]*"

    rules: [
      ["\\s+",    "/* skip whitespaces */"]
      ["<{id}>",  "yytext = yytext.substring(1, yytext.length - 1); return 'DEFINITION'"]
      ["{id}",    "return 'IDENTIFIER'"]
      ["'[^']*'", "yytext = yytext.substring(1, yytext.length - 1); return 'IDENTIFIER'"]
      ["\\d+",    "return 'NUMBER'"]
      ["\\|\\|",  "return '||';"]
      ["\\|",     "return '|';"]
      ["\\[",     "return '[';"]
      ["\\]",     "return ']';"]
      ["\\{",     "return '{';"]
      ["\\}",     "return '}';"]
      ["\\*",     "return '*';"]
      ["\\?",     "return '?';"]
      ["\\+",     "return '+';"]
      [",",       "return ',';"]
      [".",       "return 'IDENTIFIER';"]
    ]

  bnf:
    Root: [
      ["e", "return $$"]
    ]

    e: [
      o "e || andOr",          -> new Optional($1, $3)
      o "andOr"
    ]

    andOr: [
      o "andOr | Value",       -> new Or($1, $3)
      o "andOr Value",         -> new And($1, $2)
      o "Value"
    ]

    Value: [
      o "ValueItem",           -> new Value($1)
      o "ValueItem Length",    -> new Value($1, $2)
      o "[ e ]",               -> new Value($2, new Quantity(1), true)
      o "[ e ] Length",        -> new Value($2, $4, true)
    ]

    ValueItem: [
      o "DEFINITION",          -> new Macro($1)
      o "IDENTIFIER",          -> new Literal($1)
      o "NUMBER",              -> new Literal($1)
      o ",",                   -> new Literal($1)
    ]

    Length: [
      o "*",                   -> new Quantity(0, -1)
      o "+",                   -> new Quantity(1, -1)
      o "?",                   -> new Quantity(0, 1)
      o "{ NUMBER }",          -> new Quantity(parseInt($2))
      o "{ NUMBER , NUMBER }", -> new Quantity(parseInt($2), parseInt($4))
    ]

  startSymbol: "Root"
)

module.exports = parser
