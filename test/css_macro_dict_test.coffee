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

module "Css Macro Dictionary"

test "literal", ->
  res = runMacro("hello", "<literal>")
  ok(res._result.value == "hello")

  res = runMacro("10", "<literal>")
  ok(!res._result)

test "string", ->
  res = runMacro("'str'", "<string>")
  equal(res._result.value, "str")

  res = runMacro("str", "<string>")
  ok(!res._result)

test "length", ->
  res = runMacro("10px", "<length>")
  equal(res._result.value, "10px")

  res = runMacro("10", "<length>")
  ok(!res._result)

test "percentage", ->
  res = runMacro("10%", "<percentage>")
  equal(res._result.value, "10%")

  res = runMacro("10", "<percentage>")
  ok(!res._result)

test "number", ->
  res = runMacro("10", "<number>")
  equal(res._result.value, "10")

  res = runMacro("10px", "<number>")
  ok(!res._result)

test "url", ->
  res = runMacro("url(image.png)", "<url>")
  equal(res._result.value, "image.png")

  res = runMacro("string", "<url>")
  ok(!res._result)

test "color", ->
  res = runMacro("#000", "<color>")
  equal(res._result.value, "#000")

  res = runMacro("#000333", "<color>")
  equal(res._result.value, "#000333")

  res = runMacro("rgb(10 , 15 , 25)", "<color>")
  equal(res._result.stringify(), "rgb(10 , 15 , 25)")

  res = runMacro("rgba(10 , 15 , 25 , 0.5)", "<color>")
  equal(res._result.stringify(), "rgba(10 , 15 , 25 , 0.5)")

  res = runMacro("hsl(10 , 15 , 25)", "<color>")
  equal(res._result.stringify(), "hsl(10 , 15 , 25)")

  res = runMacro("blue", "<color>")
  equal(res._result.value, "blue")

  res = runMacro("string", "<color>")
  ok(!res._result)
