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

Functional.collect = (fn, memo) ->
  fn = window.Function.toFunction(fn)

  callback = (value) ->
    memo = fn.call(null, memo, value)
    memo

  callback.initial = memo
  callback

Functional.collectUntil = (pred, fn, collector = null) ->
  fn = window.Function.toFunction(fn)
  pred = window.Function.toFunction(pred)
  collector ||= Functional.collect('x.concat([y])', [])
  res = collector.initial

  (value) ->
    while(!pred.call(null, value))
      res = collector.call(null, value)
      value = fn.call(null, value)

    res

Functional.collectUntilLeaf = (obj, property, inclusive = false) ->
  p = Functional.pluck(property)
  i = if inclusive then obj else p(obj)
  Functional.collectUntil(Functional.not(Functional.I), p)(i)
