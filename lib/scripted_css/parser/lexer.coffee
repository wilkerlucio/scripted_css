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

lexer =
  rules: [
    ["url",                                               "return 'URLIDENTIFIER';"]
    ["#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})\\b",               "return 'HEXNUMBER'"]
    ["-?\\d+(\\.\\d+)?(%|in|cm|mm|em|ex|pt|pc|px)",       "return 'UNITNUMBER'"]
    ["-?\\.\\d+(%|in|cm|mm|em|ex|pt|pc|px)",              "return 'UNITNUMBER'"]
    ["-?\\d+(\\.\\d+)?",                                  "return 'NUMBER'"]
    ["-?\\.\\d+",                                         "return 'NUMBER'"]
    ["[.#]?[a-zA-Z_-][a-zA-Z0-9_-]*[.#][a-zA-Z0-9.#_-]+", "return 'SELECTOR';"]
    ["[a-zA-Z_-][a-zA-Z0-9_-]*",                          "return 'IDENTIFIER';"]
    ["(\"[^\"]*\"|'[^']*')",                              "return 'STRING';"]
    ["\\s+",                                              "/* skip whitespaces */"]
    ["\\/\\*.*?\\*\\/",                                   "/* skip comments */"]
    ["\\@",                                               "return '@';"]
    ["\\$",                                               "return '$';"]
    ["\\+",                                               "return '+';"]
    ["\\{",                                               "return '{';"]
    ["\\}",                                               "return '}';"]
    ["\\(",                                               "return '(';"]
    ["\\)",                                               "return ')';"]
    ["\\[",                                               "return '[';"]
    ["\\]",                                               "return ']';"]
    ["\\<",                                               "return '<';"]
    ["\\>",                                               "return '>';"]
    ["\\^",                                               "return '^';"]
    ["\\?",                                               "return '?';"]
    ["\\&",                                               "return '&';"]
    ["\\!",                                               "return '!';"]
    ["\\~",                                               "return '~';"]
    ["=",                                                 "return '=';"]
    ["\\-",                                               "return '-';"]
    ["\\|",                                               "return '|';"]
    ["\\#",                                               "return '#';"]
    ["\\.",                                               "return '.';"]
    ["::",                                                "return '::';"]
    [":",                                                 "return ':';"]
    [";",                                                 "return ';';"]
    ["\\*",                                               "return '*';"]
    ["\\\\",                                              "return '\';"]
    ["\\/",                                               "return '/';"]
    [",",                                                 "return ',';"]
  ]

module.exports = lexer
