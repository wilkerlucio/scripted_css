/* Jison generated parser */
var CssParser = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"Root":3,"Rules":4,"Rule":5,"Selectors":6,"{":7,"Attributes":8,"}":9,"@":10,"IDENTIFIER":11,"Value":12,"Selector":13,"SelectorOperator":14,",":15,">":16,"+":17,"~":18,"SelectorName":19,"[":20,"AttributeSelector":21,"]":22,"MetaSelector":23,"SelectorContext":24,"#":25,".":26,"AttributeSelectorOperator":27,"=":28,"|":29,"^":30,"$":31,"*":32,"MetaSelectorOperator":33,"MetaSelectorItem":34,"Function":35,":":36,"::":37,"Attribute":38,";":39,"ValueList":40,"STRING":41,"HEXNUMBER":42,"UNITNUMBER":43,"NUMBER":44,"/":45,"(":46,"ArgList":47,")":48,"$accept":0,"$end":1},
terminals_: {2:"error",7:"{",9:"}",10:"@",11:"IDENTIFIER",15:",",16:">",17:"+",18:"~",20:"[",22:"]",25:"#",26:".",28:"=",29:"|",30:"^",31:"$",32:"*",36:":",37:"::",39:";",41:"STRING",42:"HEXNUMBER",43:"UNITNUMBER",44:"NUMBER",45:"/",46:"(",48:")"},
productions_: [0,[3,1],[4,1],[4,2],[5,4],[5,3],[6,1],[6,2],[6,3],[6,3],[14,1],[14,1],[14,1],[13,1],[13,4],[13,5],[13,2],[19,1],[19,2],[24,1],[24,1],[21,3],[27,1],[27,2],[27,2],[27,2],[27,2],[27,2],[23,2],[34,1],[34,1],[33,1],[33,1],[8,0],[8,1],[8,3],[8,2],[38,3],[40,1],[40,2],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[35,4],[47,0],[47,1],[47,3]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
case 1:this.$ = new yy.RulesNode($$[$0]); return this.$
break;
case 2:this.$ = [$$[$0]];
break;
case 3:this.$ = $$[$0-1].concat($$[$0]);
break;
case 4:this.$ = new yy.RuleNode($$[$0-3], $$[$0-1]);
break;
case 5:this.$ = new yy.MetaNode($$[$0-1], $$[$0].string());
break;
case 6:this.$ = [$$[$0]];
break;
case 7:this.$ = (function () {
        $$[$0-1][$$[$0-1].length - 1].nestSelector($$[$0], " ");
        return $$[$0-1];
      }());
break;
case 8:this.$ = (function () {
        $$[$0-2][$$[$0-2].length - 1].nestSelector($$[$0], $$[$0-1]);
        return $$[$0-2];
      }());
break;
case 9:this.$ = $$[$0-2].concat($$[$0]);
break;
case 10:this.$ = $$[$0];
break;
case 11:this.$ = $$[$0];
break;
case 12:this.$ = $$[$0];
break;
case 13:this.$ = new yy.SelectorNode($$[$0]);
break;
case 14:this.$ = new yy.SelectorNode($$[$0-3], $$[$0-1]);
break;
case 15:this.$ = new yy.SelectorNode($$[$0-4], $$[$0-2], $$[$0]);
break;
case 16:this.$ = new yy.SelectorNode($$[$0-1], null, $$[$0]);
break;
case 17:this.$ = $$[$0];
break;
case 18:this.$ = $$[$0-1] + $$[$0];
break;
case 21:this.$ = new yy.AttributeSelectorNode($$[$0-2], $$[$0-1], $$[$0]);
break;
case 22:this.$ = $$[$0];
break;
case 23:this.$ = $$[$0-1] + $$[$0];
break;
case 24:this.$ = $$[$0-1] + $$[$0];
break;
case 25:this.$ = $$[$0-1] + $$[$0];
break;
case 26:this.$ = $$[$0-1] + $$[$0];
break;
case 27:this.$ = $$[$0-1] + $$[$0];
break;
case 28:this.$ = new yy.MetaSelectorNode($$[$0], $$[$0-1]);
break;
case 29:this.$ = new yy.LiteralNode($$[$0]);
break;
case 30:this.$ = $$[$0];
break;
case 31:this.$ = $$[$0];
break;
case 32:this.$ = $$[$0];
break;
case 33:this.$ = [];
break;
case 34:this.$ = [$$[$0]];
break;
case 35:this.$ = $$[$0-2].concat($$[$0]);
break;
case 36:this.$ = $$[$0-1];
break;
case 37:this.$ = new yy.AttributeNode($$[$0-2], $$[$0]);
break;
case 38:this.$ = [$$[$0]];
break;
case 39:this.$ = $$[$0-1].concat($$[$0]);
break;
case 40:this.$ = new yy.LiteralNode($$[$0]);
break;
case 41:this.$ = new yy.LiteralNode($$[$0]);
break;
case 42:this.$ = new yy.LiteralNode($$[$0]);
break;
case 43:this.$ = new yy.LiteralNode($$[$0]);
break;
case 44:this.$ = new yy.LiteralNode($$[$0]);
break;
case 45:this.$ = new yy.LiteralNode($$[$0]);
break;
case 46:this.$ = new yy.LiteralNode($$[$0]);
break;
case 47:this.$ = $$[$0];
break;
case 48:this.$ = new yy.FunctionNode($$[$0-3], $$[$0-1]);
break;
case 49:this.$ = [];
break;
case 50:this.$ = [$$[$0]];
break;
case 51:this.$ = $$[$0-2].concat($$[$0]);
break;
}
},
table: [{3:1,4:2,5:3,6:4,10:[1,5],11:[1,8],13:6,19:7,24:9,25:[1,10],26:[1,11]},{1:[3]},{1:[2,1],5:12,6:4,10:[1,5],11:[1,8],13:6,19:7,24:9,25:[1,10],26:[1,11]},{1:[2,2],10:[2,2],11:[2,2],25:[2,2],26:[2,2]},{7:[1,13],11:[1,8],13:14,14:15,15:[1,16],16:[1,17],17:[1,18],18:[1,19],19:7,24:9,25:[1,10],26:[1,11]},{11:[1,20]},{7:[2,6],11:[2,6],15:[2,6],16:[2,6],17:[2,6],18:[2,6],25:[2,6],26:[2,6]},{7:[2,13],11:[2,13],15:[2,13],16:[2,13],17:[2,13],18:[2,13],20:[1,21],23:22,25:[2,13],26:[2,13],33:23,36:[1,24],37:[1,25]},{7:[2,17],11:[2,17],15:[2,17],16:[2,17],17:[2,17],18:[2,17],20:[2,17],25:[2,17],26:[2,17],36:[2,17],37:[2,17]},{11:[1,26]},{11:[2,19]},{11:[2,20]},{1:[2,3],10:[2,3],11:[2,3],25:[2,3],26:[2,3]},{8:27,9:[2,33],11:[1,29],38:28,39:[2,33]},{7:[2,7],11:[2,7],15:[2,7],16:[2,7],17:[2,7],18:[2,7],25:[2,7],26:[2,7]},{11:[1,8],13:30,19:7,24:9,25:[1,10],26:[1,11]},{11:[1,8],13:31,19:7,24:9,25:[1,10],26:[1,11]},{11:[2,10],25:[2,10],26:[2,10]},{11:[2,11],25:[2,11],26:[2,11]},{11:[2,12],25:[2,12],26:[2,12]},{11:[1,33],12:32,32:[1,39],35:40,41:[1,34],42:[1,35],43:[1,36],44:[1,37],45:[1,38]},{11:[1,42],21:41},{7:[2,16],11:[2,16],15:[2,16],16:[2,16],17:[2,16],18:[2,16],25:[2,16],26:[2,16]},{11:[1,44],34:43,35:45},{11:[2,31]},{11:[2,32]},{7:[2,18],11:[2,18],15:[2,18],16:[2,18],17:[2,18],18:[2,18],20:[2,18],25:[2,18],26:[2,18],36:[2,18],37:[2,18]},{9:[1,46],39:[1,47]},{9:[2,34],39:[2,34]},{36:[1,48]},{7:[2,8],11:[2,8],15:[2,8],16:[2,8],17:[2,8],18:[2,8],25:[2,8],26:[2,8]},{7:[2,9],11:[2,9],15:[2,9],16:[2,9],17:[2,9],18:[2,9],25:[2,9],26:[2,9]},{1:[2,5],10:[2,5],11:[2,5],25:[2,5],26:[2,5]},{1:[2,40],9:[2,40],10:[2,40],11:[2,40],15:[2,40],22:[2,40],25:[2,40],26:[2,40],32:[2,40],39:[2,40],41:[2,40],42:[2,40],43:[2,40],44:[2,40],45:[2,40],46:[1,49],48:[2,40]},{1:[2,41],9:[2,41],10:[2,41],11:[2,41],15:[2,41],22:[2,41],25:[2,41],26:[2,41],32:[2,41],39:[2,41],41:[2,41],42:[2,41],43:[2,41],44:[2,41],45:[2,41],48:[2,41]},{1:[2,42],9:[2,42],10:[2,42],11:[2,42],15:[2,42],22:[2,42],25:[2,42],26:[2,42],32:[2,42],39:[2,42],41:[2,42],42:[2,42],43:[2,42],44:[2,42],45:[2,42],48:[2,42]},{1:[2,43],9:[2,43],10:[2,43],11:[2,43],15:[2,43],22:[2,43],25:[2,43],26:[2,43],32:[2,43],39:[2,43],41:[2,43],42:[2,43],43:[2,43],44:[2,43],45:[2,43],48:[2,43]},{1:[2,44],9:[2,44],10:[2,44],11:[2,44],15:[2,44],22:[2,44],25:[2,44],26:[2,44],32:[2,44],39:[2,44],41:[2,44],42:[2,44],43:[2,44],44:[2,44],45:[2,44],48:[2,44]},{1:[2,45],9:[2,45],10:[2,45],11:[2,45],15:[2,45],22:[2,45],25:[2,45],26:[2,45],32:[2,45],39:[2,45],41:[2,45],42:[2,45],43:[2,45],44:[2,45],45:[2,45],48:[2,45]},{1:[2,46],9:[2,46],10:[2,46],11:[2,46],15:[2,46],22:[2,46],25:[2,46],26:[2,46],32:[2,46],39:[2,46],41:[2,46],42:[2,46],43:[2,46],44:[2,46],45:[2,46],48:[2,46]},{1:[2,47],9:[2,47],10:[2,47],11:[2,47],15:[2,47],22:[2,47],25:[2,47],26:[2,47],32:[2,47],39:[2,47],41:[2,47],42:[2,47],43:[2,47],44:[2,47],45:[2,47],48:[2,47]},{22:[1,50]},{18:[1,53],27:51,28:[1,52],29:[1,54],30:[1,55],31:[1,56],32:[1,57]},{7:[2,28],11:[2,28],15:[2,28],16:[2,28],17:[2,28],18:[2,28],25:[2,28],26:[2,28]},{7:[2,29],11:[2,29],15:[2,29],16:[2,29],17:[2,29],18:[2,29],25:[2,29],26:[2,29],46:[1,49]},{7:[2,30],11:[2,30],15:[2,30],16:[2,30],17:[2,30],18:[2,30],25:[2,30],26:[2,30]},{1:[2,4],10:[2,4],11:[2,4],25:[2,4],26:[2,4]},{9:[2,36],11:[1,29],38:58,39:[2,36]},{11:[1,33],12:60,32:[1,39],35:40,40:59,41:[1,34],42:[1,35],43:[1,36],44:[1,37],45:[1,38]},{11:[1,33],12:62,15:[2,49],32:[1,39],35:40,41:[1,34],42:[1,35],43:[1,36],44:[1,37],45:[1,38],47:61,48:[2,49]},{7:[2,14],11:[2,14],15:[2,14],16:[2,14],17:[2,14],18:[2,14],23:63,25:[2,14],26:[2,14],33:23,36:[1,24],37:[1,25]},{11:[1,33],12:64,32:[1,39],35:40,41:[1,34],42:[1,35],43:[1,36],44:[1,37],45:[1,38]},{11:[2,22],32:[2,22],41:[2,22],42:[2,22],43:[2,22],44:[2,22],45:[2,22]},{28:[1,65]},{28:[1,66]},{28:[1,67]},{28:[1,68]},{28:[1,69]},{9:[2,35],39:[2,35]},{9:[2,37],11:[1,33],12:70,32:[1,39],35:40,39:[2,37],41:[1,34],42:[1,35],43:[1,36],44:[1,37],45:[1,38]},{9:[2,38],11:[2,38],32:[2,38],39:[2,38],41:[2,38],42:[2,38],43:[2,38],44:[2,38],45:[2,38]},{15:[1,72],48:[1,71]},{15:[2,50],48:[2,50]},{7:[2,15],11:[2,15],15:[2,15],16:[2,15],17:[2,15],18:[2,15],25:[2,15],26:[2,15]},{22:[2,21]},{11:[2,23],32:[2,23],41:[2,23],42:[2,23],43:[2,23],44:[2,23],45:[2,23]},{11:[2,24],32:[2,24],41:[2,24],42:[2,24],43:[2,24],44:[2,24],45:[2,24]},{11:[2,25],32:[2,25],41:[2,25],42:[2,25],43:[2,25],44:[2,25],45:[2,25]},{11:[2,26],32:[2,26],41:[2,26],42:[2,26],43:[2,26],44:[2,26],45:[2,26]},{11:[2,27],32:[2,27],41:[2,27],42:[2,27],43:[2,27],44:[2,27],45:[2,27]},{9:[2,39],11:[2,39],32:[2,39],39:[2,39],41:[2,39],42:[2,39],43:[2,39],44:[2,39],45:[2,39]},{1:[2,48],7:[2,48],9:[2,48],10:[2,48],11:[2,48],15:[2,48],16:[2,48],17:[2,48],18:[2,48],22:[2,48],25:[2,48],26:[2,48],32:[2,48],39:[2,48],41:[2,48],42:[2,48],43:[2,48],44:[2,48],45:[2,48],48:[2,48]},{11:[1,33],12:73,32:[1,39],35:40,41:[1,34],42:[1,35],43:[1,36],44:[1,37],45:[1,38]},{15:[2,51],48:[2,51]}],
defaultActions: {10:[2,19],11:[2,20],24:[2,31],25:[2,32],64:[2,21]},
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
                    last_column: lstack[lstack.length-1].last_column,
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
case 0:return 11;
break;
case 1:return 41;
break;
case 2:return 42
break;
case 3:return 43
break;
case 4:return 43
break;
case 5:return 44
break;
case 6:return 44
break;
case 7:/* skip whitespaces */
break;
case 8:/* skip comments */
break;
case 9:return 10;
break;
case 10:return 31;
break;
case 11:return 17;
break;
case 12:return 7;
break;
case 13:return 9;
break;
case 14:return 46;
break;
case 15:return 48;
break;
case 16:return 20;
break;
case 17:return 22;
break;
case 18:return '<';
break;
case 19:return 16;
break;
case 20:return 30;
break;
case 21:return 18;
break;
case 22:return 28;
break;
case 23:return '-';
break;
case 24:return 29;
break;
case 25:return 25;
break;
case 26:return 26;
break;
case 27:return 37;
break;
case 28:return 36;
break;
case 29:return 39;
break;
case 30:return 32;
break;
case 31:return '';
break;
case 32:return 45;
break;
case 33:return 15;
break;
}
};
lexer.rules = [/^[a-zA-Z_-][a-zA-Z0-9_-]*/,/^("[^"]*"|'[^']*')/,/^#([0-9a-fA-F]+)\b/,/^-?\d+(\.\d+)?(%|in|cm|mm|em|ex|pt|pc|px)\b/,/^-?\.\d+(%|in|cm|mm|em|ex|pt|pc|px)\b/,/^-?\d+(\.\d+)?/,/^-?\.\d+/,/^\s+/,/^/\*.*?\*//,/^\@/,/^\$/,/^\+/,/^\{/,/^\}/,/^\(/,/^\)/,/^\[/,/^\]/,/^\</,/^\>/,/^\^/,/^\~/,/^=/,/^\-/,/^\|/,/^\#/,/^\./,/^::/,/^:/,/^;/,/^\*/,/^\\/,/^//,/^,/];
lexer.conditions = {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33],"inclusive":true}};return lexer;})()
parser.lexer = lexer;
return parser;
})();
if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = CssParser;
exports.parse = function () { return CssParser.parse.apply(CssParser, arguments); }
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
}