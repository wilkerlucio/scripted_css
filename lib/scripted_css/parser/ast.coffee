exports.RulesNode = class RulesNode
  constructor: (@rules) ->

exports.RuleNode = class RuleNode
  constructor: (@selectors, @attributes) ->

exports.MetaNode = class MetaNode
  constructor: (@name, @value) ->

exports.SelectorNode = class SelectorNode
  constructor: (@selector, @attributes, @meta) ->
    @next = null

  nestSelector: (selector, rule = " ") ->
    if @next
      @next.nestSelector.call(@next, selector, rule)
    else
      @next     = selector
      @nextRule = rule

    this

exports.AttributeNode = class AttributeNode
  constructor: (@name, @values) ->

  value: ->
    rawValues = (value.string() for value in @values)
    rawValues.join(" ")

exports.FunctionNode = class FunctionNode
  constructor: (@name, @arguments) ->
  argumentsString: ->
    (arg.string() for arg in @arguments).join(",")

  string: -> "#{@name}(#{@argumentsString()})"

exports.AttributeSelectorNode = class AttributeSelectorNode
  constructor: (@name, @operator, @value) ->

exports.LiteralNode = class LiteralNode
  constructor: (@value) ->
  string: -> @value.toString()
