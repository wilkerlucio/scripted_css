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
  extractFunction = (fn) -> fn.toString().match(/^function\s*\(\)\s*\{\s*([\s\S]*)\n\s*\}/)[1]

  rules = for rule, value of source
    if _.isArray(value)
      result = (parseValue(item) for item in value)
      result = result.join("\n  ")
    else
      result = parseValue(value)

    "#{rule}\n  = #{result}"

  rules.join("\n\n")

source = dslPeg(
  # CSS parser based on the grammar described at http://www.w3.org/TR/CSS2/grammar.html.
  #
  # The parser builds a tree representing the parsed CSS, composed of basic
  # JavaScript values, arrays and objects (basically JSON). It can be easily
  # used by various CSS processors, transformers, etc.
  #
  # Note that the parser does not handle errors in CSS according to the
  # specification -- many errors which it should recover from (e.g. malformed
  # declarations or unexpected end of stylesheet) are simply fatal. This is a
  # result of straightforward rewrite of the CSS grammar to PEG.js and it should
  # be fixed sometimes.

  # ===== Syntactical Elements =====

  start: ["stylesheet:stylesheet comment*", -> stylesheet]

  stylesheet: [
    'charset:(CHARSET_SYM STRING ";")? (S / CDO / CDC)*'
    'imports:(import (CDO S* / CDC S*)*)*'
    'rules:((ruleset / media / page) (CDO S* / CDC S*)*)*'
    ->
      importsConverted = (i[0] for i in imports)
      rulesConverted = (r[0] for r in rules)

      type:    "stylesheet"
      charset: if charset != "" then charset[1] else null
      imports: importsConverted
      rules:   rulesConverted
  ]

  import: [
    'IMPORT_SYM S* href:(STRING / URI) S* media:media_list? ";" S*', ->
      type:  "import_rule"
      href:  href
      media: if media != "" then media else []
  ]

  media: [
    'MEDIA_SYM S* media:media_list "{" S* rules:ruleset* "}" S*', ->
      type:  "media_rule"
      media: media
      rules: rules
  ]

  media_list: [
    'head:medium tail:("," S* medium)*', ->
      result = [head]
      result.push(t[2]) for t in tail
      result
  ]

  medium: [
    'ident:IDENT S*', -> ident
  ]

  page: [
    'PAGE_SYM S* qualifier:pseudo_page?'
    '"{" S*'
    'declarationsHead:declaration?'
    'declarationsTail:(";" S* declaration?)*'
    '"}" S*',
    ->
      declarations = if declarationsHead != "" then [declarationsHead] else []
      for dec in declarationsTail
        declarations.push(dec[2]) if dec[2] != ""

      type:         "page_rule"
      qualifier:    if qualifier != "" then qualifier else null
      declarations: declarations
  ]

  pseudo_page: [
    '":" ident:IDENT S*', -> ident
  ]

  operator: [
    '  "/" S*', -> "/"
    '/ "," S*', -> ","
  ]

  combinator: [
    '  "+" S*', -> "+"
    '/ ">" S*', -> ">"
  ]

  unary_operator: [
    '  "+"'
    '/ "-"'
  ]

  property: [
    'ident:IDENT S*', -> ident
  ]

  ruleset: [
    'selectorsHead:selector'
    'selectorsTail:("," S* selector)*'
    '"{" S*'
    'declarationsHead:declaration?'
    'declarationsTail:(";" S* declaration?)*'
    '"}" S*'
    ->
      selectors = [selectorsHead]
      selectors.push(tail[2]) for tail in selectorsTail

      declarations = if declarationsHead != "" then [declarationsHead] else []
      for dec in declarationsTail
        declarations.push(dec[2]) if dec[2] != ""

      type:         "ruleset"
      selectors:    selectors
      declarations: declarations
  ]

  selector: [
    'left:simple_selector S* combinator:combinator right:selector', ->
      type:       "selector"
      combinator: combinator
      left:       left
      right:      right
    '/ left:simple_selector S* right:selector', ->
      type:       "selector"
      combinator: " "
      left:       left
      right:      right
    '/ selector:simple_selector S*', -> selector
  ]

  simple_selector: [
    'element:element_name'
    'qualifiers:('
      'id:HASH', -> type: "ID selector", id: id.substr(1)
      '/ class'
      '/ attrib'
      '/ pseudo'
    ')*', ->
      type:       "simple_selector",
      element:    element,
      qualifiers: qualifiers
    '/ qualifiers:('
      'id:HASH', -> type: "ID selector", id: id.substr(1)
      '/ class'
      '/ attrib'
      '/ pseudo'
    ')+', ->
      type:       "simple_selector",
      element:    "*",
      qualifiers: qualifiers
  ]

  class: ['"." class_:IDENT', -> type: "class_selector", "class": class_]
  element_name: ["IDENT / '*'"]

  attrib: [
    '"[" S*'
      'attribute:IDENT S*'
      'operatorAndValue:('
        '("=" / INCLUDES / DASHMATCH) S*'
        '(IDENT / STRING) S*'
      ')?'
    '"]"'
    ->
      type:      "attribute_selector"
      attribute: attribute
      operator:  if operatorAndValue != "" then operatorAndValue[0] else null
      value:     if operatorAndValue != "" then operatorAndValue[2] else null
  ]

  pseudo: [
    '":" ":"?'
    'value:('
      'name:FUNCTION S* params:(IDENT S*)? ")"', ->
        type:   "function"
        name:   name
        params: if params != "" then [params[0]] else []
      '/ IDENT'
    ')'
    ->
      # The returned object has somewhat vague property names and values because
      # the rule matches both pseudo-classes and pseudo-elements (they look the
      # same at the syntactic level).

      type:  "pseudo_selector",
      value: value
  ]

  declaration: [
    'property:property ":" S* expression:expr important:prio?', ->
      type:       "declaration"
      property:   property
      expression: expression
      important:  if important != "" then true else false
  ]

  prio: [ 'IMPORTANT_SYM S*' ]

  expr: [
    'head:term tail:(operator? term)*', ->
      result = [head]
      # result.concat(_.compact(_.pluck(tail, 0)))
      for t in tail
        result.push(type: "operator", value: t[0]) if t[0]
        result.push(t[1])

      result
  ]

  term: [
    'operator:unary_operator?'
    'value:('
        'EMS S*'
      '/ EXS S*'
      '/ LENGTH S*'
      '/ ANGLE S*'
      '/ TIME S*'
      '/ FREQ S*'
      '/ PERCENTAGE S*'
      '/ NUMBER S*'
    ')',                 -> type: "value", value: operator + value[0]
    '/ value:URI S*',    -> type: "uri", value: value
    '/ function'
    '/ hexcolor'
    '/ value:STRING S*', -> type: "string", value: value
    '/ value:IDENT S*',  -> type: "ident", value: value
  ]

  function: [
    'name:FUNCTION S* params:expr ")" S*', ->
      type:   "function"
      name:   name
      params: params
  ]

  hexcolor: ['value:HASH S*', -> type: "hexcolor", value: value]

  # ===== Lexical Elements =====

  # Macros

  h: '[0-9a-fA-F]'
  nonascii: '[\\x80-\\xFF]'
  unicode: [
    '"\\\\" h1:h h2:h? h3:h? h4:h? h5:h? h6:h? ("\\r\\n" / [ \\t\\r\\n\\f])?', ->
      String.fromCharCode(parseInt("0x" + h1 + h2 + h3 + h4 + h5 + h6))
  ]

  escape: [
    'unicode'
    '/ "\\\\" char_:[^\\r\\n\\f0-9a-fA-F]', -> char_
  ]

  nmstart: [
    '[_a-zA-Z]'
    '/ nonascii'
    '/ escape'
  ]

  nmchar: [
    '[_a-zA-Z0-9-]'
    '/ nonascii'
    '/ escape'
  ]

  integer: [
    'digits:[0-9]+', -> parseInt(digits.join(""))
  ]

  float: [
    'before:[0-9]* "." after:[0-9]+', -> parseFloat(before.join("") + "." + after.join(""))
  ]

  string1: [
    "'\"' chars:([^\\n\\r\\f\\\"] / \"\\\\\" nl:nl { return nl } / escape)* '\"'", -> chars.join("")
  ]

  string2: [
    '"\'" chars:([^\\n\\r\\f\\\'] / "\\\\" nl:nl { return nl } / escape)* "\'"', -> chars.join("")
  ]

  comment: '"/*" [^*]* "*"+ ([^/*] [^*]* "*"+)* "/"'

  ident: [
    'dash:"-"? nmstart:nmstart nmchars:nmchar*', ->
      dash + nmstart + nmchars.join("")
  ]

  name: ['nmchars:nmchar+', -> nmchars.join("")]

  num: [
    'float'
    '/ integer'
  ]

  string: [
    'string1'
    '/ string2'
  ]

  url: ['chars:([!#$%&*-~] / nonascii / escape)*', -> chars.join("")]

  s: '[ \\t\\r\\n\\f]+'

  w: 's?'

  nl: [
    '  "\\n"'
    '/ "\\r\\n"'
    '/ "\\r"'
    '/ "\\f"'
  ]

  A: [
    '  [aA]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "41" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "A"
    '/ "\\\\" "0"? "0"? "0"? "0"? "61" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "a"
  ]

  C: [
    '[cC]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "43" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "C"
    '/ "\\\\" "0"? "0"? "0"? "0"? "63" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "c"
  ]

  D: [
    '[dD]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "44" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "D"
    '/ "\\\\" "0"? "0"? "0"? "0"? "64" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "d"
  ]

  E: [
    '[eE]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "45" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "E"
    '/ "\\\\" "0"? "0"? "0"? "0"? "65" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "e"
  ]

  G: [
    '[gG]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "47" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "G"
    '/ "\\\\" "0"? "0"? "0"? "0"? "67" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "g"
    '/ "\\\\" char_:[gG]', -> char_
  ]

  H: [
    'h:[hH]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "48" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "H"
    '/ "\\\\" "0"? "0"? "0"? "0"? "68" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "h"
    '/ "\\\\" char_:[hH]', -> char_
  ]

  I: [
    'i:[iI]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "49" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "I"
    '/ "\\\\" "0"? "0"? "0"? "0"? "69" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "i"
    '/ "\\\\" char_:[iI]', -> char_
  ]

  K: [
    '[kK]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "4" [bB] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "K"
    '/ "\\\\" "0"? "0"? "0"? "0"? "6" [bB] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "k"
    '/ "\\\\" char_:[kK]', -> char_
  ]

  L: [
    '[lL]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "4" [cC] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "L"
    '/ "\\\\" "0"? "0"? "0"? "0"? "6" [cC] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "l"
    '/ "\\\\" char_:[lL]', -> char_
  ]

  M: [
    '[mM]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "4" [dD] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "M"
    '/ "\\\\" "0"? "0"? "0"? "0"? "6" [dD] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "m"
    '/ "\\\\" char_:[mM]', -> char_
  ]

  N: [
    '[nN]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "4" [eE] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "N"
    '/ "\\\\" "0"? "0"? "0"? "0"? "6" [eE] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "n"
    '/ "\\\\" char_:[nN]', -> char_
  ]

  O: [
    '[oO]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "4" [fF] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "O"
    '/ "\\\\" "0"? "0"? "0"? "0"? "6" [fF] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "o"
    '/ "\\\\" char_:[oO]', -> char_
  ]

  P: [
    '[pP]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "50" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "P"
    '/ "\\\\" "0"? "0"? "0"? "0"? "70" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "p"
    '/ "\\\\" char_:[pP]', -> char_
  ]

  R: [
    '[rR]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "52" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "R"
    '/ "\\\\" "0"? "0"? "0"? "0"? "72" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "r"
    '/ "\\\\" char_:[rR]', -> char_
  ]

  S_: [
    '[sS]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "53" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "S"
    '/ "\\\\" "0"? "0"? "0"? "0"? "73" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "s"
    '/ "\\\\" char_:[sS]', -> char_
  ]

  T: [
    '[tT]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "54" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "T"
    '/ "\\\\" "0"? "0"? "0"? "0"? "74" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "t"
    '/ "\\\\" char_:[tT]', -> char_
  ]

  U: [
    '[uU]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "55" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "U"
    '/ "\\\\" "0"? "0"? "0"? "0"? "75" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "u"
    '/ "\\\\" char_:[uU]', -> char_
  ]

  X: [
    '[xX]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "58" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "X"
    '/ "\\\\" "0"? "0"? "0"? "0"? "78" ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "x"
    '/ "\\\\" char_:[xX]', -> char_
  ]

  Z: [
    '[zZ]'
    '/ "\\\\" "0"? "0"? "0"? "0"? "5" [aA] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "Z"
    '/ "\\\\" "0"? "0"? "0"? "0"? "7" [aA] ("\\r\\n" / [ \\t\\r\\n\\f])?', -> "z"
    '/ "\\\\" char_:[zZ]', -> char_
  ]

  # Tokens

  'S "whitespace"':         'comment* s'
  'CDO "<!--"':             'comment* "<!--"'
  'CDC "-->"':              'comment* "-->"'
  'INCLUDES "~="':          'comment* "~="'
  'DASHMATCH "|="':         'comment* "|="'
  'STRING "string"':        ['comment* string:string', -> string]
  'IDENT "identifier"':     ['comment* ident:ident',   -> ident]
  'HASH "hash"':            ['comment* "#" name:name', -> "#" + name]
  'IMPORT_SYM "@import"':   'comment* "@" I M P O R T'
  'PAGE_SYM "@page"':       'comment* "@" P A G E'
  'MEDIA_SYM "@media"':     'comment* "@" M E D I A'
  'CHARSET_SYM "@charset"': 'comment* "@charset "'

  # Note: We replace "w" with "s" here to avoid infinite recursion.
  'IMPORTANT_SYM "!important"': ['comment* "!" (s / comment)* I M P O R T A N T', -> "!important"]

  'EMS "length"':            ['comment* num:num e:E m:M',                                  -> num + e + m]
  'EXS "length"':            ['comment* num:num e:E x:X',                                  -> num + e + x]
  'LENGTH "length"':         ['comment* num:num unit:(P X / C M / M M / I N / P T / P C)', -> num + unit.join("")]
  'ANGLE "angle"':           ['comment* num:num unit:(D E G / R A D / G R A D)',           -> num + unit.join("")]
  'TIME "time"':             ['comment* num:num unit:(m:M s:S_ { return m + s; } / S_)',   -> num + unit]
  'FREQ "frequency"':        ['comment* num:num unit:(H Z / K H Z)',                       -> num + unit.join("")]
  'DIMENSION "dimension"':   ['comment* num:num unit:ident',                               -> num + unit]
  'PERCENTAGE "percentage"': ['comment* num:num "%"',                                      -> num + "%"]
  'NUMBER "number"':         ['comment* num:num',                                          -> num]

  'URI "uri"': ['comment* U R L "(" w value:(string / url) w ")"', -> value]
  'FUNCTION "function"': ['comment* name:ident "("', -> name]
)

parser = PEG.buildParser(source)

window.CssParser = parser
