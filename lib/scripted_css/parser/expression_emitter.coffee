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

Emitter =
  emmit: (object, data) ->
    self = this
    type = object.type
    fn   = this[type]

    throw new TypeError("invalid type #{type}") unless fn

    data.compute -> fn.call(self, object, data)

  emmitAny: (object, data) ->
    i    = 0
    head = []
    res  = false

    while data.items.length
      break if data.items[0].type == "operator"
      break if res = @emmit(object, data)
      head.push(data.items.shift())

      i += 1

    data.items = head.concat(data.items)

    res

  expression: (obj, data) ->
    [min, max] = obj.quantity
    exp        = obj.value
    label      = obj.label
    result     = null
    ok         = if min > 0 then false else true

    if max != 1
      count = 0
      result = []

      while (max == 0 or count < max) and r = @emmit(exp, data)
        result.push(r)
        count += 1

      result = false if result.length < min
      result = false unless ok or result.length > 0
    else
      result = @emmit(exp, data) || ok

    data.labels[label] = result if label

    result

  multi: (obj, data) ->
    l = @emmitAny(obj.left, data)
    r = @emmitAny(obj.right, data)

    if l or r then {left: l, right: r} else false

  or: (obj, data) ->
    @emmit(obj.right, data) || @emmit(obj.left, data) || false

  and: (obj, data) ->
    l = @emmit(obj.left, data)
    r = @emmit(obj.right, data)

    if l and r then {left: l, right: r} else false

  macro: (obj, data) ->
    id = obj.value
    macro = data.macros.get(id)

    result = @emmit(macro.value, data)
    result = macro.return(result, data) if result and macro.return
    result

  function: (obj, data) ->
    obj.fn(data)

  value: (obj, data) ->
    data.collect (node) -> node.stringify() == obj.value

Emitter.macros = {}

class MacroDict
  constructor: (macros = {}) ->
    @cache = {}
    @macros = {}
    @add(macros)

  add: (macros) ->
    for name, macro of macros
      macro = {value: macro} if _.isString(macro) or _.isFunction(macro)
      macro.value = {type: "function", fn: macro.value} if _.isFunction(macro.value)
      macro.return ||= null

      @macros[name] = macro
      @cache[name] = null

  get: (id) ->
    macro = @macros[id]

    throw new TypeError("invalid macro #{id}") unless macro

    unless @cache[id]
      value = if _.isString(macro.value) then @fetchMacro(macro.value) else macro.value
      @cache[id] = value: value, return: macro.return

    @cache[id]

  fetchMacro: (value) ->
    ScriptedCss.ExpressionParser.parse(value)

class EmitterData
  constructor: (@items, @macros = new MacroDict()) ->
    @items = @items.slice(0)
    @labels = {}

  compute: (fn) ->
    safe = @items.slice(0)
    safeLabels = _.extend({}, @labels)
    result = fn(this)

    unless result
      @items = safe
      @labels = safeLabels

    result

  parse: (expression) ->
    nodes = ScriptedCss.ExpressionParser.parse(expression)
    Emitter.emmit(nodes, this)

  splitOnValue: (value) ->
    lines = []
    row   = []

    for el in @items
      if el.stringify() == value
        lines.push(row)
        row = []
      else
        row.push(el)

    lines.push(row)

    F.map(((row) => new EmitterData(row, @macros)), lines)

  collect: (fn) ->
    return false if @items.length == 0
    el = @items[0]

    if fn(el)
      @items = @items.slice(1)
      return el

    false

window.ScriptedCss.ExpressionParser.Emitter     = Emitter if window?
window.ScriptedCss.ExpressionParser.EmitterData = EmitterData if window?
window.ScriptedCss.ExpressionParser.MacroDict   = MacroDict if window?
