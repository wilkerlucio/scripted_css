fs = require "fs"

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

task 'compile:parser', 'compile the css parser', (options) ->
  parser       = require "./lib/scripted_css/parser"
  parserSource = parser.generate(moduleName: "CssParser")

  fs.writeFile "lib/css_parser.js", parserSource
  console.log "Compiled parser to lib/css_parser.js"
