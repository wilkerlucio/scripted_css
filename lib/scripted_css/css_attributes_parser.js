/* Jison generated parser */
ScriptedCss.AttributesParser = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"Root":3,"e":4,"||":5,"andOr":6,"|":7,"Value":8,"ValueItem":9,"Length":10,"[":11,"]":12,"DEFINITION":13,"IDENTIFIER":14,"NUMBER":15,"*":16,"+":17,"?":18,"{":19,"}":20,",":21,"$accept":0,"$end":1},
terminals_: {2:"error",5:"||",7:"|",11:"[",12:"]",13:"DEFINITION",14:"IDENTIFIER",15:"NUMBER",16:"*",17:"+",18:"?",19:"{",20:"}",21:","},
productions_: [0,[3,1],[4,3],[4,1],[6,3],[6,2],[6,1],[8,1],[8,2],[8,3],[8,4],[9,1],[9,1],[9,1],[10,1],[10,1],[10,1],[10,3],[10,5]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
case 1:return this.$
break;
case 2:this.$ = new yy.Optional($$[$0-2], $$[$0]);
break;
case 3:this.$ = $$[$0];
break;
case 4:this.$ = new yy.Or($$[$0-2], $$[$0]);
break;
case 5:this.$ = new yy.And($$[$0-1], $$[$0]);
break;
case 6:this.$ = $$[$0];
break;
case 7:this.$ = new yy.Value($$[$0]);
break;
case 8:this.$ = new yy.Value($$[$0-1], $$[$0]);
break;
case 9:this.$ = new yy.Value($$[$0-1]);
break;
case 10:this.$ = new yy.Value($$[$0-2], $$[$0]);
break;
case 11:this.$ = new yy.Macro($$[$0]);
break;
case 12:this.$ = new yy.Literal($$[$0]);
break;
case 13:this.$ = new yy.Literal($$[$0]);
break;
case 14:this.$ = new yy.Quantity(0, -1);
break;
case 15:this.$ = new yy.Quantity(1, -1);
break;
case 16:this.$ = new yy.Quantity(0, 1);
break;
case 17:this.$ = new yy.Quantity(parseInt($$[$0-1]));
break;
case 18:this.$ = new yy.Quantity(parseInt($$[$0-3]), parseInt($$[$0-1]));
break;
}
},
table: [{3:1,4:2,6:3,8:4,9:5,11:[1,6],13:[1,7],14:[1,8],15:[1,9]},{1:[3]},{1:[2,1],5:[1,10]},{1:[2,3],5:[2,3],7:[1,11],8:12,9:5,11:[1,6],12:[2,3],13:[1,7],14:[1,8],15:[1,9]},{1:[2,6],5:[2,6],7:[2,6],11:[2,6],12:[2,6],13:[2,6],14:[2,6],15:[2,6]},{1:[2,7],5:[2,7],7:[2,7],10:13,11:[2,7],12:[2,7],13:[2,7],14:[2,7],15:[2,7],16:[1,14],17:[1,15],18:[1,16],19:[1,17]},{4:18,6:3,8:4,9:5,11:[1,6],13:[1,7],14:[1,8],15:[1,9]},{1:[2,11],5:[2,11],7:[2,11],11:[2,11],12:[2,11],13:[2,11],14:[2,11],15:[2,11],16:[2,11],17:[2,11],18:[2,11],19:[2,11]},{1:[2,12],5:[2,12],7:[2,12],11:[2,12],12:[2,12],13:[2,12],14:[2,12],15:[2,12],16:[2,12],17:[2,12],18:[2,12],19:[2,12]},{1:[2,13],5:[2,13],7:[2,13],11:[2,13],12:[2,13],13:[2,13],14:[2,13],15:[2,13],16:[2,13],17:[2,13],18:[2,13],19:[2,13]},{6:19,8:4,9:5,11:[1,6],13:[1,7],14:[1,8],15:[1,9]},{8:20,9:5,11:[1,6],13:[1,7],14:[1,8],15:[1,9]},{1:[2,5],5:[2,5],7:[2,5],11:[2,5],12:[2,5],13:[2,5],14:[2,5],15:[2,5]},{1:[2,8],5:[2,8],7:[2,8],11:[2,8],12:[2,8],13:[2,8],14:[2,8],15:[2,8]},{1:[2,14],5:[2,14],7:[2,14],11:[2,14],12:[2,14],13:[2,14],14:[2,14],15:[2,14]},{1:[2,15],5:[2,15],7:[2,15],11:[2,15],12:[2,15],13:[2,15],14:[2,15],15:[2,15]},{1:[2,16],5:[2,16],7:[2,16],11:[2,16],12:[2,16],13:[2,16],14:[2,16],15:[2,16]},{15:[1,21]},{5:[1,10],12:[1,22]},{1:[2,2],5:[2,2],7:[1,11],8:12,9:5,11:[1,6],12:[2,2],13:[1,7],14:[1,8],15:[1,9]},{1:[2,4],5:[2,4],7:[2,4],11:[2,4],12:[2,4],13:[2,4],14:[2,4],15:[2,4]},{20:[1,23],21:[1,24]},{1:[2,9],5:[2,9],7:[2,9],10:25,11:[2,9],12:[2,9],13:[2,9],14:[2,9],15:[2,9],16:[1,14],17:[1,15],18:[1,16],19:[1,17]},{1:[2,17],5:[2,17],7:[2,17],11:[2,17],12:[2,17],13:[2,17],14:[2,17],15:[2,17]},{15:[1,26]},{1:[2,10],5:[2,10],7:[2,10],11:[2,10],12:[2,10],13:[2,10],14:[2,10],15:[2,10]},{20:[1,27]},{1:[2,18],5:[2,18],7:[2,18],11:[2,18],12:[2,18],13:[2,18],14:[2,18],15:[2,18]}],
defaultActions: {},
parseError: function parseError(str, hash) {
    throw new Error(str);
},
parse: function parse(input) {
    var self = this,
        stack = [0],
        vstack = [null], // semantic value stack
        lstack = [], // location stack
        table = this.table,
        yytext = '',
        yylineno = 0,
        yyleng = 0,
        recovering = 0,
        TERROR = 2,
        EOF = 1;

    //this.reductionCount = this.shiftCount = 0;

    this.lexer.setInput(input);
    this.lexer.yy = this.yy;
    this.yy.lexer = this.lexer;
    var yyloc = this.lexer.yylloc;
    lstack.push(yyloc);

    if (typeof this.yy.parseError === 'function')
        this.parseError = this.yy.parseError;

    function popStack (n) {
        stack.length = stack.length - 2*n;
        vstack.length = vstack.length - n;
        lstack.length = lstack.length - n;
    }

    function lex() {
        var token;
        token = self.lexer.lex() || 1; // $end = 1
        // if token isn't its numeric value, convert
        if (typeof token !== 'number') {
            token = self.symbols_[token] || token;
        }
        return token;
    };

    var symbol, preErrorSymbol, state, action, a, r, yyval={},p,len,newState, expected;
    while (true) {
        // retreive state number from top of stack
        state = stack[stack.length-1];

        // use default actions if available
        if (this.defaultActions[state]) {
            action = this.defaultActions[state];
        } else {
            if (symbol == null)
                symbol = lex();
            // read action for current state and first input
            action = table[state] && table[state][symbol];
        }

        // handle parse error
        if (typeof action === 'undefined' || !action.length || !action[0]) {

            if (!recovering) {
                // Report error
                expected = [];
                for (p in table[state]) if (this.terminals_[p] && p > 2) {
                    expected.push("'"+this.terminals_[p]+"'");
                }
                var errStr = '';
                if (this.lexer.showPosition) {
                    errStr = 'Parse error on line '+(yylineno+1)+":\n"+this.lexer.showPosition()+'\nExpecting '+expected.join(', ');
                } else {
                    errStr = 'Parse error on line '+(yylineno+1)+": Unexpected " +
                                  (symbol == 1 /*EOF*/ ? "end of input" :
                                              ("'"+(this.terminals_[symbol] || symbol)+"'"));
                }
                this.parseError(errStr,
                    {text: this.lexer.match, token: this.terminals_[symbol] || symbol, line: this.lexer.yylineno, loc: yyloc, expected: expected});
            }

            // just recovered from another error
            if (recovering == 3) {
                if (symbol == EOF) {
                    throw new Error(errStr || 'Parsing halted.');
                }

                // discard current lookahead and grab another
                yyleng = this.lexer.yyleng;
                yytext = this.lexer.yytext;
                yylineno = this.lexer.yylineno;
                yyloc = this.lexer.yylloc;
                symbol = lex();
            }

            // try to recover from error
            while (1) {
                // check for error recovery rule in this state
                if ((TERROR.toString()) in table[state]) {
                    break;
                }
                if (state == 0) {
                    throw new Error(errStr || 'Parsing halted.');
                }
                popStack(1);
                state = stack[stack.length-1];
            }
            
            preErrorSymbol = symbol; // save the lookahead token
            symbol = TERROR;         // insert generic error symbol as new lookahead
            state = stack[stack.length-1];
            action = table[state] && table[state][TERROR];
            recovering = 3; // allow 3 real symbols to be shifted before reporting a new error
        }

        // this shouldn't happen, unless resolve defaults are off
        if (action[0] instanceof Array && action.length > 1) {
            throw new Error('Parse Error: multiple actions possible at state: '+state+', token: '+symbol);
        }

        switch (action[0]) {

            case 1: // shift
                //this.shiftCount++;

                stack.push(symbol);
                vstack.push(this.lexer.yytext);
                lstack.push(this.lexer.yylloc);
                stack.push(action[1]); // push state
                symbol = null;
                if (!preErrorSymbol) { // normal execution/no error
                    yyleng = this.lexer.yyleng;
                    yytext = this.lexer.yytext;
                    yylineno = this.lexer.yylineno;
                    yyloc = this.lexer.yylloc;
                    if (recovering > 0)
                        recovering--;
                } else { // error just occurred, resume old lookahead f/ before error
                    symbol = preErrorSymbol;
                    preErrorSymbol = null;
                }
                break;

            case 2: // reduce
                //this.reductionCount++;

                len = this.productions_[action[1]][1];

                // perform semantic action
                yyval.$ = vstack[vstack.length-len]; // default to $$ = $1
                // default location, uses first token for firsts, last for lasts
                yyval._$ = {
                    first_line: lstack[lstack.length-(len||1)].first_line,
                    last_line: lstack[lstack.length-1].last_line,
                    first_column: lstack[lstack.length-(len||1)].first_column,
                    last_column: lstack[lstack.length-1].last_column
                };
                r = this.performAction.call(yyval, yytext, yyleng, yylineno, this.yy, action[1], vstack, lstack);

                if (typeof r !== 'undefined') {
                    return r;
                }

                // pop off stack
                if (len) {
                    stack = stack.slice(0,-1*len*2);
                    vstack = vstack.slice(0, -1*len);
                    lstack = lstack.slice(0, -1*len);
                }

                stack.push(this.productions_[action[1]][0]);    // push nonterminal (reduce)
                vstack.push(yyval.$);
                lstack.push(yyval._$);
                // goto new state = table[STATE][NONTERMINAL]
                newState = table[stack[stack.length-2]][stack[stack.length-1]];
                stack.push(newState);
                break;

            case 3: // accept
                return true;
        }

    }

    return true;
}};/* Jison generated lexer */
var lexer = (function(){var lexer = ({EOF:1,
parseError:function parseError(str, hash) {
        if (this.yy.parseError) {
            this.yy.parseError(str, hash);
        } else {
            throw new Error(str);
        }
    },
setInput:function (input) {
        this._input = input;
        this._more = this._less = this.done = false;
        this.yylineno = this.yyleng = 0;
        this.yytext = this.matched = this.match = '';
        this.conditionStack = ['INITIAL'];
        this.yylloc = {first_line:1,first_column:0,last_line:1,last_column:0};
        return this;
    },
input:function () {
        var ch = this._input[0];
        this.yytext+=ch;
        this.yyleng++;
        this.match+=ch;
        this.matched+=ch;
        var lines = ch.match(/\n/);
        if (lines) this.yylineno++;
        this._input = this._input.slice(1);
        return ch;
    },
unput:function (ch) {
        this._input = ch + this._input;
        return this;
    },
more:function () {
        this._more = true;
        return this;
    },
pastInput:function () {
        var past = this.matched.substr(0, this.matched.length - this.match.length);
        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\n/g, "");
    },
upcomingInput:function () {
        var next = this.match;
        if (next.length < 20) {
            next += this._input.substr(0, 20-next.length);
        }
        return (next.substr(0,20)+(next.length > 20 ? '...':'')).replace(/\n/g, "");
    },
showPosition:function () {
        var pre = this.pastInput();
        var c = new Array(pre.length + 1).join("-");
        return pre + this.upcomingInput() + "\n" + c+"^";
    },
next:function () {
        if (this.done) {
            return this.EOF;
        }
        if (!this._input) this.done = true;

        var token,
            match,
            col,
            lines;
        if (!this._more) {
            this.yytext = '';
            this.match = '';
        }
        var rules = this._currentRules();
        for (var i=0;i < rules.length; i++) {
            match = this._input.match(this.rules[rules[i]]);
            if (match) {
                lines = match[0].match(/\n.*/g);
                if (lines) this.yylineno += lines.length;
                this.yylloc = {first_line: this.yylloc.last_line,
                               last_line: this.yylineno+1,
                               first_column: this.yylloc.last_column,
                               last_column: lines ? lines[lines.length-1].length-1 : this.yylloc.last_column + match.length}
                this.yytext += match[0];
                this.match += match[0];
                this.matches = match;
                this.yyleng = this.yytext.length;
                this._more = false;
                this._input = this._input.slice(match[0].length);
                this.matched += match[0];
                token = this.performAction.call(this, this.yy, this, rules[i],this.conditionStack[this.conditionStack.length-1]);
                if (token) return token;
                else return;
            }
        }
        if (this._input === "") {
            return this.EOF;
        } else {
            this.parseError('Lexical error on line '+(this.yylineno+1)+'. Unrecognized text.\n'+this.showPosition(), 
                    {text: "", token: null, line: this.yylineno});
        }
    },
lex:function lex() {
        var r = this.next();
        if (typeof r !== 'undefined') {
            return r;
        } else {
            return this.lex();
        }
    },
begin:function begin(condition) {
        this.conditionStack.push(condition);
    },
popState:function popState() {
        return this.conditionStack.pop();
    },
_currentRules:function _currentRules() {
        return this.conditions[this.conditionStack[this.conditionStack.length-1]].rules;
    }});
lexer.performAction = function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {

var YYSTATE=YY_START
switch($avoiding_name_collisions) {
case 0:/* skip whitespaces */
break;
case 1:yy_.yytext = yy_.yytext.substring(1, yy_.yytext.length - 1); return 13
break;
case 2:return 14
break;
case 3:yy_.yytext = yy_.yytext.substring(1, yy_.yytext.length - 1); return 14
break;
case 4:return 15
break;
case 5:return 5;
break;
case 6:return 7;
break;
case 7:return 11;
break;
case 8:return 12;
break;
case 9:return 19;
break;
case 10:return 20;
break;
case 11:return 16;
break;
case 12:return 18;
break;
case 13:return 17;
break;
case 14:return 14;
break;
}
};
lexer.rules = [/^\s+/,/^<[a-zA-Z-][a-zA-Z0-9-]*>/,/^[a-zA-Z-][a-zA-Z0-9-]*/,/^'[^']*'/,/^\d+/,/^\|\|/,/^\|/,/^\[/,/^\]/,/^\{/,/^\}/,/^\*/,/^\?/,/^\+/,/^./];
lexer.conditions = {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14],"inclusive":true}};return lexer;})()
parser.lexer = lexer;
return parser;
})();
if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = ScriptedCss.AttributesParser;
exports.parse = function () { return ScriptedCss.AttributesParser.parse.apply(ScriptedCss.AttributesParser, arguments); }
exports.main = function commonjsMain(args) {
    if (!args[1])
        throw new Error('Usage: '+args[0]+' FILE');
    if (typeof process !== 'undefined') {
        var source = require('fs').readFileSync(require('path').join(process.cwd(), args[1]), "utf8");
    } else {
        var cwd = require("file").path(require("file").cwd());
        var source = cwd.join(args[1]).read({charset: "utf-8"});
    }
    return exports.parser.parse(source);
}
if (typeof module !== 'undefined' && require.main === module) {
  exports.main(typeof process !== 'undefined' ? process.argv.slice(1) : require("system").args);
}
}(function() {
  var And, Literal, Macro, NodeValues, Null, Optional, Or, Quantity, Value, f, normalizeOutput;
  f = function(v1, v2) {
    if (_.isArray(v1) && _.isArray(v2)) {
      return v1.concat(v2);
    }
    if (_.isArray(v1) && !(_.isArray(v2))) {
      v1.push(v2);
      return v1;
    }
    if (!(_.isArray(v1)) && _.isArray(v2)) {
      v2.unshift(v1);
      return v2;
    }
    if (!(_.isArray(v1)) && !(_.isArray(v2))) {
      return [v1, v2];
    }
  };
  window.ScriptedCss.AttributesParser.yy = {
    Optional: Optional = (function() {
      function Optional(v1, v2) {
        this.v1 = v1;
        this.v2 = v2;
        this.type = "OPTIONAL";
      }
      Optional.prototype.parse = function(nodes, grammar) {
        var r1, r2;
        r1 = this.v1.parse(nodes, grammar);
        r2 = this.v2.parse(nodes, grammar);
        return f(r1 || new Null, r2 || new Null);
      };
      return Optional;
    })(),
    Or: Or = (function() {
      function Or(v1, v2) {
        this.v1 = v1;
        this.v2 = v2;
        this.type = "OR";
      }
      Or.prototype.parse = function(nodes, grammar) {
        var nodesClone, v;
        nodesClone = _.clone(nodes);
        v = this.v1.parse(nodes, grammar);
        if (this.isValid(v)) {
          return v;
        }
        v = this.v2.parse(nodesClone, grammar);
        if (this.isValid(v)) {
          return v;
        }
        return false;
      };
      Or.prototype.isValid = function(result) {
        if (!_.isArray(result)) {
          return result;
        }
        return _.any(result, function(node) {
          return !node.type || node.type !== "NULL";
        });
      };
      return Or;
    })(),
    And: And = (function() {
      function And(v1, v2) {
        this.v1 = v1;
        this.v2 = v2;
        this.type = "AND";
      }
      And.prototype.parse = function(nodes, grammar) {
        var r1, r2;
        r1 = this.v1.parse(nodes, grammar);
        r2 = this.v2.parse(nodes, grammar);
        if (r1 && r2) {
          return f(r1, r2);
        } else {
          return false;
        }
      };
      return And;
    })(),
    Value: Value = (function() {
      function Value(value, quantity) {
        this.value = value;
        this.quantity = quantity != null ? quantity : new Quantity(1);
        this.type = "VALUE";
      }
      Value.prototype.parse = function(nodes, grammar) {
        return this.quantity.parse(this.value, nodes, grammar);
      };
      return Value;
    })(),
    Macro: Macro = (function() {
      function Macro(value) {
        this.value = value;
        this.type = "MACRO";
      }
      Macro.prototype.parse = function(nodes, grammar) {
        return ScriptedCss.AttributesParser.parseNodesInternal(nodes, this.value, grammar);
      };
      return Macro;
    })(),
    Literal: Literal = (function() {
      function Literal(value) {
        this.value = value;
        this.type = "LITERAL";
      }
      Literal.prototype.parse = function(nodes, grammar) {
        var value;
        value = this.value;
        return ScriptedCss.AttributesParser.helpers.collect(nodes, function(node) {
          return node.string() === value;
        });
      };
      return Literal;
    })(),
    Null: Null = (function() {
      function Null() {
        this.type = "NULL";
      }
      Null.prototype.parse = function() {
        return this;
      };
      return Null;
    })(),
    Quantity: Quantity = (function() {
      function Quantity(min, max) {
        this.min = min;
        this.max = max != null ? max : this.min;
      }
      Quantity.prototype.parse = function(value, nodes, grammar) {
        var r, result, results;
        if (this.max === 1) {
          result = value.parse(nodes, grammar);
          if (result) {
            return result;
          } else {
            if (this.min === 1) {
              return false;
            } else {
              return new Null;
            }
          }
        } else {
          results = [];
          while (r = value.parse(nodes, grammar)) {
            results.push(r);
            if (!(this.max === -1 || results.length < this.max)) {
              break;
            }
          }
          if (results.length < this.min) {
            return false;
          }
          return [results];
        }
      };
      return Quantity;
    })(),
    NodeValues: NodeValues = (function() {
      function NodeValues(items) {
        this.items = items;
        this.type = "NODEVALUES";
      }
      return NodeValues;
    })()
  };
  normalizeOutput = function(value, ignores) {
    var item, list, _i, _len;
    if (_.isArray(value)) {
      list = [];
      for (_i = 0, _len = value.length; _i < _len; _i++) {
        item = value[_i];
        if (_.isFunction(item.string) && _.include(ignores, item.string())) {
          continue;
        }
        list.push(normalizeOutput(item, ignores));
      }
      return list;
    } else {
      if (value.type === "NULL") {
        return null;
      } else {
        return value;
      }
    }
  };
  window.ScriptedCss.AttributesParser.helpers = {
    collect: function(nodes, callback) {
      var node, rest, result, _i, _len, _ref;
      rest = [];
      result = false;
      _ref = nodes.items;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        node = _ref[_i];
        if (result === false && callback(node)) {
          result = node;
        } else {
          rest.push(node);
        }
      }
      nodes.items = rest;
      return result;
    },
    collectMany: function(nodes, callback) {
      var node, rest, results, _i, _len, _ref;
      rest = [];
      results = [];
      _ref = nodes.items;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        node = _ref[_i];
        if (callback(node)) {
          results.push(node);
        } else {
          rest.push(node);
        }
      }
      nodes.items = rest;
      return result;
    }
  };
  window.ScriptedCss.AttributesParser.parseNodesInternal = function(nodes, ruleName, grammar) {
    var result, returnFunction, rule;
    rule = grammar[ruleName];
    if (!rule) {
      throw "can't find rule <" + ruleName + ">";
    }
    if (nodes.type !== "NODEVALUES") {
      nodes = new ScriptedCss.AttributesParser.yy.NodeValues(nodes);
    }
    returnFunction = rule["return"] || (function(v) {
      return v;
    });
    if (rule.value == null) {
      rule = {
        value: rule
      };
    }
    if (_.isFunction(rule.value)) {
      result = rule.value.call(ScriptedCss.AttributesParser.helpers, nodes, grammar);
    } else {
      if (!rule.parser) {
        rule.parser = ScriptedCss.AttributesParser.parse(rule.value);
      }
      result = rule.parser.parse(nodes, grammar);
    }
    if (result) {
      return returnFunction(result);
    } else {
      return false;
    }
  };
  window.ScriptedCss.AttributesParser.parseNodes = function(nodes, rule, grammar) {
    return normalizeOutput(ScriptedCss.AttributesParser.parseNodesInternal(nodes, rule, grammar), grammar._ignoreList || []);
  };
}).call(this);
