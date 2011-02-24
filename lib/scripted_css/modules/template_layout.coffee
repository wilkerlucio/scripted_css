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

class TemplateRenderer
  constructor: (rule) ->
    try
      [@table, @matrix, @columns, @rows] = TemplateLayoutParser.parse(rule.attributesHash["display"].values)
    catch error
      console.error "Error parsing selector '#{rule.selectorsString()}': #{error}"

class ScriptedCss.Modules.TemplateLayout
  constructor: ->
    ScriptedCss.bind 'scriptLoaded', (css) => @parseCss(css)

  parseCss: (css) ->
    for attr in css.attribute("display")
      continue unless attr.rule.attributesHash["display"].values[0].text

      new TemplateRenderer(attr.rule)

ScriptedCss.Modules.register(ScriptedCss.Modules.TemplateLayout)

# this module does the Template Layout attributes parsing
TemplateLayoutParser =
  parse: (@values) ->
    @parseValues()
    @parseMatrix()

    [@table, @matrix, @columns, @rows]

  parseValues: ->
    @matrix    = []
    @columns   = []
    @rows      = []
    @biggerRow = 0

    i = 0

    while values = @values.slice(i)
      break if values.length == 0
      i += @parseValue(values)

    @normalizeMatrix()
    @normalizeColumns()

  parseValue: (values) ->
    if values[0].text
      @parseRow(values)
    else
      @columns.push(value.value) for value in values
      values.length

  parseRow: (values) ->
    i   = 1
    row = values[0].text.split('')

    @matrix.push(row)
    @biggerRow = Math.max(row.length, @biggerRow)

    size = "auto"

    if values[1]? and values[1].value == "/"
      i += 1

      if values[2]? and !values[2].text
        i += 1
        size = values[2].value

    @rows.push(size)
    i

  normalizeMatrix: ->
    newMatrix = []

    for row in @matrix
      row.push(".") while row.length < @biggerRow
      newMatrix.push(row)

    @matrix = newMatrix

  normalizeColumns: ->
    if @columns.length > @biggerRow
      @columns = @columns.slice(0, @biggerRow)
    else
      @columns.push("auto") while @columns.length < @biggerRow

  parseMatrix: ->
    @table  = []
    history = []
    clear   = {}

    for y in [0...@rows.length]
      row = []

      for x in [0...@columns.length]
        continue if clear["#{x}x#{y}"]
        current = @matrix[y][x]
        [width, height] = [[@columns[x]], [@rows[y]]]

        if current == "."
          row.push(position: '.', width: width, height: height)
          continue

        for id in history
          throw "Position #{current} was already defined, please check your display info." if id == current

        history.push(current)

        [xw, yw, xf, yf] = [1, 1, x + 1, y + 1]

        while xf < @columns.length and @matrix[y][xf] == current
          clear["#{xf}x#{y}"] = true
          width.push(@columns[xf])
          xw += 1
          xf += 1

        while yf < @rows.length and @matrix[yf][x] == current
          clear["#{x}x#{yf}"] = true
          height.push(@rows[yf])
          yw += 1
          yf += 1

        if xw == 1 or yw == 1 # simple line
          row.push(position: current, cols: xw, rows: yw, width: width, height: height)
          continue

        for yv in [(y + 1)...yf]
          for xv in [(x + 1)...xf]
            throw "Invalid position for #{current}, please check your display info." if @matrix[yv][xv] != current
            clear["#{xv}x#{yv}"] = true

        row.push(position: current, cols: xw, rows: yw)

      @table.push(row)

