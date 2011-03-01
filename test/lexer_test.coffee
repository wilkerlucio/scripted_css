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

Lexer = ScriptedCss.CssParser.Lexer

module "Lexer"

test "test simple identifier", ->
  tokens = Lexer.tokenize("body")
  same(tokens, [["IDENTIFIER", "body", 0]], "")

test "test skip comments", ->
  tokens = Lexer.tokenize("
    /* some comment * here */\n
    @media screen
  ")

  same(tokens, [
    ["@", "@", 1]
    ["IDENTIFIER", "media", 1]
    ["IDENTIFIER", "screen", 1]
  ])

test "test skip multiline comments", ->
  tokens = Lexer.tokenize("
    /*\n
      some multiline\n
      comment * /\n
      here\n
    */\n
    @media screen
  ")
  same(tokens, [
    ["@", "@", 5]
    ["IDENTIFIER", "media", 5]
    ["IDENTIFIER", "screen", 5]
  ])

test "test lexing selectors", ->
  tokens = Lexer.tokenize("div.some#id")
  same(tokens, [
    ["IDENTIFIER", "div.some#id", 0]
  ])

test "test some chain", ->
  tokens = Lexer.tokenize("* html .clearfix{height:1%;}")
  same(tokens, [
    ["IDENTIFIER", "*", 0]
    ["SELECTOR_OPERATOR", " ", 0]
    ["IDENTIFIER", "html", 0]
    ["SELECTOR_OPERATOR", " ", 0]
    ["IDENTIFIER", ".clearfix", 0]
    ["{", "{", 0]
    ["IDENTIFIER", "height", 0]
    [":", ":", 0]
    ["UNITNUMBER", "1%", 0]
    [";", ";", 0]
    ["}", "}", 0]
  ])

test "some tabs", ->
  tokens = Lexer.tokenize("\t\t\t#top     { position: a; }")
  same(tokens, [
    ["IDENTIFIER", "#top", 0]
    ["{", "{", 0]
    ["IDENTIFIER", "position", 0]
    [":", ":", 0]
    ["IDENTIFIER", "a", 0]
    [";", ";", 0]
    ["}", "}", 0]
  ])

separators = [' ', '+', ">", "~"]

for sep in separators
  (->
    separator = sep

    test "test lexing selector '#{separator}' separator", ->
      tokens = Lexer.tokenize("body #{separator} div , p")
      same(tokens[0][0], "IDENTIFIER")
      same(tokens[1][0], "SELECTOR_OPERATOR")
      same(tokens[1][1], separator)
      same(tokens[2][0], "IDENTIFIER")
      same(tokens[3][0], ",")
      same(tokens[4][0], "IDENTIFIER")
  )()

for operator in ["=", "~=", "|=", "^=", "$=", "*="]
  (->
    op = operator

    test "test lexing selector attributes #{op}", ->
      tokens = Lexer.tokenize("input[type#{op}text] {}")
      same(tokens, [
        ["IDENTIFIER", "input", 0]
        ["[", "[", 0]
        ["IDENTIFIER", "type", 0]
        [op, op, 0]
        ["IDENTIFIER", "text", 0]
        ["]", "]", 0]
        ["{", "{", 0]
        ["}", "}", 0]
      ])
  )()

test "test lexing meta selector without params", ->
  tokens = Lexer.tokenize("input:focus")
  same(tokens, [
    ["IDENTIFIER", "input", 0]
    [":", ":", 0]
    ["IDENTIFIER", "focus", 0]
  ])

test "test lexing meta selector with double colons", ->
  tokens = Lexer.tokenize("input::focus")
  same(tokens, [
    ["IDENTIFIER", "input", 0]
    ["::", "::", 0]
    ["IDENTIFIER", "focus", 0]
  ])

test "test lexing meta selector with params", ->
  tokens = Lexer.tokenize("field:custom(some , things) div")
  same(tokens, [
    ["IDENTIFIER", "field", 0]
    [":", ":", 0]
    ["IDENTIFIER", "custom", 0]
    ["(", "(", 0]
    ["IDENTIFIER", "some", 0]
    [",", ",", 0]
    ["IDENTIFIER", "things", 0]
    [")", ")", 0]
    ["SELECTOR_OPERATOR", " ", 0]
    ["IDENTIFIER", "div", 0]
  ])

test "test lexing basic attribute", ->
  tokens = Lexer.tokenize("{ margin-top: 10px }")
  same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "margin-top", 0]
    [":", ":", 0]
    ["UNITNUMBER", "10px", 0]
    ["}", "}", 0]
  ])

test "test lexing IE7 hack attribute", ->
  tokens = Lexer.tokenize("{ *margin-top: 10px }")
  same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "*margin-top", 0]
    [":", ":", 0]
    ["UNITNUMBER", "10px", 0]
    ["}", "}", 0]
  ])

test "test lexing urls", ->
  tokens = Lexer.tokenize("{ background: url ( ../some_crazy/url.gif?id=5 ) }")
  same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "background", 0]
    [":", ":", 0]
    ["IDENTIFIER", "url", 0]
    ["(", "(", 0]
    ["STRING", "'../some_crazy/url.gif?id=5'", 0]
    [")", ")", 0]
    ["}", "}", 0]
  ])

test "test lexing number units", ->
  tokens = Lexer.tokenize("{ margin: 50% 100pxx; }")
  same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "margin", 0]
    [":", ":", 0]
    ["UNITNUMBER", "50%", 0]
    ["NUMBER", "100", 0]
    ["IDENTIFIER", "pxx", 0]
    [";", ";", 0]
    ["}", "}", 0]
  ])

test "test lexing !important", ->
  tokens = Lexer.tokenize("{ margin: 5px !important}")
  same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "margin", 0]
    [":", ":", 0]
    ["UNITNUMBER", "5px", 0]
    ["IMPORTANT", "!important", 0]
    ["}", "}", 0]
  ])

test "test lexing complex function names", ->
  tokens = Lexer.tokenize("{filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#f4f4f4',endColorstr='#ececec');}")
  same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "filter", 0]
    [":", ":", 0]
    ["IDENTIFIER", "progid:DXImageTransform.Microsoft.gradient", 0]
    ["(", "(", 0]
    ["IDENTIFIER", "GradientType", 0]
    ["=", "=", 0]
    ["NUMBER", "0", 0]
    [",", ",", 0]
    ["IDENTIFIER", "startColorstr", 0]
    ["=", "=", 0]
    ["STRING", "'#f4f4f4'", 0]
    [",", ",", 0]
    ["IDENTIFIER", "endColorstr", 0]
    ["=", "=", 0]
    ["STRING", "'#ececec'", 0]
    [")", ")", 0]
    [";", ";", 0]
    ["}", "}", 0]
  ])

test "test lexing a multiline thing", ->
  css = "
    body {\n
      color: #333;\n
      background: #f6f6f6 url(../images/background.png);\n
    }
  "
  tokens = Lexer.tokenize(css)
  same(tokens, [
    ["IDENTIFIER", "body", 0]
    ["{", "{", 0]
    ["IDENTIFIER", "color", 1]
    [":", ":", 1]
    ["HEXNUMBER", "#333", 1]
    [";", ";", 1]
    ["IDENTIFIER", "background", 2]
    [":", ":", 2]
    ["HEXNUMBER", "#f6f6f6", 2]
    ["IDENTIFIER", "url", 2]
    ["(", "(", 2]
    ["STRING", "'../images/background.png'", 2]
    [")", ")", 2]
    [";", ";", 2]
    ["}", "}", 3]
  ])
