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

fs            = require "fs"
path          = require "path"
CoffeeScript  = require "coffee-script"
child_process = require 'child_process'
jsp           = require "./vendor/uglifyjs/parse-js"
pro           = require "./vendor/uglifyjs/process"

dependencies = [
  "vendor/peg.js"
  "vendor/underscore-min.js"
]

scriptFiles = [
  "scripted_css.coffee"
  "scripted_css/parser/css_parser.coffee"
  "scripted_css/nodes.coffee"
  "scripted_css/nodes/base.coffee"
  "scripted_css/nodes/stylesheet.coffee"
  "scripted_css/nodes/import.coffee"
  "scripted_css/nodes/media.coffee"
  "scripted_css/nodes/keyframes.coffee"
  "scripted_css/nodes/keyframe_block.coffee"
  "scripted_css/nodes/font_face.coffee"
  "scripted_css/nodes/page.coffee"
  "scripted_css/nodes/rule.coffee"
  "scripted_css/nodes/selector.coffee"
  "scripted_css/nodes/simple_selector.coffee"
  "scripted_css/nodes/id_selector.coffee"
  "scripted_css/nodes/class_selector.coffee"
  "scripted_css/nodes/attribute_selector.coffee"
  "scripted_css/nodes/pseudo_selector.coffee"
  "scripted_css/nodes/declaration.coffee"
  "scripted_css/nodes/declaration_set.coffee"
  "scripted_css/nodes/function.coffee"
  "scripted_css/nodes/value.coffee"
  "scripted_css/nodes/uri.coffee"
  "scripted_css/nodes/operator.coffee"
  "scripted_css/nodes/string.coffee"
  "scripted_css/nodes/identifier.coffee"
  "scripted_css/nodes/hexcolor.coffee"
  # "scripted_css/css_attributes_parser.js"
  # "scripted_css/jquery.coffee"
  # "scripted_css/information.coffee"
  # "scripted_css/common_expansions.coffee"
  # "scripted_css/modules.coffee"
  # "scripted_css/modules/border-radius.coffee"
  # "scripted_css/modules/opacity.coffee"
  # "scripted_css/modules/template_layout.coffee"
  # "scripted_css/modules/transition.coffee"
]

task 'build', 'build scripted css', (options) ->
  source = ""
  vendorSource = ""

  for file in dependencies
    vendorSource += fs.readFileSync(file).toString() + "\n"

  for file in scriptFiles
    filePath = path.join("lib", file)
    source += fs.readFileSync(filePath).toString() + "\n"

  output = vendorSource + CoffeeScript.compile(source)

  fs.writeFileSync "dist/scripted_css.js", output
  console.log "Compiled ScriptedCss to dist/scripted_css.js"

  ast = jsp.parse(output)
  ast = pro.ast_mangle(ast)
  ast = pro.ast_squeeze(ast)

  fs.writeFileSync "dist/scripted_css.min.js", pro.gen_code(ast, ascii_only: true)
  console.log "Compiled ScriptedCss minified to dist/scripted_css.min.js"

task 'dev:compile', 'compile files for development', (options) ->
  invoke 'build'

  child_process.exec 'find test | grep "\.coffee$"', (error, stdout, stderr) ->
    testFiles = stdout.trim().split("\n")
    for file in testFiles
      source = CoffeeScript.compile(fs.readFileSync(file).toString())
      outputPath = path.join(path.dirname(file), path.basename(file, ".coffee") + ".js")
      fs.writeFileSync(outputPath, source)
      console.log "Compiled test file #{outputPath}"

task 'compile:attr_parser', 'compile the css attributes parser', (options) ->
  nodesSource  = fs.readFileSync("./lib/scripted_css/parser/attributes_nodes.coffee").toString()
  parser       = require "./lib/scripted_css/parser/attributes.coffee"
  parserSource = parser.generate(moduleName: "ScriptedCss.AttributesParser")
  parserSource = parserSource.replace("last_column: lstack[lstack.length-1].last_column,", "last_column: lstack[lstack.length-1].last_column") # hack to fix parser for IE
  nodes        = CoffeeScript.compile nodesSource

  fs.writeFileSync "lib/scripted_css/css_attributes_parser.js", parserSource + nodes
  console.log "Compiled attributes parser to lib/scripted_css/css_attributes_parser.js"
