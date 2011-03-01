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
  window.ScriptedCss =
    autoStart: true

    start: ->
      return unless ScriptedCss.autoStart

      originalDisplay = $(document.body).css("display")
      $(document.body).css(display: "none")

      for module in this.Modules.registeredModules
        this.Modules.modules.push(new module())

      @loadStyles ->
        $(document.body).css(display: originalDisplay)

    addStyle: (styleText) ->
      css = document.createElement("style")
      css.type = "text/css"

      if css.styleSheet
        css.styleSheet.cssText = styleText
      else
        css.innerHTML = styleText

      $("head").append(css)

    loadStyles: (callback) ->
      self = this

      $("script[type='text/scripted-css']").each ->
        if this.src
          # TODO: load style
        else
          source = this.innerHTML
          css    = ScriptedCss.CssParser.parse(source)

          self.documentStyle ?= css

          ScriptedCss.trigger("scriptLoaded", css)
          ScriptedCss.addStyle(css.string())

      ScriptedCss.trigger("cssReady", @documentStyle)
      callback()
      ScriptedCss.trigger("afterCallback", @documentStyle)

    # observable methods
    bind: (event, callback) ->
      @eventList ?= {}
      @eventList[event] ?= []
      @eventList[event].push(callback)

    trigger: (event, args...) ->
      callbacks = @eventList?[event] || []
      callback.apply(this, args) for callback in callbacks

    # AST generation helpers
    createAttribute: (name, values) ->
      values = [values] unless $.isArray(values)
      values = (new CssAST.LiteralNode(value) for value in values)

      new CssAST.AttributeNode(name, values)

  $ -> ScriptedCss.start()
)(jQuery)
