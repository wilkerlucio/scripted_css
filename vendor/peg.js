(function() {

var undefined;

var PEG = {
  /* PEG.js version. */
  VERSION: "0.5+",

  /*
   * Generates a parser from a specified grammar and returns it.
   *
   * The grammar must be a string in the format described by the metagramar in
   * the parser.pegjs file.
   *
   * Throws |PEG.parser.SyntaxError| if the grammar contains a syntax error or
   * |PEG.GrammarError| if it contains a semantic error. Note that not all
   * errors are detected during the generation and some may protrude to the
   * generated parser and cause its malfunction.
   */
  buildParser: function(grammar) {
    return PEG.compiler.compile(PEG.parser.parse(grammar));
  }
};

/* Thrown when the grammar contains an error. */

PEG.GrammarError = function(message) {
  this.name = "PEG.GrammarError";
  this.message = message;
};

PEG.GrammarError.prototype = Error.prototype;

function contains(array, value) {
  /*
   * Stupid IE does not have Array.prototype.indexOf, otherwise this function
   * would be a one-liner.
   */
  var length = array.length;
  for (var i = 0; i < length; i++) {
    if (array[i] === value) {
      return true;
    }
  }
  return false;
}

function each(array, callback) {
  var length = array.length;
  for (var i = 0; i < length; i++) {
    callback(array[i]);
  }
}

function map(array, callback) {
  var result = [];
  var length = array.length;
  for (var i = 0; i < length; i++) {
    result[i] = callback(array[i]);
  }
  return result;
}

/*
 * Returns a string padded on the left to a desired length with a character.
 *
 * The code needs to be in sync with th code template in the compilation
 * function for "action" nodes.
 */
function padLeft(input, padding, length) {
  var result = input;

  var padLength = length - input.length;
  for (var i = 0; i < padLength; i++) {
    result = padding + result;
  }

  return result;
}

/*
 * Returns an escape sequence for given character. Uses \x for characters <=
 * 0xFF to save space, \u for the rest.
 *
 * The code needs to be in sync with th code template in the compilation
 * function for "action" nodes.
 */
function escape(ch) {
  var charCode = ch.charCodeAt(0);

  if (charCode <= 0xFF) {
    var escapeChar = 'x';
    var length = 2;
  } else {
    var escapeChar = 'u';
    var length = 4;
  }

  return '\\' + escapeChar + padLeft(charCode.toString(16).toUpperCase(), '0', length);
}

/*
 * Surrounds the string with quotes and escapes characters inside so that the
 * result is a valid JavaScript string.
 *
 * The code needs to be in sync with th code template in the compilation
 * function for "action" nodes.
 */
function quote(s) {
  /*
   * ECMA-262, 5th ed., 7.8.4: All characters may appear literally in a string
   * literal except for the closing quote character, backslash, carriage return,
   * line separator, paragraph separator, and line feed. Any character may
   * appear in the form of an escape sequence.
   *
   * For portability, we also escape escape all non-ASCII characters.
   */
  return '"' + s
    .replace(/\\/g, '\\\\')            // backslash
    .replace(/"/g, '\\"')              // closing quote character
    .replace(/\r/g, '\\r')             // carriage return
    .replace(/\n/g, '\\n')             // line feed
    .replace(/[\x80-\uFFFF]/g, escape) // non-ASCII characters
    + '"';
};

/*
 * Escapes characters inside the string so that it can be used as a list of
 * characters in a character class of a regular expression.
 */
function quoteForRegexpClass(s) {
  /*
   * Based on ECMA-262, 5th ed., 7.8.5 & 15.10.1.
   *
   * For portability, we also escape escape all non-ASCII characters.
   */
  return s
    .replace(/\\/g, '\\\\')            // backslash
    .replace(/\0/g, '\\0')             // null, IE needs this
    .replace(/\//g, '\\/')             // closing slash
    .replace(/]/g, '\\]')              // closing bracket
    .replace(/-/g, '\\-')              // dash
    .replace(/\r/g, '\\r')             // carriage return
    .replace(/\n/g, '\\n')             // line feed
    .replace(/[\x80-\uFFFF]/g, escape) // non-ASCII characters
}

/*
 * Builds a node visitor -- a function which takes a node and any number of
 * other parameters, calls an appropriate function according to the node type,
 * passes it all its parameters and returns its value. The functions for various
 * node types are passed in a parameter to |buildNodeVisitor| as a hash.
 */
function buildNodeVisitor(functions) {
  return function(node) {
    return functions[node.type].apply(null, arguments);
  }
}
PEG.compiler = {
  /*
   * Generates a parser from a specified grammar AST. Throws |PEG.GrammarError|
   * if the AST contains a semantic error. Note that not all errors are detected
   * during the generation and some may protrude to the generated parser and
   * cause its malfunction.
   */
  compile: function(ast) {
    var CHECK_NAMES = [
      "missingReferencedRules",
      "leftRecursion"
    ];

    var PASS_NAMES = [
      "proxyRules"
    ];

    for (var i = 0; i < CHECK_NAMES.length; i++) {
      this.checks[CHECK_NAMES[i]](ast);
    }

    for (var i = 0; i < PASS_NAMES.length; i++) {
      ast = this.passes[PASS_NAMES[i]](ast);
    }

    var source = this.emitter(ast);
    var result = eval(source);
    result._source = source;

    return result;
  }
};

/*
 * Checks made on the grammar AST before compilation. Each check is a function
 * that is passed the AST and does not return anything. If the check passes, the
 * function does not do anything special, otherwise it throws
 * |PEG.GrammarError|. The order in which the checks are run is specified in
 * |PEG.compiler.compile| and should be the same as the order of definitions
 * here.
 */
PEG.compiler.checks = {
  /* Checks that all referenced rules exist. */
  missingReferencedRules: function(ast) {
    function nop() {}

    function checkExpression(node) { check(node.expression); }

    function checkSubnodes(propertyName) {
      return function(node) { each(node[propertyName], check); };
    }

    var check = buildNodeVisitor({
      grammar:
        function(node) {
          for (var name in node.rules) {
            check(node.rules[name]);
          }
        },

      rule:         checkExpression,
      choice:       checkSubnodes("alternatives"),
      sequence:     checkSubnodes("elements"),
      labeled:      checkExpression,
      simple_and:   checkExpression,
      simple_not:   checkExpression,
      semantic_and: nop,
      semantic_not: nop,
      optional:     checkExpression,
      zero_or_more: checkExpression,
      one_or_more:  checkExpression,
      action:       checkExpression,

      rule_ref:
        function(node) {
          if (ast.rules[node.name] === undefined) {
            throw new PEG.GrammarError(
              "Referenced rule \"" + node.name + "\" does not exist."
            );
          }
        },

      literal:      nop,
      any:          nop,
      "class":      nop
    });

    check(ast);
  },

  /* Checks that no left recursion is present. */
  leftRecursion: function(ast) {
    function nop() {}

    function checkExpression(node, appliedRules) {
      check(node.expression, appliedRules);
    }

    var check = buildNodeVisitor({
      grammar:
        function(node, appliedRules) {
          for (var name in node.rules) {
            check(node.rules[name], appliedRules);
          }
        },

      rule:
        function(node, appliedRules) {
          check(node.expression, appliedRules.concat(node.name));
        },

      choice:
        function(node, appliedRules) {
          each(node.alternatives, function(alternative) {
            check(alternative, appliedRules);
          });
        },

      sequence:
        function(node, appliedRules) {
          if (node.elements.length > 0) {
            check(node.elements[0], appliedRules);
          }
        },

      labeled:      checkExpression,
      simple_and:   checkExpression,
      simple_not:   checkExpression,
      semantic_and: nop,
      semantic_not: nop,
      optional:     checkExpression,
      zero_or_more: checkExpression,
      one_or_more:  checkExpression,
      action:       checkExpression,

      rule_ref:
        function(node, appliedRules) {
          if (contains(appliedRules, node.name)) {
            throw new PEG.GrammarError(
              "Left recursion detected for rule \"" + node.name + "\"."
            );
          }
          check(ast.rules[node.name], appliedRules);
        },

      literal:      nop,
      any:          nop,
      "class":      nop
    });

    check(ast, []);
  }
};
/*
 * Optimalization passes made on the grammar AST before compilation. Each pass
 * is a function that is passed the AST and returns a new AST. The AST can be
 * modified in-place by the pass. The order in which the passes are run is
 * specified in |PEG.compiler.compile| and should be the same as the order of
 * definitions here.
 */
PEG.compiler.passes = {
  /*
   * Removes proxy rules -- that is, rules that only delegate to other rule.
   */
  proxyRules: function(ast) {
    function isProxyRule(node) {
      return node.type === "rule" && node.expression.type === "rule_ref";
    }

    function replaceRuleRefs(ast, from, to) {
      function nop() {}

      function replaceInExpression(node, from, to) {
        replace(node.expression, from, to);
      }

      function replaceInSubnodes(propertyName) {
        return function(node, from, to) {
          each(node[propertyName], function(subnode) {
            replace(subnode, from, to);
          });
        };
      }

      var replace = buildNodeVisitor({
        grammar:
          function(node, from, to) {
            for (var name in node.rules) {
              replace(node.rules[name], from, to);
            }
          },

        rule:         replaceInExpression,
        choice:       replaceInSubnodes("alternatives"),
        sequence:     replaceInSubnodes("elements"),
        labeled:      replaceInExpression,
        simple_and:   replaceInExpression,
        simple_not:   replaceInExpression,
        semantic_and: nop,
        semantic_not: nop,
        optional:     replaceInExpression,
        zero_or_more: replaceInExpression,
        one_or_more:  replaceInExpression,
        action:       replaceInExpression,

        rule_ref:
          function(node, from, to) {
            if (node.name === from) {
              node.name = to;
            }
          },

        literal:      nop,
        any:          nop,
        "class":      nop
      });

      replace(ast, from, to);
    }

    for (var name in ast.rules) {
      if (isProxyRule(ast.rules[name])) {
        replaceRuleRefs(ast, ast.rules[name].name, ast.rules[name].expression.name);
        if (name === ast.startRule) {
          ast.startRule = ast.rules[name].expression.name;
        }
        delete ast.rules[name];
      }
    }

    return ast;
  }
};
/* Emits the generated code for the AST. */
PEG.compiler.emitter = function(ast) {
  /*
   * Takes parts of code, interpolates variables inside them and joins them with
   * a newline.
   *
   * Variables are delimited with "${" and "}" and their names must be valid
   * identifiers (i.e. they must match [a-zA-Z_][a-zA-Z0-9_]*). Variable values
   * are specified as properties of the last parameter (if this is an object,
   * otherwise empty variable set is assumed). Undefined variables result in
   * throwing |Error|.
   *
   * There can be a filter specified after the variable name, prefixed with "|".
   * The filter name must be a valid identifier. The only recognized filter
   * right now is "string", which quotes the variable value as a JavaScript
   * string. Unrecognized filters result in throwing |Error|.
   *
   * If any part has multiple lines and the first line is indented by some
   * amount of whitespace (as defined by the /\s+/ JavaScript regular
   * expression), second to last lines are indented by the same amount of
   * whitespace. This results in nicely indented multiline code in variables
   * without making the templates look ugly.
   *
   * Examples:
   *
   *   formatCode("foo", "bar");                           // "foo\nbar"
   *   formatCode("foo", "${bar}", { bar: "baz" });        // "foo\nbaz"
   *   formatCode("foo", "${bar}");                        // throws Error
   *   formatCode("foo", "${bar|string}", { bar: "baz" }); // "foo\n\"baz\""
   *   formatCode("foo", "${bar|eeek}", { bar: "baz" });   // throws Error
   *   formatCode("foo", "${bar}", { bar: "  baz\nqux" }); // "foo\n  baz\n  qux"
   */
  function formatCode() {
    function interpolateVariablesInParts(parts) {
      return map(parts, function(part) {
        return part.replace(
          /\$\{([a-zA-Z_][a-zA-Z0-9_]*)(\|([a-zA-Z_][a-zA-Z0-9_]*))?\}/g,
          function(match, name, dummy, filter) {
            var value = vars[name];
            if (value === undefined) {
              throw new Error("Undefined variable: \"" + name + "\".");
            }

            if (filter !== undefined && filter != "") { // JavaScript engines differ here.
              if (filter === "string") {
                return quote(value);
              } else {
                throw new Error("Unrecognized filter: \"" + filter + "\".");
              }
            } else {
              return value;
            }
          }
        );
      });
    }

    function indentMultilineParts(parts) {
      return map(parts, function(part) {
        if (!/\n/.test(part)) { return part; }

        var firstLineWhitespacePrefix = part.match(/^\s*/)[0];
        var lines = part.split("\n");
        var linesIndented = [lines[0]].concat(
          map(lines.slice(1), function(line) {
            return firstLineWhitespacePrefix + line;
          })
        );
        return linesIndented.join("\n");
      });
    }

    var args = Array.prototype.slice.call(arguments);
    var vars = args[args.length - 1] instanceof Object ? args.pop() : {};

    return indentMultilineParts(interpolateVariablesInParts(args)).join("\n");
  };

  /* Unique ID generator. */
  var UID = {
    _counters: {},

    next: function(prefix) {
      this._counters[prefix] = this._counters[prefix] || 0;
      return prefix + this._counters[prefix]++;
    },

    reset: function() {
      this._counters = {};
    }
  };

  var emit = buildNodeVisitor({
    grammar: function(node) {
      var initializerCode = node.initializer !== null
        ? emit(node.initializer)
        : "";

      var parseFunctionDefinitions = [];
      for (var name in node.rules) {
        parseFunctionDefinitions.push(emit(node.rules[name]));
      }

      return formatCode(
        "(function(){",
        "  /* Generated by PEG.js (http://pegjs.majda.cz/). */",
        "  ",
        "  var result = {",
        "    /*",
        "     * Parses the input with a generated parser. If the parsing is successfull,",
        "     * returns a value explicitly or implicitly specified by the grammar from",
        "     * which the parser was generated (see |PEG.buildParser|). If the parsing is",
        "     * unsuccessful, throws |PEG.parser.SyntaxError| describing the error.",
        "     */",
        "    parse: function(input) {",
        "      var pos = 0;",
        "      var reportMatchFailures = true;",
        "      var rightmostMatchFailuresPos = 0;",
        "      var rightmostMatchFailuresExpected = [];",
        "      var cache = {};",
        "      ",
        /* This needs to be in sync with |padLeft| in utils.js. */
        "      function padLeft(input, padding, length) {",
        "        var result = input;",
        "        ",
        "        var padLength = length - input.length;",
        "        for (var i = 0; i < padLength; i++) {",
        "          result = padding + result;",
        "        }",
        "        ",
        "        return result;",
        "      }",
        "      ",
        /* This needs to be in sync with |escape| in utils.js. */
        "      function escape(ch) {",
        "        var charCode = ch.charCodeAt(0);",
        "        ",
        "        if (charCode <= 0xFF) {",
        "          var escapeChar = 'x';",
        "          var length = 2;",
        "        } else {",
        "          var escapeChar = 'u';",
        "          var length = 4;",
        "        }",
        "        ",
        "        return '\\\\' + escapeChar + padLeft(charCode.toString(16).toUpperCase(), '0', length);",
        "      }",
        "      ",
        /* This needs to be in sync with |quote| in utils.js. */
        "      function quote(s) {",
        "        /*",
        "         * ECMA-262, 5th ed., 7.8.4: All characters may appear literally in a",
        "         * string literal except for the closing quote character, backslash,",
        "         * carriage return, line separator, paragraph separator, and line feed.",
        "         * Any character may appear in the form of an escape sequence.",
        "         */",
        "        return '\"' + s",
        "          .replace(/\\\\/g, '\\\\\\\\')            // backslash",
        "          .replace(/\"/g, '\\\\\"')              // closing quote character",
        "          .replace(/\\r/g, '\\\\r')             // carriage return",
        "          .replace(/\\n/g, '\\\\n')             // line feed",
        "          .replace(/[\\x80-\\uFFFF]/g, escape) // non-ASCII characters",
        "          + '\"';",
        "      }",
        "      ",
        "      function matchFailed(failure) {",
        "        if (pos < rightmostMatchFailuresPos) {",
        "          return;",
        "        }",
        "        ",
        "        if (pos > rightmostMatchFailuresPos) {",
        "          rightmostMatchFailuresPos = pos;",
        "          rightmostMatchFailuresExpected = [];",
        "        }",
        "        ",
        "        rightmostMatchFailuresExpected.push(failure);",
        "      }",
        "      ",
        "      ${parseFunctionDefinitions}",
        "      ",
        "      function buildErrorMessage() {",
        "        function buildExpected(failuresExpected) {",
        "          failuresExpected.sort();",
        "          ",
        "          var lastFailure = null;",
        "          var failuresExpectedUnique = [];",
        "          for (var i = 0; i < failuresExpected.length; i++) {",
        "            if (failuresExpected[i] !== lastFailure) {",
        "              failuresExpectedUnique.push(failuresExpected[i]);",
        "              lastFailure = failuresExpected[i];",
        "            }",
        "          }",
        "          ",
        "          switch (failuresExpectedUnique.length) {",
        "            case 0:",
        "              return 'end of input';",
        "            case 1:",
        "              return failuresExpectedUnique[0];",
        "            default:",
        "              return failuresExpectedUnique.slice(0, failuresExpectedUnique.length - 1).join(', ')",
        "                + ' or '",
        "                + failuresExpectedUnique[failuresExpectedUnique.length - 1];",
        "          }",
        "        }",
        "        ",
        "        var expected = buildExpected(rightmostMatchFailuresExpected);",
        "        var actualPos = Math.max(pos, rightmostMatchFailuresPos);",
        "        var actual = actualPos < input.length",
        "          ? quote(input.charAt(actualPos))",
        "          : 'end of input';",
        "        ",
        "        return 'Expected ' + expected + ' but ' + actual + ' found.';",
        "      }",
        "      ",
        "      function computeErrorPosition() {",
        "        /*",
        "         * The first idea was to use |String.split| to break the input up to the",
        "         * error position along newlines and derive the line and column from",
        "         * there. However IE's |split| implementation is so broken that it was",
        "         * enough to prevent it.",
        "         */",
        "        ",
        "        var line = 1;",
        "        var column = 1;",
        "        var seenCR = false;",
        "        ",
        "        for (var i = 0; i <  rightmostMatchFailuresPos; i++) {",
        "          var ch = input.charAt(i);",
        "          if (ch === '\\n') {",
        "            if (!seenCR) { line++; }",
        "            column = 1;",
        "            seenCR = false;",
        "          } else if (ch === '\\r' | ch === '\\u2028' || ch === '\\u2029') {",
        "            line++;",
        "            column = 1;",
        "            seenCR = true;",
        "          } else {",
        "            column++;",
        "            seenCR = false;",
        "          }",
        "        }",
        "        ",
        "        return { line: line, column: column };",
        "      }",
        "      ",
        "      ${initializerCode}",
        "      ",
        "      var result = parse_${startRule}();",
        "      ",
        "      /*",
        "       * The parser is now in one of the following three states:",
        "       *",
        "       * 1. The parser successfully parsed the whole input.",
        "       *",
        "       *    - |result !== null|",
        "       *    - |pos === input.length|",
        "       *    - |rightmostMatchFailuresExpected| may or may not contain something",
        "       *",
        "       * 2. The parser successfully parsed only a part of the input.",
        "       *",
        "       *    - |result !== null|",
        "       *    - |pos < input.length|",
        "       *    - |rightmostMatchFailuresExpected| may or may not contain something",
        "       *",
        "       * 3. The parser did not successfully parse any part of the input.",
        "       *",
        "       *   - |result === null|",
        "       *   - |pos === 0|",
        "       *   - |rightmostMatchFailuresExpected| contains at least one failure",
        "       *",
        "       * All code following this comment (including called functions) must",
        "       * handle these states.",
        "       */",
        "      if (result === null || pos !== input.length) {",
        "        var errorPosition = computeErrorPosition();",
        "        throw new this.SyntaxError(",
        "          buildErrorMessage(),",
        "          errorPosition.line,",
        "          errorPosition.column",
        "        );",
        "      }",
        "      ",
        "      return result;",
        "    },",
        "    ",
        "    /* Returns the parser source code. */",
        "    toSource: function() { return this._source; }",
        "  };",
        "  ",
        "  /* Thrown when a parser encounters a syntax error. */",
        "  ",
        "  result.SyntaxError = function(message, line, column) {",
        "    this.name = 'SyntaxError';",
        "    this.message = message;",
        "    this.line = line;",
        "    this.column = column;",
        "  };",
        "  ",
        "  result.SyntaxError.prototype = Error.prototype;",
        "  ",
        "  return result;",
        "})()",
        {
          initializerCode:          initializerCode,
          parseFunctionDefinitions: parseFunctionDefinitions.join("\n\n"),
          startRule:                node.startRule
        }
      );
    },

    initializer: function(node) {
      return node.code;
    },

    rule: function(node) {
      /*
       * We want to reset variable names at the beginning of every function so
       * that a little change in the source grammar does not change variables in
       * all the generated code. This is desired especially when one has the
       * generated grammar stored in a VCS (this is true e.g. for our
       * metagrammar).
       */
      UID.reset();

      var resultVar = UID.next("result");

      if (node.displayName !== null) {
        var setReportMatchFailuresCode = formatCode(
          "var savedReportMatchFailures = reportMatchFailures;",
          "reportMatchFailures = false;"
        );
        var restoreReportMatchFailuresCode = formatCode(
          "reportMatchFailures = savedReportMatchFailures;"
        );
        var reportMatchFailureCode = formatCode(
          "if (reportMatchFailures && ${resultVar} === null) {",
          "  matchFailed(${displayName|string});",
          "}",
          {
            displayName: node.displayName,
            resultVar:   resultVar
          }
        );
      } else {
        var setReportMatchFailuresCode = "";
        var restoreReportMatchFailuresCode = "";
        var reportMatchFailureCode = "";
      }

      return formatCode(
        "function parse_${name}() {",
        "  var cacheKey = '${name}@' + pos;",
        "  var cachedResult = cache[cacheKey];",
        "  if (cachedResult) {",
        "    pos = cachedResult.nextPos;",
        "    return cachedResult.result;",
        "  }",
        "  ",
        "  ${setReportMatchFailuresCode}",
        "  ${code}",
        "  ${restoreReportMatchFailuresCode}",
        "  ${reportMatchFailureCode}",
        "  ",
        "  cache[cacheKey] = {",
        "    nextPos: pos,",
        "    result:  ${resultVar}",
        "  };",
        "  return ${resultVar};",
        "}",
        {
          name:                           node.name,
          setReportMatchFailuresCode:     setReportMatchFailuresCode,
          restoreReportMatchFailuresCode: restoreReportMatchFailuresCode,
          reportMatchFailureCode:         reportMatchFailureCode,
          code:                           emit(node.expression, resultVar),
          resultVar:                      resultVar
        }
      );
    },

    /*
     * The contract for all code fragments generated by the following functions
     * is as follows:
     *
     * * The code fragment should try to match a part of the input starting with
     * the position indicated in |pos|. That position may point past the end of
     * the input.
     *
     * * If the code fragment matches the input, it advances |pos| after the
     *   matched part of the input and sets variable with a name stored in
     *   |resultVar| to appropriate value, which is always non-null.
     *
     * * If the code fragment does not match the input, it does not change |pos|
     *   and it sets a variable with a name stored in |resultVar| to |null|.
     */

    choice: function(node, resultVar) {
      var code = formatCode(
        "var ${resultVar} = null;",
        { resultVar: resultVar }
      );

      for (var i = node.alternatives.length - 1; i >= 0; i--) {
        var alternativeResultVar = UID.next("result");
        code = formatCode(
          "${alternativeCode}",
          "if (${alternativeResultVar} !== null) {",
          "  var ${resultVar} = ${alternativeResultVar};",
          "} else {",
          "  ${code};",
          "}",
          {
            alternativeCode:      emit(node.alternatives[i], alternativeResultVar),
            alternativeResultVar: alternativeResultVar,
            code:                 code,
            resultVar:            resultVar
          }
        );
      }

      return code;
    },

    sequence: function(node, resultVar) {
      var savedPosVar = UID.next("savedPos");

      var elementResultVars = map(node.elements, function() {
        return UID.next("result")
      });

      var code = formatCode(
        "var ${resultVar} = ${elementResultVarArray};",
        {
          resultVar:             resultVar,
          elementResultVarArray: "[" + elementResultVars.join(", ") + "]"
        }
      );

      for (var i = node.elements.length - 1; i >= 0; i--) {
        code = formatCode(
          "${elementCode}",
          "if (${elementResultVar} !== null) {",
          "  ${code}",
          "} else {",
          "  var ${resultVar} = null;",
          "  pos = ${savedPosVar};",
          "}",
          {
            elementCode:      emit(node.elements[i], elementResultVars[i]),
            elementResultVar: elementResultVars[i],
            code:             code,
            savedPosVar:      savedPosVar,
            resultVar:        resultVar
          }
        );
      }

      return formatCode(
        "var ${savedPosVar} = pos;",
        "${code}",
        {
          code:        code,
          savedPosVar: savedPosVar
        }
      );
    },

    labeled: function(node, resultVar) {
      return emit(node.expression, resultVar);
    },

    simple_and: function(node, resultVar) {
      var savedPosVar                 = UID.next("savedPos");
      var savedReportMatchFailuresVar = UID.next("savedReportMatchFailuresVar");
      var expressionResultVar         = UID.next("result");

      return formatCode(
        "var ${savedPosVar} = pos;",
        "var ${savedReportMatchFailuresVar} = reportMatchFailures;",
        "reportMatchFailures = false;",
        "${expressionCode}",
        "reportMatchFailures = ${savedReportMatchFailuresVar};",
        "if (${expressionResultVar} !== null) {",
        "  var ${resultVar} = '';",
        "  pos = ${savedPosVar};",
        "} else {",
        "  var ${resultVar} = null;",
        "}",
        {
          expressionCode:              emit(node.expression, expressionResultVar),
          expressionResultVar:         expressionResultVar,
          savedPosVar:                 savedPosVar,
          savedReportMatchFailuresVar: savedReportMatchFailuresVar,
          resultVar:                   resultVar
        }
      );
    },

    simple_not: function(node, resultVar) {
      var savedPosVar                 = UID.next("savedPos");
      var savedReportMatchFailuresVar = UID.next("savedReportMatchFailuresVar");
      var expressionResultVar         = UID.next("result");

      return formatCode(
        "var ${savedPosVar} = pos;",
        "var ${savedReportMatchFailuresVar} = reportMatchFailures;",
        "reportMatchFailures = false;",
        "${expressionCode}",
        "reportMatchFailures = ${savedReportMatchFailuresVar};",
        "if (${expressionResultVar} === null) {",
        "  var ${resultVar} = '';",
        "} else {",
        "  var ${resultVar} = null;",
        "  pos = ${savedPosVar};",
        "}",
        {
          expressionCode:              emit(node.expression, expressionResultVar),
          expressionResultVar:         expressionResultVar,
          savedPosVar:                 savedPosVar,
          savedReportMatchFailuresVar: savedReportMatchFailuresVar,
          resultVar:                   resultVar
        }
      );
    },

    semantic_and: function(node, resultVar) {
      return formatCode(
        "var ${resultVar} = (function() {${actionCode}})() ? '' : null;",
        {
          actionCode:  node.code,
          resultVar:   resultVar
        }
      );
    },

    semantic_not: function(node, resultVar) {
      return formatCode(
        "var ${resultVar} = (function() {${actionCode}})() ? null : '';",
        {
          actionCode:  node.code,
          resultVar:   resultVar
        }
      );
    },

    optional: function(node, resultVar) {
      var expressionResultVar = UID.next("result");

      return formatCode(
        "${expressionCode}",
        "var ${resultVar} = ${expressionResultVar} !== null ? ${expressionResultVar} : '';",
        {
          expressionCode:      emit(node.expression, expressionResultVar),
          expressionResultVar: expressionResultVar,
          resultVar:           resultVar
        }
      );
    },

    zero_or_more: function(node, resultVar) {
      var expressionResultVar = UID.next("result");

      return formatCode(
        "var ${resultVar} = [];",
        "${expressionCode}",
        "while (${expressionResultVar} !== null) {",
        "  ${resultVar}.push(${expressionResultVar});",
        "  ${expressionCode}",
        "}",
        {
          expressionCode:      emit(node.expression, expressionResultVar),
          expressionResultVar: expressionResultVar,
          resultVar:           resultVar
        }
      );
    },

    one_or_more: function(node, resultVar) {
      var expressionResultVar = UID.next("result");

      return formatCode(
        "${expressionCode}",
        "if (${expressionResultVar} !== null) {",
        "  var ${resultVar} = [];",
        "  while (${expressionResultVar} !== null) {",
        "    ${resultVar}.push(${expressionResultVar});",
        "    ${expressionCode}",
        "  }",
        "} else {",
        "  var ${resultVar} = null;",
        "}",
        {
          expressionCode:      emit(node.expression, expressionResultVar),
          expressionResultVar: expressionResultVar,
          resultVar:           resultVar
        }
      );
    },

    action: function(node, resultVar) {
      /*
       * In case of sequences, we splat their elements into function arguments
       * one by one. Example:
       *
       *   start: a:"a" b:"b" c:"c" { alert(arguments.length) }  // => 3
       *
       * This behavior is reflected in this function.
       */

      var expressionResultVar = UID.next("result");

      if (node.expression.type === "sequence") {
        var formalParams = [];
        var actualParams = [];

        var elements = node.expression.elements;
        var elementsLength = elements.length;
        for (var i = 0; i < elementsLength; i++) {
          if (elements[i].type === "labeled") {
            formalParams.push(elements[i].label);
            actualParams.push(expressionResultVar + "[" + i + "]");
          }
        }
      } else if (node.expression.type === "labeled") {
        var formalParams = [node.expression.label];
        var actualParams = [expressionResultVar];
      } else {
        var formalParams = [];
        var actualParams = [];
      }

      return formatCode(
        "${expressionCode}",
        "var ${resultVar} = ${expressionResultVar} !== null",
        "  ? (function(${formalParams}) {${actionCode}})(${actualParams})",
        "  : null;",
        {
          expressionCode:      emit(node.expression, expressionResultVar),
          expressionResultVar: expressionResultVar,
          actionCode:          node.code,
          formalParams:        formalParams.join(", "),
          actualParams:        actualParams.join(", "),
          resultVar:           resultVar
        }
      );
    },

    rule_ref: function(node, resultVar) {
      return formatCode(
        "var ${resultVar} = ${ruleMethod}();",
        {
          ruleMethod: "parse_" + node.name,
          resultVar:  resultVar
        }
      );
    },

    literal: function(node, resultVar) {
      return formatCode(
        "if (input.substr(pos, ${length}) === ${value|string}) {",
        "  var ${resultVar} = ${value|string};",
        "  pos += ${length};",
        "} else {",
        "  var ${resultVar} = null;",
        "  if (reportMatchFailures) {",
        "    matchFailed(${valueQuoted|string});",
        "  }",
        "}",
        {
          value:       node.value,
          valueQuoted: quote(node.value),
          length:      node.value.length,
          resultVar:   resultVar
        }
      );
    },

    any: function(node, resultVar) {
      return formatCode(
        "if (input.length > pos) {",
        "  var ${resultVar} = input.charAt(pos);",
        "  pos++;",
        "} else {",
        "  var ${resultVar} = null;",
        "  if (reportMatchFailures) {",
        "    matchFailed('any character');",
        "  }",
        "}",
        { resultVar: resultVar }
      );
    },

    "class": function(node, resultVar) {
      if (node.parts.length > 0) {
        var regexp = "/^["
          + (node.inverted ? "^" : "")
          + map(node.parts, function(part) {
              return part instanceof Array
                ? quoteForRegexpClass(part[0])
                  + "-"
                  + quoteForRegexpClass(part[1])
                : quoteForRegexpClass(part);
            }).join("")
          + "]/";
      } else {
        /*
         * Stupid IE considers regexps /[]/ and /[^]/ syntactically invalid, so
         * we translate them into euqivalents it can handle.
         */
        var regexp = node.inverted ? "/^[\\S\\s]/" : "/^(?!)/";
      }

      return formatCode(
        "if (input.substr(pos).match(${regexp}) !== null) {",
        "  var ${resultVar} = input.charAt(pos);",
        "  pos++;",
        "} else {",
        "  var ${resultVar} = null;",
        "  if (reportMatchFailures) {",
        "    matchFailed(${rawText|string});",
        "  }",
        "}",
        {
          regexp:    regexp,
          rawText:   node.rawText,
          resultVar: resultVar
        }
      );
    }
  });

  return emit(ast);
};

PEG.parser = PEG.compiler.compile({
  "type": "grammar",
  "initializer": null,
  "rules": {
    "grammar": {
      "type": "rule",
      "name": "grammar",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "rule_ref",
              "name": "__"
            },
            {
              "type": "labeled",
              "label": "initializer",
              "expression": {
                "type": "optional",
                "expression": {
                  "type": "rule_ref",
                  "name": "initializer"
                }
              }
            },
            {
              "type": "labeled",
              "label": "rules",
              "expression": {
                "type": "one_or_more",
                "expression": {
                  "type": "rule_ref",
                  "name": "rule"
                }
              }
            }
          ]
        },
        "code": "\n      var rulesConverted = {};\n      each(rules, function(rule) { rulesConverted[rule.name] = rule; });\n\n      return {\n        type:        \"grammar\",\n        initializer: initializer !== \"\" ? initializer : null,\n        rules:       rulesConverted,\n        startRule:   rules[0].name\n      }\n    "
      }
    },
    "initializer": {
      "type": "rule",
      "name": "initializer",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "labeled",
              "label": "code",
              "expression": {
                "type": "rule_ref",
                "name": "action"
              }
            },
            {
              "type": "optional",
              "expression": {
                "type": "rule_ref",
                "name": "semicolon"
              }
            }
          ]
        },
        "code": "\n      return {\n        type: \"initializer\",\n        code: code\n      };\n    "
      }
    },
    "rule": {
      "type": "rule",
      "name": "rule",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "labeled",
              "label": "name",
              "expression": {
                "type": "rule_ref",
                "name": "identifier"
              }
            },
            {
              "type": "labeled",
              "label": "displayName",
              "expression": {
                "type": "choice",
                "alternatives": [
                  {
                    "type": "rule_ref",
                    "name": "literal"
                  },
                  {
                    "type": "literal",
                    "value": ""
                  }
                ]
              }
            },
            {
              "type": "rule_ref",
              "name": "equals"
            },
            {
              "type": "labeled",
              "label": "expression",
              "expression": {
                "type": "rule_ref",
                "name": "expression"
              }
            },
            {
              "type": "optional",
              "expression": {
                "type": "rule_ref",
                "name": "semicolon"
              }
            }
          ]
        },
        "code": "\n      return {\n        type:        \"rule\",\n        name:        name,\n        displayName: displayName !== \"\" ? displayName : null,\n        expression:  expression\n      };\n    "
      }
    },
    "expression": {
      "type": "rule",
      "name": "expression",
      "displayName": null,
      "expression": {
        "type": "rule_ref",
        "name": "choice"
      }
    },
    "choice": {
      "type": "rule",
      "name": "choice",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "labeled",
              "label": "head",
              "expression": {
                "type": "rule_ref",
                "name": "sequence"
              }
            },
            {
              "type": "labeled",
              "label": "tail",
              "expression": {
                "type": "zero_or_more",
                "expression": {
                  "type": "sequence",
                  "elements": [
                    {
                      "type": "rule_ref",
                      "name": "slash"
                    },
                    {
                      "type": "rule_ref",
                      "name": "sequence"
                    }
                  ]
                }
              }
            }
          ]
        },
        "code": "\n      if (tail.length > 0) {\n        var alternatives = [head].concat(map(\n            tail,\n            function(element) { return element[1]; }\n        ));\n        return {\n          type:         \"choice\",\n          alternatives: alternatives\n        }\n      } else {\n        return head;\n      }\n    "
      }
    },
    "sequence": {
      "type": "rule",
      "name": "sequence",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "labeled",
                  "label": "elements",
                  "expression": {
                    "type": "zero_or_more",
                    "expression": {
                      "type": "rule_ref",
                      "name": "labeled"
                    }
                  }
                },
                {
                  "type": "labeled",
                  "label": "code",
                  "expression": {
                    "type": "rule_ref",
                    "name": "action"
                  }
                }
              ]
            },
            "code": "\n      var expression = elements.length != 1\n        ? {\n            type:     \"sequence\",\n            elements: elements\n          }\n        : elements[0];\n      return {\n        type:       \"action\",\n        expression: expression,\n        code:       code\n      };\n    "
          },
          {
            "type": "action",
            "expression": {
              "type": "labeled",
              "label": "elements",
              "expression": {
                "type": "zero_or_more",
                "expression": {
                  "type": "rule_ref",
                  "name": "labeled"
                }
              }
            },
            "code": "\n      return elements.length != 1\n        ? {\n            type:     \"sequence\",\n            elements: elements\n          }\n        : elements[0];\n    "
          }
        ]
      }
    },
    "labeled": {
      "type": "rule",
      "name": "labeled",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "labeled",
                  "label": "label",
                  "expression": {
                    "type": "rule_ref",
                    "name": "identifier"
                  }
                },
                {
                  "type": "rule_ref",
                  "name": "colon"
                },
                {
                  "type": "labeled",
                  "label": "expression",
                  "expression": {
                    "type": "rule_ref",
                    "name": "prefixed"
                  }
                }
              ]
            },
            "code": "\n      return {\n        type:       \"labeled\",\n        label:      label,\n        expression: expression\n      };\n    "
          },
          {
            "type": "rule_ref",
            "name": "prefixed"
          }
        ]
      }
    },
    "prefixed": {
      "type": "rule",
      "name": "prefixed",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "rule_ref",
                  "name": "and"
                },
                {
                  "type": "labeled",
                  "label": "code",
                  "expression": {
                    "type": "rule_ref",
                    "name": "action"
                  }
                }
              ]
            },
            "code": "\n      return {\n        type: \"semantic_and\",\n        code: code\n      };\n    "
          },
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "rule_ref",
                  "name": "and"
                },
                {
                  "type": "labeled",
                  "label": "expression",
                  "expression": {
                    "type": "rule_ref",
                    "name": "suffixed"
                  }
                }
              ]
            },
            "code": "\n      return {\n        type:       \"simple_and\",\n        expression: expression\n      };\n    "
          },
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "rule_ref",
                  "name": "not"
                },
                {
                  "type": "labeled",
                  "label": "code",
                  "expression": {
                    "type": "rule_ref",
                    "name": "action"
                  }
                }
              ]
            },
            "code": "\n      return {\n        type: \"semantic_not\",\n        code: code\n      };\n    "
          },
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "rule_ref",
                  "name": "not"
                },
                {
                  "type": "labeled",
                  "label": "expression",
                  "expression": {
                    "type": "rule_ref",
                    "name": "suffixed"
                  }
                }
              ]
            },
            "code": "\n      return {\n        type:       \"simple_not\",\n        expression: expression\n      };\n    "
          },
          {
            "type": "rule_ref",
            "name": "suffixed"
          }
        ]
      }
    },
    "suffixed": {
      "type": "rule",
      "name": "suffixed",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "labeled",
                  "label": "expression",
                  "expression": {
                    "type": "rule_ref",
                    "name": "primary"
                  }
                },
                {
                  "type": "rule_ref",
                  "name": "question"
                }
              ]
            },
            "code": "\n      return {\n        type:       \"optional\",\n        expression: expression\n      };\n    "
          },
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "labeled",
                  "label": "expression",
                  "expression": {
                    "type": "rule_ref",
                    "name": "primary"
                  }
                },
                {
                  "type": "rule_ref",
                  "name": "star"
                }
              ]
            },
            "code": "\n      return {\n        type:       \"zero_or_more\",\n        expression: expression\n      };\n    "
          },
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "labeled",
                  "label": "expression",
                  "expression": {
                    "type": "rule_ref",
                    "name": "primary"
                  }
                },
                {
                  "type": "rule_ref",
                  "name": "plus"
                }
              ]
            },
            "code": "\n      return {\n        type:       \"one_or_more\",\n        expression: expression\n      };\n    "
          },
          {
            "type": "rule_ref",
            "name": "primary"
          }
        ]
      }
    },
    "primary": {
      "type": "rule",
      "name": "primary",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "labeled",
                  "label": "name",
                  "expression": {
                    "type": "rule_ref",
                    "name": "identifier"
                  }
                },
                {
                  "type": "simple_not",
                  "expression": {
                    "type": "sequence",
                    "elements": [
                      {
                        "type": "choice",
                        "alternatives": [
                          {
                            "type": "rule_ref",
                            "name": "literal"
                          },
                          {
                            "type": "literal",
                            "value": ""
                          }
                        ]
                      },
                      {
                        "type": "rule_ref",
                        "name": "equals"
                      }
                    ]
                  }
                }
              ]
            },
            "code": "\n      return {\n        type: \"rule_ref\",\n        name: name\n      };\n    "
          },
          {
            "type": "action",
            "expression": {
              "type": "labeled",
              "label": "value",
              "expression": {
                "type": "rule_ref",
                "name": "literal"
              }
            },
            "code": "\n      return {\n        type:  \"literal\",\n        value: value\n      };\n    "
          },
          {
            "type": "action",
            "expression": {
              "type": "rule_ref",
              "name": "dot"
            },
            "code": " return { type: \"any\" }; "
          },
          {
            "type": "rule_ref",
            "name": "class"
          },
          {
            "type": "action",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "rule_ref",
                  "name": "lparen"
                },
                {
                  "type": "labeled",
                  "label": "expression",
                  "expression": {
                    "type": "rule_ref",
                    "name": "expression"
                  }
                },
                {
                  "type": "rule_ref",
                  "name": "rparen"
                }
              ]
            },
            "code": " return expression; "
          }
        ]
      }
    },
    "action": {
      "type": "rule",
      "name": "action",
      "displayName": "action",
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "labeled",
              "label": "braced",
              "expression": {
                "type": "rule_ref",
                "name": "braced"
              }
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return braced.substr(1, braced.length - 2); "
      }
    },
    "braced": {
      "type": "rule",
      "name": "braced",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "{"
            },
            {
              "type": "labeled",
              "label": "parts",
              "expression": {
                "type": "zero_or_more",
                "expression": {
                  "type": "choice",
                  "alternatives": [
                    {
                      "type": "rule_ref",
                      "name": "braced"
                    },
                    {
                      "type": "rule_ref",
                      "name": "nonBraceCharacter"
                    }
                  ]
                }
              }
            },
            {
              "type": "literal",
              "value": "}"
            }
          ]
        },
        "code": "\n      return \"{\" + parts.join(\"\") + \"}\";\n    "
      }
    },
    "nonBraceCharacters": {
      "type": "rule",
      "name": "nonBraceCharacters",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "labeled",
          "label": "chars",
          "expression": {
            "type": "one_or_more",
            "expression": {
              "type": "rule_ref",
              "name": "nonBraceCharacter"
            }
          }
        },
        "code": " return chars.join(\"\"); "
      }
    },
    "nonBraceCharacter": {
      "type": "rule",
      "name": "nonBraceCharacter",
      "displayName": null,
      "expression": {
        "type": "class",
        "inverted": true,
        "parts": [
          "{",
          "}"
        ],
        "rawText": "[^{}]"
      }
    },
    "equals": {
      "type": "rule",
      "name": "equals",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "="
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \"=\"; "
      }
    },
    "colon": {
      "type": "rule",
      "name": "colon",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": ":"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \":\"; "
      }
    },
    "semicolon": {
      "type": "rule",
      "name": "semicolon",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": ";"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \";\"; "
      }
    },
    "slash": {
      "type": "rule",
      "name": "slash",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "/"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \"/\"; "
      }
    },
    "and": {
      "type": "rule",
      "name": "and",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "&"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \"&\"; "
      }
    },
    "not": {
      "type": "rule",
      "name": "not",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "!"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \"!\"; "
      }
    },
    "question": {
      "type": "rule",
      "name": "question",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "?"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \"?\"; "
      }
    },
    "star": {
      "type": "rule",
      "name": "star",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "*"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \"*\"; "
      }
    },
    "plus": {
      "type": "rule",
      "name": "plus",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "+"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \"+\"; "
      }
    },
    "lparen": {
      "type": "rule",
      "name": "lparen",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "("
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \"(\"; "
      }
    },
    "rparen": {
      "type": "rule",
      "name": "rparen",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": ")"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \")\"; "
      }
    },
    "dot": {
      "type": "rule",
      "name": "dot",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "."
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return \".\"; "
      }
    },
    "identifier": {
      "type": "rule",
      "name": "identifier",
      "displayName": "identifier",
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "labeled",
              "label": "head",
              "expression": {
                "type": "choice",
                "alternatives": [
                  {
                    "type": "rule_ref",
                    "name": "letter"
                  },
                  {
                    "type": "literal",
                    "value": "_"
                  },
                  {
                    "type": "literal",
                    "value": "$"
                  }
                ]
              }
            },
            {
              "type": "labeled",
              "label": "tail",
              "expression": {
                "type": "zero_or_more",
                "expression": {
                  "type": "choice",
                  "alternatives": [
                    {
                      "type": "rule_ref",
                      "name": "letter"
                    },
                    {
                      "type": "rule_ref",
                      "name": "digit"
                    },
                    {
                      "type": "literal",
                      "value": "_"
                    },
                    {
                      "type": "literal",
                      "value": "$"
                    }
                  ]
                }
              }
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": "\n      return head + tail.join(\"\");\n    "
      }
    },
    "literal": {
      "type": "rule",
      "name": "literal",
      "displayName": "literal",
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "labeled",
              "label": "literal",
              "expression": {
                "type": "choice",
                "alternatives": [
                  {
                    "type": "rule_ref",
                    "name": "doubleQuotedLiteral"
                  },
                  {
                    "type": "rule_ref",
                    "name": "singleQuotedLiteral"
                  }
                ]
              }
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": " return literal; "
      }
    },
    "doubleQuotedLiteral": {
      "type": "rule",
      "name": "doubleQuotedLiteral",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "\""
            },
            {
              "type": "labeled",
              "label": "chars",
              "expression": {
                "type": "zero_or_more",
                "expression": {
                  "type": "rule_ref",
                  "name": "doubleQuotedCharacter"
                }
              }
            },
            {
              "type": "literal",
              "value": "\""
            }
          ]
        },
        "code": " return chars.join(\"\"); "
      }
    },
    "doubleQuotedCharacter": {
      "type": "rule",
      "name": "doubleQuotedCharacter",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "rule_ref",
            "name": "simpleDoubleQuotedCharacter"
          },
          {
            "type": "rule_ref",
            "name": "simpleEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "zeroEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "hexEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "unicodeEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "eolEscapeSequence"
          }
        ]
      }
    },
    "simpleDoubleQuotedCharacter": {
      "type": "rule",
      "name": "simpleDoubleQuotedCharacter",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "simple_not",
              "expression": {
                "type": "choice",
                "alternatives": [
                  {
                    "type": "literal",
                    "value": "\""
                  },
                  {
                    "type": "literal",
                    "value": "\\"
                  },
                  {
                    "type": "rule_ref",
                    "name": "eolChar"
                  }
                ]
              }
            },
            {
              "type": "labeled",
              "label": "char_",
              "expression": {
                "type": "any"
              }
            }
          ]
        },
        "code": " return char_; "
      }
    },
    "singleQuotedLiteral": {
      "type": "rule",
      "name": "singleQuotedLiteral",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "'"
            },
            {
              "type": "labeled",
              "label": "chars",
              "expression": {
                "type": "zero_or_more",
                "expression": {
                  "type": "rule_ref",
                  "name": "singleQuotedCharacter"
                }
              }
            },
            {
              "type": "literal",
              "value": "'"
            }
          ]
        },
        "code": " return chars.join(\"\"); "
      }
    },
    "singleQuotedCharacter": {
      "type": "rule",
      "name": "singleQuotedCharacter",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "rule_ref",
            "name": "simpleSingleQuotedCharacter"
          },
          {
            "type": "rule_ref",
            "name": "simpleEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "zeroEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "hexEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "unicodeEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "eolEscapeSequence"
          }
        ]
      }
    },
    "simpleSingleQuotedCharacter": {
      "type": "rule",
      "name": "simpleSingleQuotedCharacter",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "simple_not",
              "expression": {
                "type": "choice",
                "alternatives": [
                  {
                    "type": "literal",
                    "value": "'"
                  },
                  {
                    "type": "literal",
                    "value": "\\"
                  },
                  {
                    "type": "rule_ref",
                    "name": "eolChar"
                  }
                ]
              }
            },
            {
              "type": "labeled",
              "label": "char_",
              "expression": {
                "type": "any"
              }
            }
          ]
        },
        "code": " return char_; "
      }
    },
    "class": {
      "type": "rule",
      "name": "class",
      "displayName": "character class",
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "["
            },
            {
              "type": "labeled",
              "label": "inverted",
              "expression": {
                "type": "optional",
                "expression": {
                  "type": "literal",
                  "value": "^"
                }
              }
            },
            {
              "type": "labeled",
              "label": "parts",
              "expression": {
                "type": "zero_or_more",
                "expression": {
                  "type": "choice",
                  "alternatives": [
                    {
                      "type": "rule_ref",
                      "name": "classCharacterRange"
                    },
                    {
                      "type": "rule_ref",
                      "name": "classCharacter"
                    }
                  ]
                }
              }
            },
            {
              "type": "literal",
              "value": "]"
            },
            {
              "type": "rule_ref",
              "name": "__"
            }
          ]
        },
        "code": "\n      var partsConverted = map(parts, function(part) { return part.data; });\n      var rawText = \"[\"\n        + inverted\n        + map(parts, function(part) { return part.rawText; }).join(\"\")\n        + \"]\";\n\n      return {\n        type:     \"class\",\n        inverted: inverted === \"^\",\n        parts:    partsConverted,\n        // FIXME: Get the raw text from the input directly.\n        rawText:  rawText\n      };\n    "
      }
    },
    "classCharacterRange": {
      "type": "rule",
      "name": "classCharacterRange",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "labeled",
              "label": "begin",
              "expression": {
                "type": "rule_ref",
                "name": "classCharacter"
              }
            },
            {
              "type": "literal",
              "value": "-"
            },
            {
              "type": "labeled",
              "label": "end",
              "expression": {
                "type": "rule_ref",
                "name": "classCharacter"
              }
            }
          ]
        },
        "code": "\n      if (begin.data.charCodeAt(0) > end.data.charCodeAt(0)) {\n        throw new this.SyntaxError(\n          \"Invalid character range: \" + begin.rawText + \"-\" + end.rawText + \".\"\n        );\n      }\n\n      return {\n        data:    [begin.data, end.data],\n        // FIXME: Get the raw text from the input directly.\n        rawText: begin.rawText + \"-\" + end.rawText\n      }\n    "
      }
    },
    "classCharacter": {
      "type": "rule",
      "name": "classCharacter",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "labeled",
          "label": "char_",
          "expression": {
            "type": "rule_ref",
            "name": "bracketDelimitedCharacter"
          }
        },
        "code": "\n      return {\n        data:    char_,\n        // FIXME: Get the raw text from the input directly.\n        rawText: quoteForRegexpClass(char_)\n      };\n    "
      }
    },
    "bracketDelimitedCharacter": {
      "type": "rule",
      "name": "bracketDelimitedCharacter",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "rule_ref",
            "name": "simpleBracketDelimitedCharacter"
          },
          {
            "type": "rule_ref",
            "name": "simpleEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "zeroEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "hexEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "unicodeEscapeSequence"
          },
          {
            "type": "rule_ref",
            "name": "eolEscapeSequence"
          }
        ]
      }
    },
    "simpleBracketDelimitedCharacter": {
      "type": "rule",
      "name": "simpleBracketDelimitedCharacter",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "simple_not",
              "expression": {
                "type": "choice",
                "alternatives": [
                  {
                    "type": "literal",
                    "value": "]"
                  },
                  {
                    "type": "literal",
                    "value": "\\"
                  },
                  {
                    "type": "rule_ref",
                    "name": "eolChar"
                  }
                ]
              }
            },
            {
              "type": "labeled",
              "label": "char_",
              "expression": {
                "type": "any"
              }
            }
          ]
        },
        "code": " return char_; "
      }
    },
    "simpleEscapeSequence": {
      "type": "rule",
      "name": "simpleEscapeSequence",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "\\"
            },
            {
              "type": "simple_not",
              "expression": {
                "type": "choice",
                "alternatives": [
                  {
                    "type": "rule_ref",
                    "name": "digit"
                  },
                  {
                    "type": "literal",
                    "value": "x"
                  },
                  {
                    "type": "literal",
                    "value": "u"
                  },
                  {
                    "type": "rule_ref",
                    "name": "eolChar"
                  }
                ]
              }
            },
            {
              "type": "labeled",
              "label": "char_",
              "expression": {
                "type": "any"
              }
            }
          ]
        },
        "code": "\n      return char_\n        .replace(\"b\", \"\\b\")\n        .replace(\"f\", \"\\f\")\n        .replace(\"n\", \"\\n\")\n        .replace(\"r\", \"\\r\")\n        .replace(\"t\", \"\\t\")\n        .replace(\"v\", \"\\x0B\") // IE does not recognize \"\\v\".\n    "
      }
    },
    "zeroEscapeSequence": {
      "type": "rule",
      "name": "zeroEscapeSequence",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "\\0"
            },
            {
              "type": "simple_not",
              "expression": {
                "type": "rule_ref",
                "name": "digit"
              }
            }
          ]
        },
        "code": " return \"\\0\"; "
      }
    },
    "hexEscapeSequence": {
      "type": "rule",
      "name": "hexEscapeSequence",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "\\x"
            },
            {
              "type": "labeled",
              "label": "h1",
              "expression": {
                "type": "rule_ref",
                "name": "hexDigit"
              }
            },
            {
              "type": "labeled",
              "label": "h2",
              "expression": {
                "type": "rule_ref",
                "name": "hexDigit"
              }
            }
          ]
        },
        "code": "\n      return String.fromCharCode(parseInt(\"0x\" + h1 + h2));\n    "
      }
    },
    "unicodeEscapeSequence": {
      "type": "rule",
      "name": "unicodeEscapeSequence",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "\\u"
            },
            {
              "type": "labeled",
              "label": "h1",
              "expression": {
                "type": "rule_ref",
                "name": "hexDigit"
              }
            },
            {
              "type": "labeled",
              "label": "h2",
              "expression": {
                "type": "rule_ref",
                "name": "hexDigit"
              }
            },
            {
              "type": "labeled",
              "label": "h3",
              "expression": {
                "type": "rule_ref",
                "name": "hexDigit"
              }
            },
            {
              "type": "labeled",
              "label": "h4",
              "expression": {
                "type": "rule_ref",
                "name": "hexDigit"
              }
            }
          ]
        },
        "code": "\n      return String.fromCharCode(parseInt(\"0x\" + h1 + h2 + h3 + h4));\n    "
      }
    },
    "eolEscapeSequence": {
      "type": "rule",
      "name": "eolEscapeSequence",
      "displayName": null,
      "expression": {
        "type": "action",
        "expression": {
          "type": "sequence",
          "elements": [
            {
              "type": "literal",
              "value": "\\"
            },
            {
              "type": "labeled",
              "label": "eol",
              "expression": {
                "type": "rule_ref",
                "name": "eol"
              }
            }
          ]
        },
        "code": " return eol; "
      }
    },
    "digit": {
      "type": "rule",
      "name": "digit",
      "displayName": null,
      "expression": {
        "type": "class",
        "inverted": false,
        "parts": [
          [
            "0",
            "9"
          ]
        ],
        "rawText": "[0-9]"
      }
    },
    "hexDigit": {
      "type": "rule",
      "name": "hexDigit",
      "displayName": null,
      "expression": {
        "type": "class",
        "inverted": false,
        "parts": [
          [
            "0",
            "9"
          ],
          [
            "a",
            "f"
          ],
          [
            "A",
            "F"
          ]
        ],
        "rawText": "[0-9a-fA-F]"
      }
    },
    "letter": {
      "type": "rule",
      "name": "letter",
      "displayName": null,
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "rule_ref",
            "name": "lowerCaseLetter"
          },
          {
            "type": "rule_ref",
            "name": "upperCaseLetter"
          }
        ]
      }
    },
    "lowerCaseLetter": {
      "type": "rule",
      "name": "lowerCaseLetter",
      "displayName": null,
      "expression": {
        "type": "class",
        "inverted": false,
        "parts": [
          [
            "a",
            "z"
          ]
        ],
        "rawText": "[a-z]"
      }
    },
    "upperCaseLetter": {
      "type": "rule",
      "name": "upperCaseLetter",
      "displayName": null,
      "expression": {
        "type": "class",
        "inverted": false,
        "parts": [
          [
            "A",
            "Z"
          ]
        ],
        "rawText": "[A-Z]"
      }
    },
    "__": {
      "type": "rule",
      "name": "__",
      "displayName": null,
      "expression": {
        "type": "zero_or_more",
        "expression": {
          "type": "choice",
          "alternatives": [
            {
              "type": "rule_ref",
              "name": "whitespace"
            },
            {
              "type": "rule_ref",
              "name": "eol"
            },
            {
              "type": "rule_ref",
              "name": "comment"
            }
          ]
        }
      }
    },
    "comment": {
      "type": "rule",
      "name": "comment",
      "displayName": "comment",
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "rule_ref",
            "name": "singleLineComment"
          },
          {
            "type": "rule_ref",
            "name": "multiLineComment"
          }
        ]
      }
    },
    "singleLineComment": {
      "type": "rule",
      "name": "singleLineComment",
      "displayName": null,
      "expression": {
        "type": "sequence",
        "elements": [
          {
            "type": "literal",
            "value": "//"
          },
          {
            "type": "zero_or_more",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "simple_not",
                  "expression": {
                    "type": "rule_ref",
                    "name": "eolChar"
                  }
                },
                {
                  "type": "any"
                }
              ]
            }
          }
        ]
      }
    },
    "multiLineComment": {
      "type": "rule",
      "name": "multiLineComment",
      "displayName": null,
      "expression": {
        "type": "sequence",
        "elements": [
          {
            "type": "literal",
            "value": "/*"
          },
          {
            "type": "zero_or_more",
            "expression": {
              "type": "sequence",
              "elements": [
                {
                  "type": "simple_not",
                  "expression": {
                    "type": "literal",
                    "value": "*/"
                  }
                },
                {
                  "type": "any"
                }
              ]
            }
          },
          {
            "type": "literal",
            "value": "*/"
          }
        ]
      }
    },
    "eol": {
      "type": "rule",
      "name": "eol",
      "displayName": "end of line",
      "expression": {
        "type": "choice",
        "alternatives": [
          {
            "type": "literal",
            "value": "\n"
          },
          {
            "type": "literal",
            "value": "\r\n"
          },
          {
            "type": "literal",
            "value": "\r"
          },
          {
            "type": "literal",
            "value": "\u2028"
          },
          {
            "type": "literal",
            "value": "\u2029"
          }
        ]
      }
    },
    "eolChar": {
      "type": "rule",
      "name": "eolChar",
      "displayName": null,
      "expression": {
        "type": "class",
        "inverted": false,
        "parts": [
          "\n",
          "\r",
          "\u2028",
          "\u2029"
        ],
        "rawText": "[\\n\\r\\u2028\\u2029]"
      }
    },
    "whitespace": {
      "type": "rule",
      "name": "whitespace",
      "displayName": "whitespace",
      "expression": {
        "type": "class",
        "inverted": false,
        "parts": [
          " ",
          "\t",
          "\u000b",
          "\f",
          "\u00A0",
          "\uFEFF",
          "\u1680",
          "\u180E",
          [
            "\u2000",
            "\u200A"
          ],
          "\u202F",
          "\u205F",
          "\u3000"
        ],
        "rawText": "[ \t\u000b\f\\xA0\\uFEFF\\u1680\\u180E\\u2000-\\u200A\\u202F\\u205F\\u3000]"
      }
    }
  },
  "startRule": "grammar"
});

if (typeof module === "object") {
  module.exports = PEG;
} else if (typeof window === "object") {
  window.PEG = PEG;
} else {
  throw new Error("Can't export PEG library (no \"module\" nor \"window\" object detected).");
}

})();
