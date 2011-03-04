/* Jison generated parser */
ScriptedCss.CssParser = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"Root":3,"Rules":4,"Rule":5,"Selectors":6,"{":7,"Attributes":8,"}":9,"@":10,"IDENTIFIER":11,"Value":12,"Selector":13,"SELECTOR_OPERATOR":14,",":15,"[":16,"AttributeSelector":17,"]":18,"MetaSelector":19,"AttributeSelectorOperator":20,"=":21,"~=":22,"|=":23,"^=":24,"$=":25,"*=":26,"MetaSelectorOperator":27,"MetaSelectorItem":28,"Function":29,":":30,"::":31,"Attribute":32,";":33,"ValueList":34,"ValueListItem":35,"STRING":36,"HEXNUMBER":37,"PERCENT":38,"UNITNUMBER":39,"NUMBER":40,"/":41,"*":42,"IMPORTANT":43,"(":44,"ArgList":45,")":46,"ArgListValue":47,"MultiArg":48,"$accept":0,"$end":1},
terminals_: {2:"error",7:"{",9:"}",10:"@",11:"IDENTIFIER",14:"SELECTOR_OPERATOR",15:",",16:"[",18:"]",21:"=",22:"~=",23:"|=",24:"^=",25:"$=",26:"*=",30:":",31:"::",33:";",36:"STRING",37:"HEXNUMBER",38:"PERCENT",39:"UNITNUMBER",40:"NUMBER",41:"/",42:"*",43:"IMPORTANT",44:"(",46:")"},
productions_: [0,[3,0],[3,1],[4,1],[4,2],[5,4],[5,3],[5,5],[6,1],[6,3],[6,3],[13,1],[13,4],[13,5],[13,2],[13,1],[17,3],[20,1],[20,1],[20,1],[20,1],[20,1],[20,1],[19,2],[28,1],[28,1],[27,1],[27,1],[8,0],[8,1],[8,3],[8,2],[32,3],[34,1],[34,2],[35,1],[35,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[29,4],[45,0],[45,1],[45,3],[47,1],[47,3],[47,1],[48,2],[48,2]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
case 1:this.$ = new yy.RulesNode([]); return this.$
break;
case 2:this.$ = new yy.RulesNode($$[$0]); return this.$
break;
case 3:this.$ = $$[$0];
break;
case 4:this.$ = $$[$0-1].concat($$[$0]);
break;
case 5:this.$ = (function () {
        var selector, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = $$[$0-3].length; _i < _len; _i++) {
          selector = $$[$0-3][_i];
          _results.push(new yy.RuleNode(selector, $$[$0-1]));
        }
        return _results;
      }());
break;
case 6:this.$ = [new yy.MetaNode($$[$0-1], $$[$0])];
break;
case 7:this.$ = [new yy.MetaNode($$[$0-3], $$[$0-1])];
break;
case 8:this.$ = [$$[$0]];
break;
case 9:this.$ = (function () {
        $$[$0-2][$$[$0-2].length - 1].nestSelector($$[$0], $$[$0-1]);
        return $$[$0-2];
      }());
break;
case 10:this.$ = $$[$0-2].concat($$[$0]);
break;
case 11:this.$ = new yy.SelectorNode($$[$0]);
break;
case 12:this.$ = new yy.SelectorNode($$[$0-3], $$[$0-1]);
break;
case 13:this.$ = new yy.SelectorNode($$[$0-4], $$[$0-2], $$[$0]);
break;
case 14:this.$ = new yy.SelectorNode($$[$0-1], null, $$[$0]);
break;
case 15:this.$ = new yy.SelectorNode("*", null, $$[$0]);
break;
case 16:this.$ = new yy.AttributeSelectorNode($$[$0-2], $$[$0-1], $$[$0]);
break;
case 17:this.$ = $$[$0];
break;
case 18:this.$ = $$[$0];
break;
case 19:this.$ = $$[$0];
break;
case 20:this.$ = $$[$0];
break;
case 21:this.$ = $$[$0];
break;
case 22:this.$ = $$[$0];
break;
case 23:this.$ = new yy.MetaSelectorNode($$[$0], $$[$0-1]);
break;
case 24:this.$ = new yy.LiteralNode($$[$0]);
break;
case 25:this.$ = $$[$0];
break;
case 26:this.$ = $$[$0];
break;
case 27:this.$ = $$[$0];
break;
case 28:this.$ = [];
break;
case 29:this.$ = [$$[$0]];
break;
case 30:this.$ = $$[$0-2].concat($$[$0]);
break;
case 31:this.$ = $$[$0-1];
break;
case 32:this.$ = new yy.AttributeNode($$[$0-2], $$[$0]);
break;
case 33:this.$ = [$$[$0]];
break;
case 34:this.$ = $$[$0-1].concat($$[$0]);
break;
case 35:this.$ = $$[$0];
break;
case 36:this.$ = new yy.LiteralNode($$[$0]);
break;
case 37:this.$ = new yy.LiteralNode($$[$0]);
break;
case 38:this.$ = new yy.StringNode($$[$0]);
break;
case 39:this.$ = new yy.HexnumberNode($$[$0]);
break;
case 40:this.$ = new yy.PercentNode($$[$0]);
break;
case 41:this.$ = new yy.UnitNumberNode($$[$0]);
break;
case 42:this.$ = new yy.NumberNode($$[$0]);
break;
case 43:this.$ = new yy.LiteralNode($$[$0]);
break;
case 44:this.$ = new yy.LiteralNode($$[$0]);
break;
case 45:this.$ = new yy.ImportantNode();
break;
case 46:this.$ = $$[$0];
break;
case 47:this.$ = new yy.FunctionNode($$[$0-3], $$[$0-1]);
break;
case 48:this.$ = [];
break;
case 49:this.$ = [$$[$0]];
break;
case 50:this.$ = $$[$0-2].concat($$[$0]);
break;
case 51:this.$ = $$[$0];
break;
case 52:this.$ = new yy.NamedArgumentNode($$[$0-2], $$[$0]);
break;
case 53:this.$ = new yy.MultiValue($$[$0], " ");
break;
case 54:this.$ = [$$[$0-1], $$[$0]];
break;
case 55:this.$ = $$[$0-1].concat($$[$0]);
break;
}
},
table: [{1:[2,1],3:1,4:2,5:3,6:4,10:[1,5],11:[1,7],13:6,19:8,27:9,30:[1,10],31:[1,11]},{1:[3]},{1:[2,2],5:12,6:4,10:[1,5],11:[1,7],13:6,19:8,27:9,30:[1,10],31:[1,11]},{1:[2,3],10:[2,3],11:[2,3],30:[2,3],31:[2,3]},{7:[1,13],14:[1,14],15:[1,15]},{11:[1,16]},{7:[2,8],14:[2,8],15:[2,8]},{7:[2,11],14:[2,11],15:[2,11],16:[1,17],19:18,27:9,30:[1,10],31:[1,11]},{7:[2,15],14:[2,15],15:[2,15]},{11:[1,20],28:19,29:21},{11:[2,26]},{11:[2,27]},{1:[2,4],10:[2,4],11:[2,4],30:[2,4],31:[2,4]},{8:22,9:[2,28],11:[1,24],32:23,33:[2,28]},{11:[1,7],13:25,19:8,27:9,30:[1,10],31:[1,11]},{11:[1,7],13:26,19:8,27:9,30:[1,10],31:[1,11]},{7:[1,28],11:[1,29],12:27,29:38,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37]},{11:[1,40],17:39},{7:[2,14],14:[2,14],15:[2,14]},{7:[2,23],14:[2,23],15:[2,23]},{7:[2,24],14:[2,24],15:[2,24],44:[1,41]},{7:[2,25],14:[2,25],15:[2,25]},{9:[1,42],33:[1,43]},{9:[2,29],33:[2,29]},{30:[1,44]},{7:[2,9],14:[2,9],15:[2,9]},{7:[2,10],14:[2,10],15:[2,10]},{1:[2,6],10:[2,6],11:[2,6],30:[2,6],31:[2,6]},{8:45,9:[2,28],11:[1,24],32:23,33:[2,28]},{1:[2,37],9:[2,37],10:[2,37],11:[2,37],15:[2,37],18:[2,37],30:[2,37],31:[2,37],33:[2,37],36:[2,37],37:[2,37],38:[2,37],39:[2,37],40:[2,37],41:[2,37],42:[2,37],43:[2,37],44:[1,41],46:[2,37]},{1:[2,38],9:[2,38],10:[2,38],11:[2,38],15:[2,38],18:[2,38],30:[2,38],31:[2,38],33:[2,38],36:[2,38],37:[2,38],38:[2,38],39:[2,38],40:[2,38],41:[2,38],42:[2,38],43:[2,38],46:[2,38]},{1:[2,39],9:[2,39],10:[2,39],11:[2,39],15:[2,39],18:[2,39],30:[2,39],31:[2,39],33:[2,39],36:[2,39],37:[2,39],38:[2,39],39:[2,39],40:[2,39],41:[2,39],42:[2,39],43:[2,39],46:[2,39]},{1:[2,40],9:[2,40],10:[2,40],11:[2,40],15:[2,40],18:[2,40],30:[2,40],31:[2,40],33:[2,40],36:[2,40],37:[2,40],38:[2,40],39:[2,40],40:[2,40],41:[2,40],42:[2,40],43:[2,40],46:[2,40]},{1:[2,41],9:[2,41],10:[2,41],11:[2,41],15:[2,41],18:[2,41],30:[2,41],31:[2,41],33:[2,41],36:[2,41],37:[2,41],38:[2,41],39:[2,41],40:[2,41],41:[2,41],42:[2,41],43:[2,41],46:[2,41]},{1:[2,42],9:[2,42],10:[2,42],11:[2,42],15:[2,42],18:[2,42],30:[2,42],31:[2,42],33:[2,42],36:[2,42],37:[2,42],38:[2,42],39:[2,42],40:[2,42],41:[2,42],42:[2,42],43:[2,42],46:[2,42]},{1:[2,43],9:[2,43],10:[2,43],11:[2,43],15:[2,43],18:[2,43],30:[2,43],31:[2,43],33:[2,43],36:[2,43],37:[2,43],38:[2,43],39:[2,43],40:[2,43],41:[2,43],42:[2,43],43:[2,43],46:[2,43]},{1:[2,44],9:[2,44],10:[2,44],11:[2,44],15:[2,44],18:[2,44],30:[2,44],31:[2,44],33:[2,44],36:[2,44],37:[2,44],38:[2,44],39:[2,44],40:[2,44],41:[2,44],42:[2,44],43:[2,44],46:[2,44]},{1:[2,45],9:[2,45],10:[2,45],11:[2,45],15:[2,45],18:[2,45],30:[2,45],31:[2,45],33:[2,45],36:[2,45],37:[2,45],38:[2,45],39:[2,45],40:[2,45],41:[2,45],42:[2,45],43:[2,45],46:[2,45]},{1:[2,46],9:[2,46],10:[2,46],11:[2,46],15:[2,46],18:[2,46],30:[2,46],31:[2,46],33:[2,46],36:[2,46],37:[2,46],38:[2,46],39:[2,46],40:[2,46],41:[2,46],42:[2,46],43:[2,46],46:[2,46]},{18:[1,46]},{20:47,21:[1,48],22:[1,49],23:[1,50],24:[1,51],25:[1,52],26:[1,53]},{11:[1,57],12:56,15:[2,48],29:38,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37],45:54,46:[2,48],47:55,48:58},{1:[2,5],10:[2,5],11:[2,5],30:[2,5],31:[2,5]},{9:[2,31],11:[1,24],32:59,33:[2,31]},{11:[1,29],12:62,15:[1,63],29:38,34:60,35:61,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37]},{9:[1,64],33:[1,43]},{7:[2,12],14:[2,12],15:[2,12],19:65,27:9,30:[1,10],31:[1,11]},{11:[1,29],12:66,29:38,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37]},{11:[2,17],36:[2,17],37:[2,17],38:[2,17],39:[2,17],40:[2,17],41:[2,17],42:[2,17],43:[2,17]},{11:[2,18],36:[2,18],37:[2,18],38:[2,18],39:[2,18],40:[2,18],41:[2,18],42:[2,18],43:[2,18]},{11:[2,19],36:[2,19],37:[2,19],38:[2,19],39:[2,19],40:[2,19],41:[2,19],42:[2,19],43:[2,19]},{11:[2,20],36:[2,20],37:[2,20],38:[2,20],39:[2,20],40:[2,20],41:[2,20],42:[2,20],43:[2,20]},{11:[2,21],36:[2,21],37:[2,21],38:[2,21],39:[2,21],40:[2,21],41:[2,21],42:[2,21],43:[2,21]},{11:[2,22],36:[2,22],37:[2,22],38:[2,22],39:[2,22],40:[2,22],41:[2,22],42:[2,22],43:[2,22]},{15:[1,68],46:[1,67]},{15:[2,49],46:[2,49]},{11:[1,29],12:69,15:[2,51],29:38,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37],46:[2,51]},{11:[2,37],15:[2,37],21:[1,70],36:[2,37],37:[2,37],38:[2,37],39:[2,37],40:[2,37],41:[2,37],42:[2,37],43:[2,37],44:[1,41],46:[2,37]},{11:[1,29],12:71,15:[2,53],29:38,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37],46:[2,53]},{9:[2,30],33:[2,30]},{9:[2,32],11:[1,29],12:62,15:[1,63],29:38,33:[2,32],35:72,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37]},{9:[2,33],11:[2,33],15:[2,33],33:[2,33],36:[2,33],37:[2,33],38:[2,33],39:[2,33],40:[2,33],41:[2,33],42:[2,33],43:[2,33]},{9:[2,35],11:[2,35],15:[2,35],33:[2,35],36:[2,35],37:[2,35],38:[2,35],39:[2,35],40:[2,35],41:[2,35],42:[2,35],43:[2,35]},{9:[2,36],11:[2,36],15:[2,36],33:[2,36],36:[2,36],37:[2,36],38:[2,36],39:[2,36],40:[2,36],41:[2,36],42:[2,36],43:[2,36]},{1:[2,7],10:[2,7],11:[2,7],30:[2,7],31:[2,7]},{7:[2,13],14:[2,13],15:[2,13]},{18:[2,16]},{1:[2,47],7:[2,47],9:[2,47],10:[2,47],11:[2,47],14:[2,47],15:[2,47],18:[2,47],30:[2,47],31:[2,47],33:[2,47],36:[2,47],37:[2,47],38:[2,47],39:[2,47],40:[2,47],41:[2,47],42:[2,47],43:[2,47],46:[2,47]},{11:[1,57],12:56,29:38,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37],47:73,48:58},{11:[2,54],15:[2,54],36:[2,54],37:[2,54],38:[2,54],39:[2,54],40:[2,54],41:[2,54],42:[2,54],43:[2,54],46:[2,54]},{11:[1,29],12:74,29:38,36:[1,30],37:[1,31],38:[1,32],39:[1,33],40:[1,34],41:[1,35],42:[1,36],43:[1,37]},{11:[2,55],15:[2,55],36:[2,55],37:[2,55],38:[2,55],39:[2,55],40:[2,55],41:[2,55],42:[2,55],43:[2,55],46:[2,55]},{9:[2,34],11:[2,34],15:[2,34],33:[2,34],36:[2,34],37:[2,34],38:[2,34],39:[2,34],40:[2,34],41:[2,34],42:[2,34],43:[2,34]},{15:[2,50],46:[2,50]},{15:[2,52],46:[2,52]}],
defaultActions: {10:[2,26],11:[2,27],66:[2,16]},
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
}};
return parser;
})();
if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = ScriptedCss.CssParser;
exports.parse = function () { return ScriptedCss.CssParser.parse.apply(ScriptedCss.CssParser, arguments); }
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
  var ATTRID, COMMENT, HEXNUMBER, IDENTIFIER, Lexer, METAID, NEWLINE, NUMBER, OPERATORS, PERCENT, SELECTOR, STRING, UNITNUMBER, WHITESPACE;
  IDENTIFIER = /^[a-zA-Z_-][a-zA-Z0-9_-]*/;
  METAID = /^@([a-zA-Z_-][a-zA-Z0-9_-]*)/;
  SELECTOR = /^([*]|[.#]?[a-zA-Z_-]([a-zA-Z0-9.#_-]*[a-zA-Z0-9_-])?)/;
  ATTRID = /^[*]?[a-zA-Z_-][a-zA-Z0-9_-]*/;
  NEWLINE = /^\n/;
  WHITESPACE = /^[^\n\S]+/;
  NUMBER = /^-?(\d+(\.\d+)?|\.\d+)/;
  UNITNUMBER = /^-?(\d+(\.\d+)?|\.\d+)(in|cm|mm|em|ex|pt|pc|px|ms|s)\b/;
  PERCENT = /^-?(\d+(\.\d+)?|\.\d+)%/;
  HEXNUMBER = /^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})\b/;
  STRING = /^(?:"([^"]*)"|'([^']*)')/;
  COMMENT = /^\/\*(.|\n)*?\*\//;
  OPERATORS = /^(?:::|[~|^$*]=)/;
  Lexer = {
    tokenize: function(code) {
      code = code.replace(/\r\n|\r/g, "\n");
      this.code = code;
      this.line = 0;
      this.tokens = [];
      this.i = 0;
      this.scope = 'INITIAL';
      while (this.chunk = code.slice(this.i)) {
        this.i += this.specialToken() || this.identifierToken() || this.commentToken() || this.whitespaceToken() || this.newlineToken() || this.stringToken() || this.numberToken() || this.literalToken();
      }
      return this.tokens;
    },
    specialToken: function() {
      var id, input, match, operator, space, value;
      if (this.scope === "INITIAL" || this.scope === "SELECTOR") {
        if (match = METAID.exec(this.chunk)) {
          input = match[0], id = match[1];
          this.token("@", "@");
          this.token("IDENTIFIER", id);
          this.scope = "METASELECTOR";
          return input.length;
        }
        if (match = SELECTOR.exec(this.chunk)) {
          input = match[0];
          this.scope = "SELECTOR";
          this.token("IDENTIFIER", input);
          return input.length;
        }
      }
      if (this.scope === "SELECTOR") {
        if (match = /^\[/.exec(this.chunk)) {
          this.token("[", "[");
          this.scope = "SELECTOR_ATTRIBUTE";
          return 1;
        }
        if (match = /^\s*([+>~])\s*/.exec(this.chunk)) {
          input = match[0], operator = match[1];
          this.token("SELECTOR_OPERATOR", operator);
          return input.length;
        }
        if (match = /^(\s+)/.exec(this.chunk)) {
          input = match[0], space = match[1];
          if (!this.chunk.charAt(input.length).match(/^[,{]/)) {
            this.token("SELECTOR_OPERATOR", ' ');
            return space.length;
          }
        }
      }
      if (this.scope === "SELECTOR_ATTRIBUTE") {
        if (match = /^\]/.exec(this.chunk)) {
          this.token("]", "]");
          this.scope = "SELECTOR";
          return 1;
        }
      }
      if (this.scope === "ATTRIBUTE_NAME") {
        if (match = ATTRID.exec(this.chunk)) {
          input = match[0];
          this.token("IDENTIFIER", input);
          return input.length;
        }
      }
      if (this.scope === "ATTRIBUTE_VALUE") {
        if (match = /^url\s*\(\s*([^'"].+?)\s*\)/.exec(this.chunk)) {
          input = match[0], value = match[1];
          this.token("IDENTIFIER", "url");
          this.token("(", "(");
          this.token("STRING", "'" + value + "'");
          this.token(")", ")");
          return input.length;
        }
        if (match = /^[!]important\b/.exec(this.chunk)) {
          input = match[0];
          this.token("IMPORTANT", input);
          return input.length;
        }
        if (match = /^[a-zA-Z_-]([a-zA-Z0-9:._-]*[a-zA-Z0-9])?/.exec(this.chunk)) {
          input = match[0];
          this.token("IDENTIFIER", input);
          return input.length;
        }
      }
      return 0;
    },
    identifierToken: function() {
      var input, match;
      if (!(match = IDENTIFIER.exec(this.chunk))) {
        return 0;
      }
      input = match[0];
      this.token("IDENTIFIER", input);
      return input.length;
    },
    commentToken: function() {
      var input, lines, match;
      if (!(match = COMMENT.exec(this.chunk))) {
        return 0;
      }
      input = match[0];
      lines = input.split("\n");
      this.line += lines.length - 1;
      return input.length;
    },
    whitespaceToken: function() {
      var input, match;
      if (!(match = WHITESPACE.exec(this.chunk))) {
        return 0;
      }
      input = match[0];
      return input.length;
    },
    newlineToken: function() {
      var input, match;
      if (!(match = NEWLINE.exec(this.chunk))) {
        return 0;
      }
      input = match[0];
      this.line += 1;
      return input.length;
    },
    stringToken: function() {
      var input, match, string;
      if (!(match = STRING.exec(this.chunk))) {
        return 0;
      }
      input = match[0];
      string = input;
      this.token("STRING", string);
      return input.length;
    },
    numberToken: function() {
      var input, match;
      input = null;
      if (match = HEXNUMBER.exec(this.chunk)) {
        input = match[0];
        this.token("HEXNUMBER", input);
      } else if (match = UNITNUMBER.exec(this.chunk)) {
        input = match[0];
        this.token("UNITNUMBER", input);
      } else if (match = PERCENT.exec(this.chunk)) {
        input = match[0];
        this.token("PERCENT", input);
      } else if (match = NUMBER.exec(this.chunk)) {
        input = match[0];
        this.token("NUMBER", input);
      }
      if (input) {
        return input.length;
      } else {
        return 0;
      }
    },
    literalToken: function() {
      var match, value;
      if (match = OPERATORS.exec(this.chunk)) {
        value = match[0];
      } else {
        value = this.chunk.charAt(0);
      }
      this.token(value, value);
      if (this.scope === "SELECTOR" && value === ",") {
        this.scope = "INITIAL";
      }
      if (this.scope === "ATTRIBUTE_NAME" && value === ":") {
        this.scope = "ATTRIBUTE_VALUE";
      }
      if (this.scope === "ATTRIBUTE_VALUE" && value === ";") {
        this.scope = "ATTRIBUTE_NAME";
      }
      if (value === "{") {
        this.scope = "ATTRIBUTE_NAME";
      }
      if (value === "}") {
        this.scope = "INITIAL";
      }
      return value.length;
    },
    token: function(tag, value) {
      return this.tokens.push([tag, value, this.line]);
    }
  };
  Lexer.integrator = {
    lex: function() {
      var tag, _ref;
      _ref = this.tokens[this.pos++] || [''], tag = _ref[0], this.yytext = _ref[1], this.yylineno = _ref[2];
      this.yylloc = {
        first_line: this.yylineno,
        last_line: this.yylineno + 1
      };
      if (this.yytext) {
        this.yyleng = this.yytext.length;
      }
      return tag;
    },
    setInput: function(input) {
      this.input = input;
      this.tokens = Lexer.tokenize(this.input);
      this.lines = this.input.split(/\r\n|\n|\r/);
      this.yylineno = this.yyleng = 0;
      this.yylloc = {
        first_line: 1,
        first_column: 0,
        last_line: 1,
        last_column: 0
      };
      return this.pos = 0;
    },
    upcomingInput: function() {
      return "ERRO";
    },
    prevText: function(tokens) {
      var pos, t;
      if (tokens == null) {
        tokens = 5;
      }
      pos = Math.max(this.pos - tokens, 0);
      return ((function() {
        var _i, _len, _ref, _results;
        _ref = this.tokens.slice(pos, this.pos);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          t = _ref[_i];
          _results.push(t[1]);
        }
        return _results;
      }).call(this)).join(" ");
    },
    showPosition: function() {
      return this.lines[this.yylineno];
    }
  };
  Lexer.expressions = {
    "identifier": IDENTIFIER,
    "metaid": METAID,
    "selector": SELECTOR,
    "attrid": ATTRID,
    "newline": NEWLINE,
    "whitespace": WHITESPACE,
    "number": NUMBER,
    "unitnumber": UNITNUMBER,
    "hexnumber": HEXNUMBER,
    "string": STRING,
    "comment": COMMENT,
    "operators": OPERATORS
  };
  if (typeof window != "undefined" && window !== null) {
    window.ScriptedCss.CssParser.Lexer = Lexer;
  }
  if (typeof module != "undefined" && module !== null) {
    module.exports = Lexer;
  }
}).call(this);
(function() {
  var AttributeNode, AttributeSelectorNode, AttributeSet, CssAST, FunctionNode, HexnumberNode, ImportantNode, LiteralNode, MetaNode, MetaSelectorNode, MultiValue, NamedArgumentNode, NumberNode, PercentNode, RuleNode, RulesNode, SelectorNode, StringNode, UnitNumberNode, collectStrings;
  var __slice = Array.prototype.slice;
  collectStrings = function(list) {
    var item, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = list.length; _i < _len; _i++) {
      item = list[_i];
      _results.push(item.string());
    }
    return _results;
  };
  Array.prototype.isArray = function() {
    return true;
  };
  CssAST = {
    createNode: function() {
      var args, expressions, nodes, type;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      expressions = ScriptedCss.CssParser.Lexer.expressions;
      nodes = {
        "rules": RulesNode,
        "rule": RuleNode,
        "attributes": AttributeSet,
        "meta": MetaNode,
        "selector": SelectorNode,
        "meta-selector": MetaSelectorNode,
        "attribute": AttributeNode,
        "function": FunctionNode,
        "attribute-selector": AttributeSelectorNode,
        "string": StringNode,
        "arg": NamedArgumentNode,
        "important": ImportantNode,
        "literal": LiteralNode,
        "number": NumberNode,
        "unit": UnitNumberNode,
        "hex": HexnumberNode,
        "multi-value": MultiValue
      };
      type = args.shift();
      if (args.length === 0) {
        type += "";
        if (type === "!") {
          return new ImportantNode();
        } else if (type.match(expressions.hexnumber)) {
          return new HexnumberNode(type);
        } else if (type.match(expressions.unitnumber)) {
          return new UnitNumberNode(type);
        } else if (type.match(expressions.number)) {
          return new NumberNode(type);
        } else {
          return new LiteralNode(type);
        }
      } else {
        if (nodes[type]) {
          if (type === "string") {
            args[0] = "'" + args[0] + "'";
          }
          return (function(func, args, ctor) {
            ctor.prototype = func.prototype;
            var child = new ctor, result = func.apply(child, args);
            return typeof result === "object" ? result : child;
          })(nodes[type], args, function() {});
        } else {
          if (type.isArray() && args[0]) {
            return new MultiValue(type, args[0]);
          }
          throw "Can't create node for type " + type;
        }
      }
    },
    RulesNode: RulesNode = (function() {
      function RulesNode(rules) {
        this.type = "RULES";
        this.rules = [];
        this.metaRules = [];
        this.elementRules = {};
        this.merge(rules);
      }
      RulesNode.prototype.merge = function(rules) {
        var rule, _i, _len;
        if (rules.type === "RULES") {
          return this.merge(rules.rules);
        } else {
          this.meta = {};
          for (_i = 0, _len = rules.length; _i < _len; _i++) {
            rule = rules[_i];
            if (rule.selector != null) {
              if (this.indexRule(rule)) {
                this.rules.push(rule);
              }
            } else {
              this.rules.push(rule);
              this.meta[rule.name] = rule.value;
              this.metaRules.push(rule);
            }
          }
          return this.indexAttributesAndSelectors();
        }
      };
      RulesNode.prototype.indexRule = function(rule) {
        if (this.elementRules[rule.selector.string()]) {
          this.elementRules[rule.selector.string()].meta = this.meta;
          this.elementRules[rule.selector.string()].attributes.merge(rule.attributes);
          return false;
        } else {
          rule.meta = this.meta;
          this.elementRules[rule.selector.string()] = rule;
          return true;
        }
      };
      RulesNode.prototype.indexAttributesAndSelectors = function() {
        var attribute, indexItem, name, rule, selector, _base, _i, _len, _ref, _ref2, _ref3, _results;
        this.attributes = {};
        this.selectorIndex = {};
        _ref = this.elementRules;
        _results = [];
        for (selector in _ref) {
          rule = _ref[selector];
          _ref2 = rule.selector.lastSelector().parts();
          for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
            indexItem = _ref2[_i];
            if (!indexItem.match(/^[#.]/)) {
              indexItem = indexItem.toUpperCase();
            }
            (_ref3 = (_base = this.selectorIndex)[indexItem]) != null ? _ref3 : _base[indexItem] = [];
            this.selectorIndex[indexItem].push(rule);
          }
          _results.push((function() {
            var _base, _name, _ref, _ref2, _results;
            _ref = rule.attributes.hash;
            _results = [];
            for (name in _ref) {
              attribute = _ref[name];
              (_ref2 = (_base = this.attributes)[_name = attribute.name]) != null ? _ref2 : _base[_name] = [];
              _results.push(this.attributes[attribute.name].push(attribute));
            }
            return _results;
          }).call(this));
        }
        return _results;
      };
      RulesNode.prototype.rulesForElement = function(element) {
        var elementClasses, index, klass, relativeIndexes, rule, rules, rulesHash, selector, _i, _j, _k, _len, _len2, _len3, _ref;
        rules = [];
        rulesHash = {};
        relativeIndexes = ["*"];
        elementClasses = element.className ? element.className.split(" ") : [];
        elementClasses = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = elementClasses.length; _i < _len; _i++) {
            klass = elementClasses[_i];
            _results.push("." + klass);
          }
          return _results;
        })();
        relativeIndexes.push(element.tagName);
        if (element.id) {
          relativeIndexes.push("#" + element.id);
        }
        for (_i = 0, _len = elementClasses.length; _i < _len; _i++) {
          klass = elementClasses[_i];
          relativeIndexes.push(klass);
        }
        for (_j = 0, _len2 = relativeIndexes.length; _j < _len2; _j++) {
          index = relativeIndexes[_j];
          _ref = this.selectorIndex[index] || [];
          for (_k = 0, _len3 = _ref.length; _k < _len3; _k++) {
            rule = _ref[_k];
            if (rule.selector.isCompatible(element)) {
              rulesHash[rule.selector.string()] = rule;
            }
          }
        }
        for (selector in rulesHash) {
          rule = rulesHash[selector];
          rules.push(rule);
        }
        return rules;
      };
      RulesNode.prototype.attributeForElement = function(element, attribute, stringify) {
        var attr, rule, rules, value, weight, _i, _len;
        if (stringify == null) {
          stringify = true;
        }
        rules = this.rulesForElement(element);
        value = [new AttributeNode(attribute, []), 0];
        for (_i = 0, _len = rules.length; _i < _len; _i++) {
          rule = rules[_i];
          attr = rule.attributes.hash[attribute];
          if (attr) {
            weight = attr.weight();
            if (weight > value[1]) {
              value = [attr, weight];
            }
          }
        }
        if (stringify) {
          return value[0].value();
        } else {
          return value[0];
        }
      };
      RulesNode.prototype.attribute = function(name) {
        return this.attributes[name] || [];
      };
      RulesNode.prototype.string = function() {
        var rule;
        return ((function() {
          var _i, _len, _ref, _results;
          _ref = this.rules;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            rule = _ref[_i];
            _results.push(rule.string());
          }
          return _results;
        }).call(this)).join("\n");
      };
      return RulesNode;
    })(),
    RuleNode: RuleNode = (function() {
      function RuleNode(selector, attributes) {
        this.selector = selector;
        this.type = "RULE";
        this.attributes = new AttributeSet(this, attributes);
      }
      RuleNode.prototype.cssAttributes = function() {
        var attr, hash, name, _ref;
        hash = {};
        _ref = this.attributes.hash;
        for (name in _ref) {
          attr = _ref[name];
          hash[name] = attr.value();
        }
        return hash;
      };
      RuleNode.prototype.string = function() {
        return "" + (this.selector.string()) + " " + (this.attributes.string());
      };
      return RuleNode;
    })(),
    AttributeSet: AttributeSet = (function() {
      AttributeSet.expansions = {};
      AttributeSet.registerExpansion = function(property, expansion) {
        return this.expansions[property] = expansion;
      };
      AttributeSet.prototype.expansion = function(name) {
        return AttributeSet.expansions[name];
      };
      function AttributeSet(owner, attributes) {
        this.owner = owner;
        this.type = "ATTRIBUTE_SET";
        this.items = [];
        this.hash = {};
        this.merge(attributes);
      }
      AttributeSet.prototype.merge = function(attributes) {
        var attribute, _i, _len, _results;
        if (attributes.type === "ATTRIBUTE_SET") {
          return this.merge(attributes.items);
        } else {
          _results = [];
          for (_i = 0, _len = attributes.length; _i < _len; _i++) {
            attribute = attributes[_i];
            _results.push(this.add(attribute));
          }
          return _results;
        }
      };
      AttributeSet.prototype.add = function(attribute) {
        var expanded, _i, _len, _ref, _results;
        if (this.expansion(attribute.name)) {
          _ref = this.merge(this.expansion(attribute.name).explode(attribute));
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            expanded = _ref[_i];
            expanded.important = attribute.important;
            _results.push(expanded);
          }
          return _results;
        } else {
          attribute.rule = this.owner;
          this.items.push(attribute);
          return this.hash[attribute.name] = attribute;
        }
      };
      AttributeSet.prototype.addFilter = function(node) {
        var filterAttribute;
        filterAttribute = this.hash["filter"];
        if (filterAttribute) {
          return filterAttribute.values.push(node);
        } else {
          return this.add(new AttributeNode("filter", [node]));
        }
      };
      AttributeSet.prototype.get = function(name) {
        var attr;
        if (this.expansion(name)) {
          attr = this.expansion(name).implode(this, name);
          attr.rule = this.owner;
          return attr;
        } else {
          return this.hash[name] || null;
        }
      };
      AttributeSet.prototype.string = function() {
        return "{ " + collectStrings(this.items).join("; ") + " }";
      };
      return AttributeSet;
    })(),
    MetaNode: MetaNode = (function() {
      function MetaNode(name, value) {
        this.name = name;
        this.value = value;
        this.type = "META";
        if (this.value.isArray) {
          this.value = new AttributeSet(this, this.value);
        }
      }
      MetaNode.prototype.string = function() {
        return "@" + this.name + " " + (this.value.string());
      };
      return MetaNode;
    })(),
    SelectorNode: SelectorNode = (function() {
      function SelectorNode(selector, attributes, meta) {
        this.selector = selector;
        this.attributes = attributes != null ? attributes : null;
        this.meta = meta != null ? meta : null;
        this.type = "SELECTOR";
        this.next = null;
        this.parent = null;
      }
      SelectorNode.prototype.nestSelector = function(selector, rule) {
        if (rule == null) {
          rule = " ";
        }
        if (this.next) {
          this.next.nestSelector.call(this.next, selector, rule);
        } else {
          this.next = selector;
          this.next.parent = this;
          this.nextRule = rule;
        }
        return this;
      };
      SelectorNode.prototype.lastSelector = function() {
        var last;
        last = this;
        while (last.next != null) {
          last = last.next;
        }
        return last;
      };
      SelectorNode.prototype.parts = function() {
        var chunk, i, part, parts;
        parts = [];
        i = 0;
        while (chunk = this.selector.slice(i)) {
          part = chunk.match(/[#.]?[^#.]+/)[0];
          parts.push(part);
          i += part.length;
        }
        return parts;
      };
      SelectorNode.prototype.isCompatible = function(element, sel) {
        var parts, previous;
        if (sel == null) {
          sel = this.lastSelector();
        }
        if (!this.isDirectCompatible(element, sel)) {
          return false;
        }
        sel = sel.parent;
        if (sel) {
          previous = null;
          switch (sel.nextRule) {
            case "+":
              while (previous = element.previousNode) {
                if (previous.nodeType === 1) {
                  break;
                }
              }
              if (!(previous && previous.nodeType === 1)) {
                return false;
              }
              return this.isCompatible(previous, sel);
              break;
            case ">":
              previous = element.parentNode;
              if (!previous) {
                return false;
              }
              return this.isCompatible(previous, sel);
              break;
            case " ":
              parts = sel.parts();
              previous = element;
              while (previous = previous.parentNode) {
                if (this.isDirectCompatible(previous, sel)) {
                  return this.isCompatible(previous, sel);
                }
              }
              return false;
          }
        }
        return true;
      };
      SelectorNode.prototype.isDirectCompatible = function(element, selector) {
        var c, elementClasses, elementId, elementTag, hasClass, klass, part, parts, _i, _j, _len, _len2, _ref;
        parts = selector.parts();
        elementTag = element.tagName;
        elementId = element.id;
        elementClasses = ((_ref = element.className) != null ? _ref.split(" ") : void 0) || [];
        for (_i = 0, _len = parts.length; _i < _len; _i++) {
          part = parts[_i];
          switch (part.charAt(0)) {
            case "#":
              if (elementId !== part.slice(1)) {
                return false;
              }
              break;
            case ".":
              klass = part.slice(1);
              hasClass = false;
              for (_j = 0, _len2 = elementClasses.length; _j < _len2; _j++) {
                c = elementClasses[_j];
                if (c === klass) {
                  hasClass = true;
                  break;
                }
              }
              if (!hasClass) {
                return false;
              }
              break;
            default:
              if (!(part === "*" || part.toUpperCase() === elementTag)) {
                return false;
              }
          }
        }
        return true;
      };
      SelectorNode.prototype.weight = function() {
        var part, weight, _i, _len, _ref;
        weight = 0;
        _ref = this.parts();
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          part = _ref[_i];
          switch (part.charAt(0)) {
            case "#":
              weight += 100;
              break;
            case ".":
              weight += 10;
              break;
            default:
              weight += 1;
          }
        }
        if (this.next != null) {
          weight += this.next.weight();
        }
        return weight;
      };
      SelectorNode.prototype.nextString = function() {
        var operatorString;
        if (this.next) {
          operatorString = this.nextRule === " " ? " " : " " + this.nextRule + " ";
          return operatorString + this.next.string();
        } else {
          return "";
        }
      };
      SelectorNode.prototype.attributeString = function() {
        if (this.attributes) {
          return "[" + (this.attributes.string()) + "]";
        } else {
          return "";
        }
      };
      SelectorNode.prototype.metaString = function() {
        if (this.meta) {
          return this.meta.string();
        } else {
          return "";
        }
      };
      SelectorNode.prototype.string = function() {
        return "" + this.selector + (this.attributeString()) + (this.metaString()) + (this.nextString());
      };
      return SelectorNode;
    })(),
    MetaSelectorNode: MetaSelectorNode = (function() {
      function MetaSelectorNode(value, operator) {
        this.value = value;
        this.operator = operator;
        this.type = "META_SELECTOR";
      }
      MetaSelectorNode.prototype.string = function() {
        return "" + this.operator + (this.value.string());
      };
      return MetaSelectorNode;
    })(),
    AttributeNode: AttributeNode = (function() {
      function AttributeNode(name, values, important) {
        var value, _i, _len;
        this.name = name;
        this.important = important != null ? important : false;
        this.type = "ATTRIBUTE";
        this.values = [];
        for (_i = 0, _len = values.length; _i < _len; _i++) {
          value = values[_i];
          if (value.type === "IMPORTANT") {
            this.important = true;
          } else {
            this.values.push(value);
          }
        }
      }
      AttributeNode.prototype.weight = function() {
        var w;
        if (!this.rule) {
          throw "Can't calculate weight of an deatached attribute";
        }
        w = this.rule.selector.weight();
        if (this.important) {
          w += 1000;
        }
        return w;
      };
      AttributeNode.prototype.importantString = function() {
        if (this.important) {
          return " !important";
        } else {
          return "";
        }
      };
      AttributeNode.prototype.value = function(includeImportant) {
        if (includeImportant == null) {
          includeImportant = false;
        }
        return collectStrings(this.values).join(" ") + (includeImportant ? this.importantString() : "");
      };
      AttributeNode.prototype.string = function() {
        return "" + this.name + ": " + (this.value(true));
      };
      return AttributeNode;
    })(),
    FunctionNode: FunctionNode = (function() {
      function FunctionNode(name, arguments) {
        var arg, _i, _len, _ref;
        this.name = name;
        this.arguments = arguments;
        this.type = "FUNCTION";
        this.namedArguments = {};
        _ref = this.arguments;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          arg = _ref[_i];
          if (arg.type === "NAMED_ARGUMENT") {
            this.namedArguments[arg.name] = arg.value;
          }
        }
      }
      FunctionNode.prototype.argumentsString = function() {
        return collectStrings(this.arguments).join(",");
      };
      FunctionNode.prototype.string = function() {
        return "" + this.name + "(" + (this.argumentsString()) + ")";
      };
      return FunctionNode;
    })(),
    AttributeSelectorNode: AttributeSelectorNode = (function() {
      function AttributeSelectorNode(name, operator, value) {
        this.name = name;
        this.operator = operator;
        this.value = value;
        this.type = "ATTRIBUTE_SELECTOR";
      }
      AttributeSelectorNode.prototype.string = function() {
        return "" + this.name + this.operator + (this.value.string());
      };
      return AttributeSelectorNode;
    })(),
    LiteralNode: LiteralNode = (function() {
      function LiteralNode(value) {
        this.value = value;
        this.type = "LITERAL";
      }
      LiteralNode.prototype.string = function() {
        return this.value.toString();
      };
      return LiteralNode;
    })(),
    StringNode: StringNode = (function() {
      function StringNode(value) {
        this.value = value;
        this.type = "STRING";
        this.text = this.value.substr(1, this.value.length - 2);
      }
      StringNode.prototype.string = function() {
        return this.value.toString();
      };
      return StringNode;
    })(),
    NumberNode: NumberNode = (function() {
      function NumberNode(value) {
        this.value = value;
        this.type = "NUMBER";
      }
      NumberNode.prototype.number = function() {
        return parseFloat(this.value);
      };
      NumberNode.prototype.string = function() {
        return this.value.toString();
      };
      return NumberNode;
    })(),
    UnitNumberNode: UnitNumberNode = (function() {
      function UnitNumberNode(value) {
        var _ref;
        this.value = value;
        this.type = "UNIT_NUMBER";
        _ref = value.match(/(.+?)([a-zA-Z%]+)/), this.value = _ref[0], this.number = _ref[1], this.unit = _ref[2];
        this.number = parseFloat(this.number);
      }
      UnitNumberNode.prototype.string = function() {
        return this.value.toString();
      };
      return UnitNumberNode;
    })(),
    HexnumberNode: HexnumberNode = (function() {
      function HexnumberNode(value) {
        this.value = value;
        this.type = "HEXNUMBER";
      }
      HexnumberNode.prototype.string = function() {
        return this.value;
      };
      return HexnumberNode;
    })(),
    PercentNode: PercentNode = (function() {
      function PercentNode(value) {
        this.value = value;
        this.type = "PERCENT";
      }
      PercentNode.prototype.string = function() {
        return this.value;
      };
      return PercentNode;
    })(),
    MultiValue: MultiValue = (function() {
      function MultiValue(literals, separator) {
        this.literals = literals;
        this.separator = separator;
        this.type = "MULTI_VALUE";
      }
      MultiValue.prototype.string = function() {
        return collectStrings(this.literals).join(this.separator);
      };
      return MultiValue;
    })(),
    NamedArgumentNode: NamedArgumentNode = (function() {
      function NamedArgumentNode(name, value) {
        this.name = name;
        this.value = value;
        this.type = "NAMED_ARGUMENT";
      }
      NamedArgumentNode.prototype.string = function() {
        return "" + this.name + "=" + (this.value.string());
      };
      return NamedArgumentNode;
    })(),
    ImportantNode: ImportantNode = (function() {
      function ImportantNode() {
        this.type = "IMPORTANT";
        this.important = true;
      }
      ImportantNode.prototype.string = function() {
        return "!important";
      };
      return ImportantNode;
    })()
  };
  if (typeof window != "undefined" && window !== null) {
    window.CssAST = CssAST;
  }
  if (typeof window != "undefined" && window !== null) {
    window.$n = CssAST.createNode;
  }
  if (typeof module != "undefined" && module !== null) {
    module.exports = CssAST;
  }
}).call(this);
(function() {
  ScriptedCss.CssParser.lexer = ScriptedCss.CssParser.Lexer.integrator;
  ScriptedCss.CssParser.yy = CssAST;
}).call(this);
