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
