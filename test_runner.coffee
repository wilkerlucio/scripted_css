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
