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

$ = jQuery

window.ScriptedCss =
  autoStart: true

  start: ->
    @documentStyle = new ScriptedCss.Nodes.Stylesheet({type: "stylesheet", charset: null, imports: [], rules: []})

    return unless ScriptedCss.autoStart

    originalDisplay = $(document.body).css("display")
    $(document.body).css(display: "none")

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

    $("style[type='text/scripted-css']").each ->
      source = this.innerHTML
      css    = ScriptedCss.CssParser.parse(source)
      css    = ScriptedCss.Nodes.factory(css)

      ScriptedCss.trigger("scriptLoaded", css)
      self.documentStyle.merge(css)

      ScriptedCss.addStyle(css.stringify())

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

$ -> ScriptedCss.start()
