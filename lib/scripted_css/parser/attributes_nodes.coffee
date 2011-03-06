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

f = (v1, v2) ->
  if _.isArray(v1) and _.isArray(v2)
    return v1.concat(v2)

  if _.isArray(v1) and !(_.isArray(v2))
    v1.push(v2)
    return v1

  if !(_.isArray(v1)) and _.isArray(v2)
    v2.unshift(v1)
    return v2

  if !(_.isArray(v1)) and !(_.isArray(v2))
    return [v1, v2]

window.ScriptedCss.AttributesParser.yy =
  Optional: class Optional
    constructor: (@v1, @v2) ->
      @type = "OPTIONAL"

    parse: (nodes, grammar) ->
      nodesClone = nodes.clone()

      r1 = @v1.parse(nodes, grammar)

      if r1
        nodesClone.items = nodes.items
      else
        nodes.items = nodesClone.items

      r2 = @v2.parse(nodes, grammar)

      if r2
        nodesClone.items = nodes.items
      else
        nodes.items = nodesClone.items

      f(r1 || new Null, r2 || new Null)

  Or: class Or
    constructor: (@v1, @v2) ->
      @type = "OR"

    parse: (nodes, grammar) ->
      nodesClone = nodes.clone()
      v = @v1.parse(nodes, grammar)
      return v if @isValid(v)
      v = @v2.parse(nodesClone, grammar)
      if @isValid(v)
        nodes.items = nodesClone.items
        return v

      false

    isValid: (result) ->
      return result unless _.isArray(result)

      _.any result, (node) -> !node.type or node.type != "NULL"

  And: class And
    constructor: (@v1, @v2) ->
      @type = "AND"

    parse: (nodes, grammar) ->
      nodesClone = nodes.clone()

      r1 = @v1.parse(nodes, grammar)
      r2 = @v2.parse(nodes, grammar)

      if r1 and r2 then f(r1, r2) else nodes.items = nodesClone.items; false

  Value: class Value
    constructor: (@value, @quantity = new Quantity(1)) ->
      @type = "VALUE"

    parse: (nodes, grammar) ->
      @quantity.parse(@value, nodes, grammar)

  Macro: class Macro
    constructor: (@value) ->
      @type = "MACRO"

    parse: (nodes, grammar) ->
      ScriptedCss.AttributesParser.parseNodesInternal(nodes, @value, grammar)

  Literal: class Literal
    constructor: (@value) ->
      @type = "LITERAL"

    parse: (nodes, grammar) ->
      value = @value
      v = ScriptedCss.AttributesParser.helpers.collect nodes, (node) -> node.string() == value

      v

  Null: class Null
    constructor: -> @type = "NULL"
    parse: -> this

  Quantity: class Quantity
    constructor: (@min, @max = @min) ->
    parse: (value, nodes, grammar) ->
      if @max == 1
        result = value.parse(nodes, grammar)

        if result
          if @min == 1 then result else [result]
        else
          if @min == 1 then false else [[]]
      else
        results = []

        while r = value.parse(nodes, grammar)
          results.push(r)
          break unless @max == -1 or results.length < @max

        return false if results.length < @min

        [results]

  NodeValues: class NodeValues
    constructor: (@items) -> @type = "NODEVALUES"
    clone: -> new NodeValues(@items)

  ResultParser: class ResultParser
    constructor: (results) ->
      @type = "RESULTPARSER"
      @results = ScriptedCss.AttributesParser.helpers.normalize(results)

    isList: -> _.isArray(@results)
    get: (items...) ->
      current = @results

      until _.isUndefined(i = items.shift())
        current = current[i]
        return null unless current

      current

window.ScriptedCss.AttributesParser.helpers =
  collect: (nodes, callback) ->
    rest = []
    result = false

    for node in nodes.items
      if result == false and callback(node)
        result = node
      else
        rest.push(node)

    nodes.items = rest
    result

  collectMany: (nodes, callback) ->
    rest = []
    results = []

    for node in nodes.items
      if callback(node)
        results.push(node)
      else
        rest.push(node)

    nodes.items = rest
    result

  splitOnValue: (nodes, value) ->
    groups = []
    group = []

    for item in nodes.items
      if item.value == value
        groups.push(group)
        group = []
      else
        group.push(item)

    groups.push(group)
    groups

  parseInternal: (nodes, rule, grammar) ->
    ScriptedCss.AttributesParser.parseNodesInternal(nodes, rule, grammar)

  parse: (nodes, rule, grammar) ->
    ScriptedCss.AttributesParser.parseNodes(nodes, rule, grammar)

  normalize: (value, ignores) ->
    if _.isArray(value)
      list = []

      for item in value
        continue if _.isFunction(item.string) and _.include(ignores, item.string())
        list.push(ScriptedCss.AttributesParser.helpers.normalize(item, ignores))

      list
    else
      if value.type == "NULL" then null else value

window.ScriptedCss.AttributesParser.parseNodesInternal = (nodes, ruleName, grammar) ->
  rule  = grammar[ruleName]
  throw "can't find rule <#{ruleName}>" unless rule

  nodes = new ScriptedCss.AttributesParser.yy.NodeValues(nodes) unless nodes.type == "NODEVALUES"
  returnFunction = rule.return

  unless rule.value?
    rule = {value: rule}
    grammar[ruleName] = rule

  if _.isFunction(rule.value)
    result = rule.value.call(ScriptedCss.AttributesParser.helpers, nodes, grammar)
  else
    unless rule.parser
      rule.parser = ScriptedCss.AttributesParser.parse(rule.value)

    result = rule.parser.parse(nodes, grammar)

  if result
    if returnFunction
      result = new ScriptedCss.AttributesParser.yy.ResultParser(result)
    else
      returnFunction = (v) -> v

    returnFunction.call(ScriptedCss.AttributesParser.helpers, result)
  else
    false

window.ScriptedCss.AttributesParser.parseNodes = (nodes, rule, grammar) ->
  ScriptedCss.AttributesParser.helpers.normalize(ScriptedCss.AttributesParser.parseNodesInternal(nodes, rule, grammar), grammar._ignoreList || [])
