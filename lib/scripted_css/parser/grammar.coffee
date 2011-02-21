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
