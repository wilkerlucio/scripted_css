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

IDENTIFIER = /^[a-zA-Z_-][a-zA-Z0-9_-]*/
METAID     = /^@([a-zA-Z_-][a-zA-Z0-9_-]*)/
SELECTOR   = /^([*]|[.#]?[a-zA-Z_-]([a-zA-Z0-9.#_-]*[a-zA-Z0-9_-])?)/
ATTRID     = /^[*]?[a-zA-Z_-][a-zA-Z0-9_-]*/
NEWLINE    = /^\n/
WHITESPACE = /^[^\n\S]+/
NUMBER     = /^-?(\d+(\.\d+)?|\.\d+)/
UNITNUMBER = /^-?(\d+(\.\d+)?|\.\d+)(%|(in|cm|mm|em|ex|pt|pc|px|ms|s)\b)/
HEXNUMBER  = /^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})\b/
STRING     = /^(?:"([^"]*)"|'([^']*)')/

COMMENT    = /^\/\*(.|\n)*?\*\//

OPERATORS  = /// ^ (
  ?: ::
   | [~|^$*]=
) ///

Lexer =
  tokenize: (code) ->
    code     = code.replace(/\r\n|\r/g, "\n")

    @code   = code
    @line   = 0
    @tokens = []
    @i      = 0
    @scope  = 'INITIAL'

    while @chunk = code.slice(@i)
      @i += @specialToken()    or
            @identifierToken() or
            @commentToken()    or
            @whitespaceToken() or
            @newlineToken()    or
            @stringToken()     or
            @numberToken()     or
            @literalToken()

    @tokens

  # CSS has some different rules for identifiers depending on context
  # this specialToken handles some of special cases needed
  specialToken: ->
    if @scope == "INITIAL" or @scope == "SELECTOR"
      if match = METAID.exec @chunk
        [input, id] = match
        @token("@", "@")
        @token("IDENTIFIER", id)
        @scope = "METASELECTOR"

        return input.length

      if match = SELECTOR.exec @chunk
        [input] = match
        @scope  = "SELECTOR"
        @token("IDENTIFIER", input)

        return input.length

    if @scope == "SELECTOR"
      if match = /^\[/.exec @chunk
        @token "[", "["
        @scope = "SELECTOR_ATTRIBUTE"

        return 1

      if match = /^\s*([+>~])\s*/.exec @chunk
        [input, operator] = match
        @token("SELECTOR_OPERATOR", operator)

        return input.length

      if match = /^(\s+)[^,{]/.exec @chunk
        [input, space] = match
        @token("SELECTOR_OPERATOR", ' ')

        return space.length

    if @scope == "SELECTOR_ATTRIBUTE"
      if match = /^\]/.exec @chunk
        @token "]", "]"
        @scope = "SELECTOR"

        return 1

    if @scope == "ATTRIBUTE_NAME"
      if match = ATTRID.exec @chunk
        [input] = match
        @token("IDENTIFIER", input)
        return input.length

    if @scope == "ATTRIBUTE_VALUE"
      if match = /^url\s*\(\s*([^'"].+?)\s*\)/.exec @chunk
        [input, value] = match
        @token("IDENTIFIER", "url")
        @token("(", "(")
        @token("STRING", "'#{value}'")
        @token(")", ")")

        return input.length

      if match = /^[!]important\b/.exec @chunk
        [input] = match
        @token("IMPORTANT", input)

        return input.length

      if match = /^[a-zA-Z_-]([a-zA-Z0-9:._-]*[a-zA-Z0-9])?/.exec @chunk
        [input] = match
        @token("IDENTIFIER", input)

        return input.length

    return 0

  identifierToken: ->
    return 0 unless match = IDENTIFIER.exec @chunk
    [input] = match

    @token("IDENTIFIER", input)

    input.length

  commentToken: ->
    return 0 unless match = COMMENT.exec @chunk
    [input] = match

    lines = input.split("\n")
    @line += lines.length - 1

    input.length

  whitespaceToken: ->
    return 0 unless match = WHITESPACE.exec @chunk
    [input] = @chunk

    input.length

  newlineToken: ->
    return 0 unless match = NEWLINE.exec @chunk
    [input] = match

    @line += 1

    input.length

  stringToken: ->
    return 0 unless match = STRING.exec @chunk
    [input] = match

    string = input
    @token("STRING", string)

    input.length

  numberToken: ->
    input = null

    if match = HEXNUMBER.exec @chunk
      [input] = match
      @token("HEXNUMBER", input)
    else if match = UNITNUMBER.exec @chunk
      [input] = match
      @token("UNITNUMBER", input)
    else if match = NUMBER.exec @chunk
      [input] = match
      @token("NUMBER", input)

    if input then input.length else 0

  literalToken: ->
    if match = OPERATORS.exec @chunk
      [value] = match
    else
      value = @chunk.charAt(0)

    @token(value, value)

    if @scope == "SELECTOR" and value == ","
      @scope = "INITIAL"

    if @scope == "ATTRIBUTE_NAME" and value == ":"
      @scope = "ATTRIBUTE_VALUE"

    if @scope == "ATTRIBUTE_VALUE" and value == ";"
      @scope = "ATTRIBUTE_NAME"

    if value == "{"
      @scope = "ATTRIBUTE_NAME"

    if value == "}"
      @scope = "INITIAL"

    value.length

  token: (tag, value) ->
    @tokens.push([tag, value, @line])

Lexer.integrator =
  lex: ->
    [tag, @yytext, @yylineno] = @tokens[@pos++] or ['']

    @yylloc =
      first_line: @yylineno
      last_line:  @yylineno + 1

    @yyleng = @yytext.length if @yytext

    tag

  setInput: (@input) ->
    @tokens = Lexer.tokenize(@input)
    @lines = @input.split(/\r\n|\n|\r/)
    @yylineno = @yyleng = 0
    @yylloc = {first_line:1,first_column:0,last_line:1,last_column:0}
    @pos = 0

  upcomingInput: ->
    "ERRO"

  prevText: (tokens = 5) ->
    pos = Math.max(@pos - tokens, 0)
    (t[1] for t in @tokens.slice(pos, @pos)).join(" ")

  showPosition: ->
    @lines[@yylineno]

if window?
  window.ScriptedCss.Parser.Lexer = Lexer
if module?
  module.exports = Lexer
