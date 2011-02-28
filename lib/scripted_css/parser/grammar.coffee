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
    ["",      "$$ = new yy.RulesNode([]); return $$"]
    ["Rules", "$$ = new yy.RulesNode($1); return $$"]
  ]

  Rules: [
    o "Rule",                                          -> $1
    o "Rules Rule",                                    -> $1.concat $2
  ]

  Rule: [
    o "Selectors { Attributes }",                      -> new RuleNode(selector, $3) for selector in $1
    o "@ IDENTIFIER Value",                            -> [new MetaNode($2, $3)]
    o "@ IDENTIFIER { Attributes }",                   -> [new MetaNode($2, $4)]
  ]

  Selectors: [
    o "Selector",                                      -> [$1]
    o "Selectors SELECTOR_OPERATOR Selector",          -> $1[$1.length - 1].nestSelector($3, $2); $1
    o "Selectors , Selector",                          -> $1.concat $3
  ]

  Selector: [
    o "IDENTIFIER",                                    -> new SelectorNode($1)
    o "IDENTIFIER [ AttributeSelector ]",              -> new SelectorNode($1, $3)
    o "IDENTIFIER [ AttributeSelector ] MetaSelector", -> new SelectorNode($1, $3, $5)
    o "IDENTIFIER MetaSelector",                       -> new SelectorNode($1, null, $2)
    o "MetaSelector",                                  -> new SelectorNode("*", null, $1)
  ]

  AttributeSelector: [
    o "IDENTIFIER AttributeSelectorOperator Value",    -> new AttributeSelectorNode($1, $2, $3)
  ]

  AttributeSelectorOperator: [
    o "="
    o "~="
    o "|="
    o "^="
    o "$="
    o "*="
  ]

  MetaSelector: [
    o "MetaSelectorOperator MetaSelectorItem",         -> new MetaSelectorNode($2, $1)
  ]

  MetaSelectorItem: [
    o "IDENTIFIER",                                    -> new LiteralNode($1)
    o "Function"
  ]

  MetaSelectorOperator: [
    o ":"
    o "::"
  ]

  Attributes: [
    o "",                                              -> []
    o "Attribute",                                     -> [$1]
    o "Attributes ; Attribute",                        -> $1.concat($3)
    o "Attributes ;"
  ]

  Attribute: [
    o "IDENTIFIER : ValueList",                        -> new AttributeNode($1, $3)
  ]

  ValueList: [
    o "ValueListItem",                                 -> [$1]
    o "ValueList ValueListItem",                       -> $1.concat($2)
  ]

  ValueListItem: [
    o "Value"
    o "ComaListValue",                                 -> new MultiLiteral($1, ", ")
  ]

  ComaListValue: [
    o "Value , Value",                                 -> [$1, $3]
    o "ComaListValue , Value",                         -> $1.concat($3)
  ]

  Value: [
    o "IDENTIFIER",                                    -> new LiteralNode($1)
    o "STRING",                                        -> new StringNode($1)
    o "HEXNUMBER",                                     -> new LiteralNode($1)
    o "UNITNUMBER",                                    -> new UnitNumberNode($1)
    o "NUMBER",                                        -> new LiteralNode($1)
    o "/",                                             -> new LiteralNode($1)
    o "*",                                             -> new LiteralNode($1)
    o ".",                                             -> new LiteralNode($1)
    o "!",                                             -> new LiteralNode($1)
    o "IMPORTANT",                                     -> new ImportantNode()
    o "Function"
  ]

  Function: [
    o "IDENTIFIER ( ArgList )",                        -> new FunctionNode($1, $3)
  ]

  ArgList: [
    o "",                                              -> []
    o "ArgListValue",                                  -> [$1]
    o "ArgList , ArgListValue",                        -> $1.concat($3)
  ]

  ArgListValue: [
    o "Value"
    o "IDENTIFIER = Value",                            -> new NamedArgumentNode($1, $3)
    o "MultiArg",                                      -> new MultiLiteral($1, " ")
  ]

  MultiArg: [
    o "Value Value",                                   -> [$1, $2]
    o "MultiArg Value",                                -> $1.concat($2)
  ]

module.exports = grammar
