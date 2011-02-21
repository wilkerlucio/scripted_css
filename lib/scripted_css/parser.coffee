{Parser} = require "jison"

ast     = require "#{__dirname}/parser/ast"
grammar = require "#{__dirname}/parser/grammar"
lexer   = require "#{__dirname}/parser/lexer"

parser = new Parser(
  lex:         lexer
  bnf:         grammar
  startSymbol: "Root"
)

parser.yy = ast

module.exports = parser

# console.log(parser.parse("
#   /* some comment */
#   @media screen
#   body::slot(a), div, #menu-item {background: black; color: white; -moz-border-radius: .5px;}
#   body {background: #fff url('lib/scripted_css/test.png') no-repeat 0 5px;}
#   #container {display: 'aaa' / 50px
#                        'bcc'
#                        100px minmax(100px, 200px) *;}
#   input[type~=text] {}
#   p {}
# ").rules)
