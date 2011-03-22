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

module "Stylesheet Node"

style = ScriptedCss.Nodes.Stylesheet

test "stringify", ->
  dummy = (output) ->
    type: "plain"
    selector:
      stringify: ->
    stringify: -> output

  s = new style(
    type: 'stylesheet'
    charset: 'utf-8'
    imports: [dummy('import')]
    fonts: [dummy('font1')]
    rules: [dummy("rule1"), dummy("rule2")]
  )

  same(s.stringify(), "@charset 'utf-8';\nfont1\nrule1\nrule2")

test "expanding selectors", ->
  stylesheet =
    rules: [
      {
        type: "ruleset"
        selectors: [
          "one",
          "two"
        ]
      }
    ]

  style.SelectorExpander.expand(stylesheet)

  same(stylesheet.rules[0].selector, "one")
  same(stylesheet.rules[1].selector, "two")

test "expanding selectors on media", ->
  stylesheet =
    rules: [
      {
        type: "media_rule"
        rules: [
          {
            type: "ruleset"
            selectors: [
              "one",
              "two"
            ]
          }
        ]
      }
    ]

  style.SelectorExpander.expand(stylesheet)

  same(stylesheet.rules[0].rules[0].selector, "one")
  same(stylesheet.rules[0].rules[1].selector, "two")

test "merging media screen rules", ->
  stylesheet =
    rules: [
      {
        type: "media_rule"
        media: ["screen"]
        rules: [
          {
            type: "ruleset"
            selector: "one"
          },
          {
            type: "ruleset"
            selector: "two"
          }
        ]
      },
      {
        type: "ruleset"
        selector: "other"
      }
    ]

  stub = sinon.stub(ScriptedCss, 'trigger')
  style.RuleSetExtractor.extract(stylesheet)
  stub.restore()

  same(stylesheet.regularRules[0].selector, "one")
  same(stylesheet.regularRules[1].selector, "two")
  same(stylesheet.regularRules[2].selector, "other")

test "not merging media rules if it don't contains screen", ->
  stylesheet =
    rules: [
      {
        type: "media_rule"
        media: ["print"]
        rules: [
          {
            type: "ruleset"
            selector: "one"
          },
          {
            type: "ruleset"
            selector: "two"
          }
        ]
      },
      {
        type: "ruleset"
        selector: "other"
      }
    ]

  stub = sinon.stub(ScriptedCss, 'trigger')
  style.RuleSetExtractor.extract(stylesheet)
  stub.restore()

  same(stylesheet.regularRules[0].selector, "other")

test "indexing rules", ->
  dummy = (selector) ->
    type: "ruleset"
    selector: {stringify: -> selector}
    merge: ->

  rules = [dummy("rule1"), dummy("rule2"), dummy("rule1"), dummy("rule3")]

  s =
    type: 'stylesheet'
    rules: rules
    regularRules: _.toArray(rules)

  cancelEvents -> style.RulesIndexer.index(s)

  ok(s.regularRules["rule1"])
  ok(s.regularRules["rule2"])
  ok(s.regularRules["rule3"])
  equal(s.rules.length, 3)

test "indexing declarations and selector details", ->
  css =
    rules: [
      {
        selector: "a"
        selections: -> ["TAG", ".class"]
        declarations: [
          {
            property: "aa"
            expression: []
          }
          {
            property: "ab"
            expression: []
          }
        ]
      },
      {
        selector: "b"
        selections: -> ["#id", ".class"]
        declarations: [
          {
            property: "aa"
            expression: []
          }
        ]
      },
    ]

  css.regularRules       = _.toArray(css.rules)
  css.rulesWithProperty  = style::rulesWithProperty
  css.rulesWithSelection = style::rulesWithSelection

  cancelEvents -> style.DetailsIndexer.index(css)

  equal(css.rulesWithProperty("aa").length, 2)
  same(css.rulesWithProperty("aa")[0].selector, "a")
  same(css.rulesWithProperty("aa")[1].selector, "b")
  same(css.rulesWithSelection("TAG")[0].selector, "a")
  same(css.rulesWithSelection(".class")[0].selector, "a")
  same(css.rulesWithSelection("#id")[0].selector, "b")
  same(css.rulesWithSelection(".class")[1].selector, "b")
