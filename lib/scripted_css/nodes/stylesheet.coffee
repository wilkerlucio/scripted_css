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

class Stylesheet extends ScriptedCss.Nodes.Base
  constructor: (stylesheet) ->
    ScriptedCss.trigger("stylesheetPreInitialize", stylesheet, this)

    @init(stylesheet, "stylesheet")

    ScriptedCss.trigger("stylesheetInitialized", this)

    @imports = _.map @imports, ScriptedCss.Nodes.factory.bind(this)
    @fonts   = _.map @fonts,   ScriptedCss.Nodes.factory.bind(this)
    @rules   = _.map @rules,   ScriptedCss.Nodes.factory.bind(this)

    ScriptedCss.trigger("stylesheetReady", this)

  stringify: ->
    ["@charset '#{@charset}';"].concat(@stringifyArray(@fonts)).concat(@stringifyArray(@rules)).join("\n")

# rewrite to each rule as a single selector
Stylesheet.SelectorExpander =
  expand: (stylesheet, triggerEvent = true) ->
    rules = _.reduce stylesheet.rules, ((rules, rule) ->
      if rule.type == "ruleset"
        for selector in rule.selectors
          rules.push(_.extend({selector: selector}, rule))
      else
        Stylesheet.SelectorExpander.expand(rule, false) if rule.rules
        rules.push(rule)

      rules
    ), []

    stylesheet.rules = rules

    ScriptedCss.trigger("stylesheetSelectorsExpanded", stylesheet) if triggerEvent

ScriptedCss.bind "stylesheetPreInitialize", Stylesheet.SelectorExpander.expand

# extract rulesets
Stylesheet.RuleSetExtractor =
  extract: (stylesheet, triggerEvent = true) ->
    stylesheet.regularRules = _.reduce stylesheet.rules, ((memo, rule) ->
      if rule.type == "ruleset"
        memo.push(rule)
      else if rule.type == "media_rule" and _.include(rule.media, "screen")
        Stylesheet.RuleSetExtractor.extract(rule, false)
        memo = memo.concat(rule.regularRules)

      memo
    ), []

    ScriptedCss.trigger("stylesheetRulesExtracted", stylesheet) if triggerEvent

ScriptedCss.bind "stylesheetInitialized", Stylesheet.RuleSetExtractor.extract

# index rulesets
Stylesheet.RulesIndexer =
  index: (stylesheet) ->
    removes = []

    stylesheet.regularRules = _.reduce stylesheet.regularRules, ((memo, rule) ->
      selectorString = rule.selector.stringify()

      if memo[selectorString]
        memo[selectorString].merge(rule)
        removes.push(rule)
      else
        memo[selectorString] = rule

      memo
    ), {}

    # remove merged rules
    stylesheet.rules = _.reject stylesheet.rules, (rule) ->
      _.include(removes, rule)

    ScriptedCss.trigger("stylesheetRulesIndexed", stylesheet)

ScriptedCss.bind "stylesheetRulesExtracted", Stylesheet.RulesIndexer.index

# index attributes
Stylesheet.DetailsIndexer =
  index: (stylesheet) ->
    declarations = {}
    selections   = {}

    for rule in stylesheet.regularRules
      for selection in rule.selections()
        selections[selection] ?= []
        selections[selection].push(rule)

      for declaration in rule.declarations
        declarations[declaration.property] ?= []
        declarations[declaration.property].push(rule)

    stylesheet.declarationsIndex = declarations
    stylesheet.selectorIndex     = selections

    ScriptedCss.trigger("stylesheetDetailsIndexed", stylesheet)

Stylesheet::rulesWithProperty = (property) ->
  @declarationsIndex[property] || []

Stylesheet::rulesWithSelection = (selection) ->
  @selectorIndex[selection] || []

ScriptedCss.bind "stylesheetRulesIndexed", Stylesheet.DetailsIndexer.index

# exporting
window.ScriptedCss.Nodes.Stylesheet = Stylesheet
