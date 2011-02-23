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

fs           = require "fs"
path         = require "path"
CoffeeScript = require "coffee-script"
yui          = require "./vendor/yui-compressor/index.js"

scriptFiles = [
  "scripted_css.coffee",
  "scripted_css/css_parser.js",
  "scripted_css/modules.coffee"
  "scripted_css/modules/border-radius.coffee"
]

task 'test', 'run tests', (options) ->
  require.paths.unshift(__dirname + "/vendor")
  require.paths.unshift(__dirname + "/lib")
  require.paths.unshift(__dirname)

  child_process   = require('child_process')
  testrunner      = require("async_testing")

  process.chdir(__dirname)

  setupTests = (tester) ->
    (test) ->
      test.done = test.finish
      test.same = test.deepEqual
      tester(test)

  global.testWrapper = (suite) ->
    testrunner.wrapTests(suite, setupTests)

  # test runner method
  runTests = ->
    child_process.exec 'find test | grep "_test\.coffee$"', (error, stdout, stderr) ->
      files = stdout.trim().split("\n")
      testrunner.run files, process.ARGV, -> process.exit(0)

  # setup database
  runTests()

task 'build', 'build scripted css', (options) ->
  invoke 'compile:parser'

  compile = (file) ->
    source = fs.readFileSync(path.join("lib", file)).toString()
    source = CoffeeScript.compile(source) if path.extname(file) == ".coffee"
    source

  output = ""

  for file in scriptFiles
    source = compile(file)
    output += source + "\n"

  yui.compile output, (compressed) ->
    fs.writeFileSync "dist/scripted_css.js", compressed
    console.log "Compiled ScriptedCss to dist/scripted_css.js"

task 'dev:compile', 'compile files for development', (options) ->
  invoke 'compile:parser'

  compile = (file) ->
    source = fs.readFileSync(path.join("lib", file)).toString()
    source = CoffeeScript.compile(source) if path.extname(file) == ".coffee"
    dirname = path.dirname(file)
    outputPath = path.join("js", dirname, path.basename(file, path.extname(file)) + ".js")
    fs.writeFileSync(outputPath, source)
    console.log("Compiled #{outputPath}")

  for file in scriptFiles
    compile(file)

task 'compile:parser', 'compile the css parser', (options) ->
  astSource    = fs.readFileSync("./lib/scripted_css/parser/ast.coffee").toString()
  parser       = require "./lib/scripted_css/parser"
  parserSource = parser.generate(moduleName: "ScriptedCss.CssParser")
  ast          = CoffeeScript.compile astSource
  ast          += CoffeeScript.compile fs.readFileSync("./lib/scripted_css/parser/parser_configuration.coffee").toString()

  fs.writeFileSync "lib/scripted_css/css_parser.js", parserSource + ast
  console.log "Compiled parser to lib/scripted_css/css_parser.js"
