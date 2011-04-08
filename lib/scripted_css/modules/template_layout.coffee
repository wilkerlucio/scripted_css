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

(($) ->
  class TemplateRenderer
    constructor: (@rule) ->
      try
        [@table_matrix, @matrix, @columns, @rows] = TemplateLayoutParser.parse(@rule.declarations.get("display").expression.values)
      catch error
        console.error "Error parsing selector '#{@rule.selector.stringify()}': #{error}"

      if @table_matrix
        @collectItems()
        @parseElements()
        @resize()

        $(window).bind "resize", => @resize()

    collectItems: ->
      render = this
      el     = $(@rule.selector.stringify())
      @items = {}

      el.children().each ->
        self = $(this)
        position = self.realCss("position")
        self.css(display: "none")
        self.detach()

        render.items[position] ?= []
        render.items[position].push(self)

    parseElements: ->
      el = $(@rule.selector.stringify())

      if el[0].tagName == "BODY"
        $("html").css(overflow: "hidden")
        el.css(overflow: "hidden")

      @table = $('<table>', css: {width: "100%", height: "100%", margin: "0", padding: "0", border: "0"}, "cellspacing": 0, "cellpadding": 0)
      @cells = {}

      for row in @table_matrix
        rowElement = $("<tr>")

        for cell in row
          css = $.extend({"vertical-align": "top", margin: "0", padding: "0", border: "0"}, @attributesForPosition(cell.position))

          cellElement = $("<td>", css: css, colspan: cell.cols, rowspan: cell.rows)
          rowElement.append(cellElement)

          @cells[cell.position] = cellElement
          cell.element = cellElement

          continue if cell.position == "."

          for item in (@items[cell.position] || [])
            item.css(display: "")
            cellElement.append(item)

        @table.append(rowElement)

      el.append(@table)

    resize: ->
      [starWidth, starHeight] = @calculateStarSize()

      x = 0
      y = 0

      for row in @table_matrix
        x = 0

        for cell in row
          element = cell.element
          width   = @calculateSize(cell.width, starWidth)
          height  = @calculateSize(cell.height, starHeight)

          element.css(width: width + "px", height: height + "px")

          x += cell.cols

    calculateSize: (sizes, star) ->
      sum = 0

      for size in sizes
        return null if size == "auto"

        if size == "*"
          sum += star
          continue
        sum += parseFloat(size)

      sum

    calculateStarSize: ->
      parent = @table.parent()
      [width, height] = [0, 0]

      if parent[0].tagName == "BODY"
        parent.withCss {display: "none"}, =>
          if document.documentElement
            width  = document.documentElement.clientWidth
            height = document.documentElement.clientHeight
          else
            width  = $(document).width()
            height = $(document).height()
      else
        parent.withCss {display: "block"}, =>
          width  = @table.parent().innerWidth()
          height = @table.parent().innerHeight()

      [@starSizeFor(@columns, width), @starSizeFor(@rows, height)]

    starSizeFor: (items, available) ->
      starCount = 0

      for item in items
        continue if item == "auto"

        if item == "*"
          starCount += 1
          continue

        available -= parseFloat(item)

      available / (starCount || 1)

    attributesForPosition: (position) ->
      el = $(@rule.selector.stringify())[0]
      rules = ScriptedCss.documentStyle.rulesForElement(el, true)

      for rule in rules
        sel = rule.selector.last()

        for qualifier in sel.qualifiers
          if qualifier.type == "pseudo_selector" and qualifier.id == "::slot" and qualifier.value.params.stringify() == position
            return rule.propertiesHash()

      {}

  class ScriptedCss.Modules.TemplateLayout
    constructor: ->
      ScriptedCss.bind 'afterCallback', (css) => @parseCss(css)

    parseCss: (css) ->
      for attr in css.property("display")
        continue unless attr.expression.values[0].type == "string"

        new TemplateRenderer(attr.parent.parent)

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
      if values[0].type == "string"
        @parseRow(values)
      else
        @columns.push(value.value) for value in values
        values.length

    parseRow: (values) ->
      i   = 1
      row = values[0].value.replace(/\s+/g, '').split('')

      @matrix.push(row)
      @biggerRow = Math.max(row.length, @biggerRow)

      size = "auto"

      if values[1]? and values[1].value == "/"
        i += 1

        if values[2]? and values[2].type != "string"
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
            row.push(position: '.', width: width, height: height, cols: 1, rows: 1)
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
)(jQuery)
