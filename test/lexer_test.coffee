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

Lexer = require("scripted_css/parser/lexer")

suite = {}

suite["test simple identifier"] = (test) ->
  tokens = Lexer.tokenize("body")
  test.same(tokens, [["IDENTIFIER", "body", 0]])
  test.done()

suite["test skip comments"] = (test) ->
  tokens = Lexer.tokenize("
    /* some comment * here */\n
    @media screen
  ")

  test.same(tokens, [
    ["@", "@", 1]
    ["IDENTIFIER", "media", 1]
    ["IDENTIFIER", "screen", 1]
  ])
  test.done()

suite["test skip multiline comments"] = (test) ->
  tokens = Lexer.tokenize("
    /*\n
      some multiline\n
      comment * /\n
      here\n
    */\n
    @media screen
  ")
  test.same(tokens, [
    ["@", "@", 5]
    ["IDENTIFIER", "media", 5]
    ["IDENTIFIER", "screen", 5]
  ])
  test.done()

suite["test lexing selectors"] = (test) ->
  tokens = Lexer.tokenize("div.some#id")
  test.same(tokens, [
    ["IDENTIFIER", "div.some#id", 0]
  ])
  test.done()

separators = [' ', '+', ">", "~"]

for sep in separators
  (->
    separator = sep

    suite["test lexing selector '#{separator}' separator"] = (test) ->
      tokens = Lexer.tokenize("body #{separator} div , p")
      test.same(tokens[0][0], "IDENTIFIER")
      test.same(tokens[1][0], "SELECTOR_OPERATOR")
      test.same(tokens[1][1], separator)
      test.same(tokens[2][0], "IDENTIFIER")
      test.same(tokens[3][0], ",")
      test.same(tokens[4][0], "IDENTIFIER")

      test.done()
  )()

suite["test lexing meta selector without params"] = (test) ->
  tokens = Lexer.tokenize("input:focus")
  test.same(tokens, [
    ["IDENTIFIER", "input", 0]
    [":", ":", 0]
    ["IDENTIFIER", "focus", 0]
  ])
  test.done()

suite["test lexing meta selector with params"] = (test) ->
  tokens = Lexer.tokenize("field:custom(some , things) div")
  test.same(tokens, [
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
  test.done()

suite["test lexing basic attribute"] = (test) ->
  tokens = Lexer.tokenize("{ margin-top: 10px }")
  test.same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "margin-top", 0]
    [":", ":", 0]
    ["UNITNUMBER", "10px", 0]
    ["}", "}", 0]
  ])
  test.done()

suite["test lexing IE7 hack attribute"] = (test) ->
  tokens = Lexer.tokenize("{ *margin-top: 10px }")
  test.same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "*margin-top", 0]
    [":", ":", 0]
    ["UNITNUMBER", "10px", 0]
    ["}", "}", 0]
  ])
  test.done()

suite["test lexing urls"] = (test) ->
  tokens = Lexer.tokenize("{ background: url ( ../some_crazy/url.gif?id=5 ) }")
  test.same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "background", 0]
    [":", ":", 0]
    ["IDENTIFIER", "url", 0]
    ["(", "(", 0]
    ["STRING", "'../some_crazy/url.gif?id=5'", 0]
    [")", ")", 0]
    ["}", "}", 0]
  ])
  test.done()

suite["test lexing !important"] = (test) ->
  tokens = Lexer.tokenize("{ margin: 5px !important}")
  test.same(tokens, [
    ["{", "{", 0]
    ["IDENTIFIER", "margin", 0]
    [":", ":", 0]
    ["UNITNUMBER", "5px", 0]
    ["IMPORTANT", "!important", 0]
    ["}", "}", 0]
  ])
  test.done()

suite["text lexing complex function names"] = (test) ->
  tokens = Lexer.tokenize("{filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#f4f4f4',endColorstr='#ececec');}")
  test.same(tokens, [
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
  test.done()

global.testWrapper(suite)
module.exports = suite
