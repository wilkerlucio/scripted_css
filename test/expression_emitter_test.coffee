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

Emitter     = ScriptedCss.ExpressionParser.Emitter
EmitterData = ScriptedCss.ExpressionParser.EmitterData
MacroDict   = ScriptedCss.ExpressionParser.MacroDict

module "Expression Parser - MacroDict"

test "initialize", ->
  dict = a: 'one'
  macros = new MacroDict(dict)

  same(macros.macros.a, {value: 'one', return: null})
  same(macros.cache, {a: null})

test "add new macro", ->
  m = new MacroDict({})
  m.cache['a'] = true

  m.add(a: 'hi')

  same(m.macros['a'], {value: 'hi', return: null})
  same(m.cache['a'], null)

test "get value cache", ->
  m = new MacroDict(a: 'one')
  mock = sinon.stub(m, 'fetchMacro', (v) -> [v])

  v = m.get("a")
  v = m.get("a")

  same(v, value: ['one'], return: null)
  same(m.cache['a'], value: ['one'], return: null)
  ok(mock.calledOnce)

test "get value function", ->
  fn = -> null
  m = new MacroDict(a: fn)

  same(m.macros['a'].value, {type: "function", fn: fn})

module "Expression Parser - EmitterData"

test "initialize", ->
  ed = new EmitterData(['a'])

  same(ed.items, ['a'])
  same(ed.macros, new MacroDict())
  same(ed.labels, {})

test "initialize use a clone of items", ->
  arr = ['a']
  ed = new EmitterData(arr)

  ed.items.pop()

  same(arr, ['a'])

test "compute with success", ->
  ed = new EmitterData(['a', 'b'])
  res = ed.compute (d) -> d.items.pop()

  same(res, "b")
  same(ed.items, ['a'])

test "split on value", ->
  ed = new EmitterData([
    {stringify: -> "a"}
    {stringify: -> "b"}
    {stringify: -> "/"}
    {stringify: -> "c"}
    {stringify: -> "/"}
    {stringify: -> "d"}
  ])

  res = ed.splitOnValue("/")

  same(res[0].items[0].stringify(), "a")
  same(res[0].items[1].stringify(), "b")
  same(res[1].items[0].stringify(), "c")
  same(res[2].items[0].stringify(), "d")

test "parsing again", ->
  ed = new EmitterData([
    {stringify: -> "a"}
    {stringify: -> "b"}
  ])

  same(ed.parse("a").stringify(), "a")

test "compute failing", ->
  ed = new EmitterData(['a', 'b'])
  res = ed.compute (d) -> d.items.pop(); false

  same(res, false)
  same(ed.items, ['a', 'b'])

module "Expression Parser - Emitter"

test "emmit object", ->
  ss      = sinon.spy(-> "done")
  ds      = sinon.spy((fn) -> fn())
  emmit   = Emitter.emmit
  data    = {compute: ds}
  context = sample: ss
  obj     = type: "sample"

  res = emmit.call(context, obj, data)

  same(res, "done")
  ok(ds.calledOnce)
  ok(ss.calledOnce)
  ok(ss.calledOn(context))
  ok(ss.calledWith(obj, data))

test "emmit raise error if has no type", ->
  context = {}

  raises(
    -> Emitter.emmit.call(context, {type: "invalid"})
    TypeError
  )

FakeContext =
  emmit: (obj, data) ->
    if data and data.times
      data.times -= 1
      return false if data.times <= 0

    obj

  emmitAny: (obj, data) -> @emmit(obj, data)
  value: (obj, data) -> data.items.shift()

# ---- expression
ge = (exp, qtd = [1, 1], lbl = null) -> type: "expression", value: exp, quantity: qtd, label: lbl
gd = (times = 1, items = [], labels = {}) -> {items: items, labels: labels, times: times + 1}

test "expression with one and valid", ->
  exp = ge("a")
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, "a")

test "expression with one and invalid", ->
  exp = ge(false)
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, false)

test "expression with one optional valid", ->
  exp = ge("a", [0, 1])
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, "a")

test "expression with one optional invalid", ->
  exp = ge(false, [0, 1])
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, true)

test "expression capturing label", ->
  exp  = ge("a", [1, 1], "el")
  data = gd()
  res  = Emitter.expression.call(FakeContext, exp, data)

  same(data.labels["el"], "a")

test "expression with many and valid", ->
  exp = ge("a", [1, 0])
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, ["a"])

test "expression with many and invalid", ->
  exp = ge(false, [1, 0])
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, false)

test "expression with many optional and valid", ->
  exp = ge("a", [0, 0])
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, ["a"])

test "expression with many optional and invalid", ->
  exp = ge(false, [0, 0])
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, [])

test "expression with many not enough", ->
  exp = ge("a", [2, 0])
  res = Emitter.expression.call(FakeContext, exp, gd())

  same(res, false)

test "expression with many consuming just enough", ->
  data = gd(5)
  exp  = ge("a", [1, 3])
  res  = Emitter.expression.call(FakeContext, exp, data)

  same(res, ["a", "a", "a"])
  same(data.times, 3)

# ---- multi
test "multi with left valid", ->
  res = Emitter.multi.call(FakeContext, {left: "a", right: null})
  same(res, {left: "a", right: null})

test "multi with right valid", ->
  res = Emitter.multi.call(FakeContext, {left: null, right: "b"})
  same(res, {left: null, right: "b"})

test "multi with both valid", ->
  res = Emitter.multi.call(FakeContext, {left: "a", right: "b"})
  same(res, {left: "a", right: "b"})

test "multi with both invalid", ->
  res = Emitter.multi.call(FakeContext, {left: null, right: null})
  same(res, false)

test "multi try sequential order", ->
  data = new EmitterData([
    {stringify: -> "a"}
    {stringify: -> "b"}
  ])

  nodes = ScriptedCss.ExpressionParser.parse("y:b || x:a")
  res = Emitter.emmit(nodes, data)

  same(data.labels.x.stringify(), "a")
  same(data.labels.y.stringify(), "b")

# ---- or
test "or with left valid", ->
  res = Emitter.or.call(FakeContext, {left: "a", right: null})
  same(res, "a")

test "or with right valid", ->
  res = Emitter.or.call(FakeContext, {left: null, right: "b"})
  same(res, "b")

test "or with both valid", ->
  res = Emitter.or.call(FakeContext, {left: "a", right: "b"})
  same(res, "b")

test "or with both invalid", ->
  res = Emitter.or.call(FakeContext, {left: null, right: null})
  same(res, false)

# ---- and
test "and with left valid", ->
  res = Emitter.and.call(FakeContext, {left: "a", right: null})
  same(res, false)

test "and with right valid", ->
  res = Emitter.and.call(FakeContext, {left: null, right: "b"})
  same(res, false)

test "and with both valid", ->
  res = Emitter.and.call(FakeContext, {left: "a", right: "b"})
  same(res, left: "a", right: "b")

test "and with both invalid", ->
  res = Emitter.and.call(FakeContext, {left: null, right: null})
  same(res, false)

# ---- function
test "function", ->
  res = Emitter.function.call(FakeContext, {fn: -> "ok"})
  same(res, "ok")

# ---- value
test "value parsing with value", ->
  ea = stringify: -> "a"
  eb = stringify: -> "b"
  data = {items: [ea, eb], collect: ScriptedCss.ExpressionParser.EmitterData.prototype.collect}
  obj = value: "a"

  res = Emitter.value(obj, data)

  same(res, ea)
  same(data.items, [eb])

test "value parsing without value", ->
  ea = stringify: -> "a"
  eb = stringify: -> "b"
  data = {items: [ea, eb], collect: ScriptedCss.ExpressionParser.EmitterData.prototype.collect}
  obj = value: "c"

  res = Emitter.value(obj, data)

  same(res, false)
  same(data.items, [ea, eb])
