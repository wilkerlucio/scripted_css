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

# some helpers, thanks for CoffeeScript source!
unwrap = /^function\s*\(\)\s*\{\s*return\s*([\s\S]*);\s*\}/

o = (patternString, action, options) ->
  patternString = patternString.replace /\s{2,}/g, ' '
  return [patternString, '$$ = $1;', options] unless action
  action = if match = unwrap.exec action then match[1] else "(#{action}())"
  action = action.replace /\bnew /g, '$&yy.'
  action = action.replace /\b(?:Block\.wrap|extend)\b/g, 'yy.$&'
  [patternString, "$$ = #{action};", options]

grammar =
  Root: [
    ["Rules", "$$ = new yy.RulesNode($1); return $$"]
  ]

  Rules: [
    o "Rule",                                            -> [$1]
    o "Rules Rule",                                      -> $1.concat $2
  ]

  Rule: [
    o "Selectors { Attributes }",                        -> new RuleNode($1, $3)
    o "@ IDENTIFIER Value",                              -> new MetaNode($2, $3.string())
  ]

  Selectors: [
    o "Selector",                                        -> [$1]
    o "Selectors Selector",                              -> $1[$1.length - 1].nestSelector($2, " "); $1
    o "Selectors SelectorOperator Selector",             -> $1[$1.length - 1].nestSelector($3, $2); $1
    o "Selectors , Selector",                            -> $1.concat $3
  ]

  SelectorOperator: [
    o ">"
    o "+"
    o "~"
  ]

  Selector: [
    o "SelectorName",                                    -> new SelectorNode($1)
    o "SelectorName [ AttributeSelector ]",              -> new SelectorNode($1, $3)
    o "SelectorName [ AttributeSelector ] MetaSelector", -> new SelectorNode($1, $3, $5)
    o "SelectorName MetaSelector",                       -> new SelectorNode($1, null, $2)
  ]

  SelectorName: [
    o "IDENTIFIER"
    o "SelectorContext IDENTIFIER",                      -> $1 + $2
  ]

  SelectorContext: [
    "#"
    "."
  ]

  AttributeSelector: [
    o "IDENTIFIER AttributeSelectorOperator Value",      -> new AttributeSelectorNode($1, $2, $3)
  ]

  AttributeSelectorOperator: [
    o "="
    o "~ =",                                             -> $1 + $2
    o "| =",                                             -> $1 + $2
    o "^ =",                                             -> $1 + $2
    o "$ =",                                             -> $1 + $2
    o "* =",                                             -> $1 + $2
  ]

  MetaSelector: [
    o "MetaSelectorOperator MetaSelectorItem",           -> $2
  ]

  MetaSelectorItem: [
    o "IDENTIFIER"
    o "Function"
  ]

  MetaSelectorOperator: [
    o ":"
    o "::"
  ]

  Attributes: [
    o "",                                                -> []
    o "Attribute",                                       -> [$1]
    o "Attributes ; Attribute",                          -> $1.concat($3)
    o "Attributes ;"
  ]

  Attribute: [
    o "IDENTIFIER : ValueList",                          -> new AttributeNode($1, $3)
  ]

  ValueList: [
    o "Value",                                           -> [$1]
    o "ValueList Value",                                 -> $1.concat($2)
  ]

  Value: [
    o "IDENTIFIER",                                      -> new LiteralNode($1)
    o "STRING",                                          -> new LiteralNode($1)
    o "HEXNUMBER",                                       -> new LiteralNode($1)
    o "UNITNUMBER",                                      -> new LiteralNode($1)
    o "NUMBER",                                          -> new LiteralNode($1)
    o "/",                                               -> new LiteralNode($1)
    o "*",                                               -> new LiteralNode($1)
    o "Function"
  ]

  Function: [
    o "IDENTIFIER ( ArgList )",                          -> new FunctionNode($1, $3)
  ]

  ArgList: [
    o "",                                                -> []
    o "Value",                                           -> [$1]
    o "ArgList , Value",                                 -> $1.concat($3)
  ]

module.exports = grammar
