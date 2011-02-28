/* Jison generated parser */
ScriptedCss.CssParser = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"Root":3,"Rules":4,"EOF":5,"Rule":6,"Selectors":7,"{":8,"Attributes":9,"}":10,"@":11,"IDENTIFIER":12,"Value":13,"Selector":14,"SELECTOR_OPERATOR":15,",":16,"SelectorOperator":17,">":18,"+":19,"~":20,"SelectorName":21,"[":22,"AttributeSelector":23,"]":24,"MetaSelector":25,"*":26,"AttributeSelectorOperator":27,"=":28,"|":29,"^":30,"$":31,"MetaSelectorOperator":32,"MetaSelectorItem":33,"Function":34,":":35,"::":36,"Attribute":37,";":38,"ValueList":39,"ValueListItem":40,"ComaListValue":41,"STRING":42,"HEXNUMBER":43,"UNITNUMBER":44,"NUMBER":45,"/":46,"!":47,"IMPORTANT":48,"(":49,"ArgList":50,")":51,"UrlArgItem":52,"SELECTOR":53,".":54,"?":55,"&":56,"ArgListValue":57,"MultiArg":58,"$accept":0,"$end":1},
terminals_: {2:"error",5:"EOF",8:"{",10:"}",11:"@",12:"IDENTIFIER",15:"SELECTOR_OPERATOR",16:",",18:">",19:"+",20:"~",22:"[",24:"]",26:"*",28:"=",29:"|",30:"^",31:"$",35:":",36:"::",38:";",42:"STRING",43:"HEXNUMBER",44:"UNITNUMBER",45:"NUMBER",46:"/",47:"!",48:"IMPORTANT",49:"(",51:")",53:"SELECTOR",54:".",55:"?",56:"&"},
productions_: [0,[3,2],[4,1],[4,2],[6,4],[6,3],[6,5],[7,1],[7,3],[7,3],[17,1],[17,1],[17,1],[14,1],[14,4],[14,5],[14,2],[14,1],[21,1],[21,1],[23,3],[27,1],[27,2],[27,2],[27,2],[27,2],[27,2],[25,2],[33,1],[33,1],[32,1],[32,1],[9,0],[9,1],[9,3],[9,2],[37,3],[39,1],[39,2],[40,1],[40,1],[41,3],[41,3],[13,1],[13,1],[13,1],[13,1],[13,1],[13,1],[13,1],[13,1],[13,1],[13,1],[34,4],[52,1],[52,1],[52,1],[52,1],[52,1],[52,1],[52,1],[52,1],[52,1],[50,0],[50,1],[50,3],[57,1],[57,1],[57,1],[57,1],[58,2],[58,2]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
case 1:this.$ = new yy.RulesNode($$[$0-1]); return this.$
break;
case 2:this.$ = $$[$0];
break;
case 3:this.$ = $$[$0-1].concat($$[$0]);
break;
case 4:this.$ = (function () {
        var selector, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = $$[$0-3].length; _i < _len; _i++) {
          selector = $$[$0-3][_i];
          _results.push(new yy.RuleNode(selector, $$[$0-1]));
        }
        return _results;
      }());
break;
case 5:this.$ = [new yy.MetaNode($$[$0-1], $$[$0])];
break;
case 6:this.$ = [new yy.MetaNode($$[$0-3], $$[$0-1])];
break;
case 7:this.$ = [$$[$0]];
break;
case 8:this.$ = (function () {
        $$[$0-2][$$[$0-2].length - 1].nestSelector($$[$0-1], " ");
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
case 17:this.$ = new yy.SelectorNode("*", null, $$[$0]);
break;
case 18:this.$ = $$[$0];
break;
case 19:this.$ = $$[$0];
break;
case 20:this.$ = new yy.AttributeSelectorNode($$[$0-2], $$[$0-1], $$[$0]);
break;
case 21:this.$ = $$[$0];
break;
case 22:this.$ = $$[$0-1] + $$[$0];
break;
case 23:this.$ = $$[$0-1] + $$[$0];
break;
case 24:this.$ = $$[$0-1] + $$[$0];
break;
case 25:this.$ = $$[$0-1] + $$[$0];
break;
case 26:this.$ = $$[$0-1] + $$[$0];
break;
case 27:this.$ = new yy.MetaSelectorNode($$[$0], $$[$0-1]);
break;
case 28:this.$ = new yy.LiteralNode($$[$0]);
break;
case 29:this.$ = $$[$0];
break;
case 30:this.$ = $$[$0];
break;
case 31:this.$ = $$[$0];
break;
case 32:this.$ = [];
break;
case 33:this.$ = [$$[$0]];
break;
case 34:this.$ = $$[$0-2].concat($$[$0]);
break;
case 35:this.$ = $$[$0-1];
break;
case 36:this.$ = new yy.AttributeNode($$[$0-2], $$[$0]);
break;
case 37:this.$ = [$$[$0]];
break;
case 38:this.$ = $$[$0-1].concat($$[$0]);
break;
case 39:this.$ = $$[$0];
break;
case 40:this.$ = new yy.MultiLiteral($$[$0], ", ");
break;
case 41:this.$ = [$$[$0-2], $$[$0]];
break;
case 42:this.$ = $$[$0-2].concat($$[$0]);
break;
case 43:this.$ = new yy.LiteralNode($$[$0]);
break;
case 44:this.$ = new yy.StringNode($$[$0]);
break;
case 45:this.$ = new yy.LiteralNode($$[$0]);
break;
case 46:this.$ = new yy.UnitNumberNode($$[$0]);
break;
case 47:this.$ = new yy.LiteralNode($$[$0]);
break;
case 48:this.$ = new yy.LiteralNode($$[$0]);
break;
case 49:this.$ = new yy.LiteralNode($$[$0]);
break;
case 50:this.$ = new yy.LiteralNode($$[$0]);
break;
case 51:this.$ = new yy.ImportantNode();
break;
case 52:this.$ = $$[$0];
break;
case 53:this.$ = new yy.FunctionNode($$[$0-3], $$[$0-1]);
break;
case 54:this.$ = $$[$0];
break;
case 55:this.$ = $$[$0];
break;
case 56:this.$ = $$[$0];
break;
case 57:this.$ = $$[$0];
break;
case 58:this.$ = $$[$0];
break;
case 59:this.$ = $$[$0];
break;
case 60:this.$ = $$[$0];
break;
case 61:this.$ = $$[$0];
break;
case 62:this.$ = $$[$0];
break;
case 63:this.$ = [];
break;
case 64:this.$ = [$$[$0]];
break;
case 65:this.$ = $$[$0-2].concat($$[$0]);
break;
case 66:this.$ = $$[$0];
break;
case 67:this.$ = new yy.MultiLiteral($$[$0], " ");
break;
case 68:this.$ = new yy.LiteralNode($$[$0]);
break;
case 69:this.$ = new yy.LiteralNode($$[$0]);
break;
case 70:this.$ = [$$[$0-1], $$[$0]];
break;
case 71:this.$ = $$[$0-1].concat($$[$0]);
break;
}
},
table: [{3:1,4:2,6:3,7:4,11:[1,5],12:[1,10],14:6,21:7,25:8,26:[1,9],32:11,35:[1,12],36:[1,13]},{1:[3]},{5:[1,14],6:15,7:4,11:[1,5],12:[1,10],14:6,21:7,25:8,26:[1,9],32:11,35:[1,12],36:[1,13]},{5:[2,2],11:[2,2],12:[2,2],26:[2,2],35:[2,2],36:[2,2]},{8:[1,16],15:[1,17],16:[1,18]},{12:[1,19]},{8:[2,7],15:[2,7],16:[2,7]},{8:[2,13],15:[2,13],16:[2,13],22:[1,20],25:21,32:11,35:[1,12],36:[1,13]},{8:[2,17],15:[2,17],16:[2,17]},{8:[2,18],15:[2,18],16:[2,18],22:[2,18],35:[2,18],36:[2,18]},{8:[2,19],15:[2,19],16:[2,19],22:[2,19],35:[2,19],36:[2,19]},{12:[1,23],33:22,34:24},{12:[2,30]},{12:[2,31]},{1:[2,1]},{5:[2,3],11:[2,3],12:[2,3],26:[2,3],35:[2,3],36:[2,3]},{9:25,10:[2,32],12:[1,27],37:26,38:[2,32]},{12:[1,10],14:28,21:7,25:8,26:[1,9],32:11,35:[1,12],36:[1,13]},{12:[1,10],14:29,21:7,25:8,26:[1,9],32:11,35:[1,12],36:[1,13]},{8:[1,31],12:[1,32],13:30,26:[1,38],34:41,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40]},{12:[1,43],23:42},{8:[2,16],15:[2,16],16:[2,16]},{8:[2,27],15:[2,27],16:[2,27]},{8:[2,28],15:[2,28],16:[2,28],49:[1,44]},{8:[2,29],15:[2,29],16:[2,29]},{10:[1,45],38:[1,46]},{10:[2,33],38:[2,33]},{35:[1,47]},{8:[2,8],15:[2,8],16:[2,8]},{8:[2,9],15:[2,9],16:[2,9]},{5:[2,5],11:[2,5],12:[2,5],26:[2,5],35:[2,5],36:[2,5]},{9:48,10:[2,32],12:[1,27],37:26,38:[2,32]},{5:[2,43],10:[2,43],11:[2,43],12:[2,43],16:[2,43],24:[2,43],26:[2,43],35:[2,43],36:[2,43],38:[2,43],42:[2,43],43:[2,43],44:[2,43],45:[2,43],46:[2,43],47:[2,43],48:[2,43],49:[1,44],51:[2,43]},{5:[2,44],10:[2,44],11:[2,44],12:[2,44],16:[2,44],24:[2,44],26:[2,44],35:[2,44],36:[2,44],38:[2,44],42:[2,44],43:[2,44],44:[2,44],45:[2,44],46:[2,44],47:[2,44],48:[2,44],51:[2,44]},{5:[2,45],10:[2,45],11:[2,45],12:[2,45],16:[2,45],24:[2,45],26:[2,45],35:[2,45],36:[2,45],38:[2,45],42:[2,45],43:[2,45],44:[2,45],45:[2,45],46:[2,45],47:[2,45],48:[2,45],51:[2,45]},{5:[2,46],10:[2,46],11:[2,46],12:[2,46],16:[2,46],24:[2,46],26:[2,46],35:[2,46],36:[2,46],38:[2,46],42:[2,46],43:[2,46],44:[2,46],45:[2,46],46:[2,46],47:[2,46],48:[2,46],51:[2,46]},{5:[2,47],10:[2,47],11:[2,47],12:[2,47],16:[2,47],24:[2,47],26:[2,47],35:[2,47],36:[2,47],38:[2,47],42:[2,47],43:[2,47],44:[2,47],45:[2,47],46:[2,47],47:[2,47],48:[2,47],51:[2,47]},{5:[2,48],10:[2,48],11:[2,48],12:[2,48],16:[2,48],24:[2,48],26:[2,48],35:[2,48],36:[2,48],38:[2,48],42:[2,48],43:[2,48],44:[2,48],45:[2,48],46:[2,48],47:[2,48],48:[2,48],51:[2,48]},{5:[2,49],10:[2,49],11:[2,49],12:[2,49],16:[2,49],24:[2,49],26:[2,49],35:[2,49],36:[2,49],38:[2,49],42:[2,49],43:[2,49],44:[2,49],45:[2,49],46:[2,49],47:[2,49],48:[2,49],51:[2,49]},{5:[2,50],10:[2,50],11:[2,50],12:[2,50],16:[2,50],24:[2,50],26:[2,50],35:[2,50],36:[2,50],38:[2,50],42:[2,50],43:[2,50],44:[2,50],45:[2,50],46:[2,50],47:[2,50],48:[2,50],51:[2,50]},{5:[2,51],10:[2,51],11:[2,51],12:[2,51],16:[2,51],24:[2,51],26:[2,51],35:[2,51],36:[2,51],38:[2,51],42:[2,51],43:[2,51],44:[2,51],45:[2,51],46:[2,51],47:[2,51],48:[2,51],51:[2,51]},{5:[2,52],10:[2,52],11:[2,52],12:[2,52],16:[2,52],24:[2,52],26:[2,52],35:[2,52],36:[2,52],38:[2,52],42:[2,52],43:[2,52],44:[2,52],45:[2,52],46:[2,52],47:[2,52],48:[2,52],51:[2,52]},{24:[1,49]},{20:[1,52],26:[1,56],27:50,28:[1,51],29:[1,53],30:[1,54],31:[1,55]},{11:[1,62],12:[1,32],13:59,16:[2,63],26:[1,38],34:41,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40],50:57,51:[2,63],54:[1,61],57:58,58:60},{5:[2,4],11:[2,4],12:[2,4],26:[2,4],35:[2,4],36:[2,4]},{10:[2,35],12:[1,27],37:63,38:[2,35]},{12:[1,32],13:66,26:[1,38],34:41,39:64,40:65,41:67,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40]},{10:[1,68],38:[1,46]},{8:[2,14],15:[2,14],16:[2,14],25:69,32:11,35:[1,12],36:[1,13]},{12:[1,32],13:70,26:[1,38],34:41,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40]},{12:[2,21],26:[2,21],42:[2,21],43:[2,21],44:[2,21],45:[2,21],46:[2,21],47:[2,21],48:[2,21]},{28:[1,71]},{28:[1,72]},{28:[1,73]},{28:[1,74]},{28:[1,75]},{16:[1,77],51:[1,76]},{16:[2,64],51:[2,64]},{12:[1,32],13:78,16:[2,66],26:[1,38],34:41,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40],51:[2,66]},{12:[1,32],13:79,16:[2,67],26:[1,38],34:41,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40],51:[2,67]},{16:[2,68],51:[2,68]},{16:[2,69],51:[2,69]},{10:[2,34],38:[2,34]},{10:[2,36],12:[1,32],13:66,26:[1,38],34:41,38:[2,36],40:80,41:67,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40]},{10:[2,37],12:[2,37],26:[2,37],38:[2,37],42:[2,37],43:[2,37],44:[2,37],45:[2,37],46:[2,37],47:[2,37],48:[2,37]},{10:[2,39],12:[2,39],16:[1,81],26:[2,39],38:[2,39],42:[2,39],43:[2,39],44:[2,39],45:[2,39],46:[2,39],47:[2,39],48:[2,39]},{10:[2,40],12:[2,40],16:[1,82],26:[2,40],38:[2,40],42:[2,40],43:[2,40],44:[2,40],45:[2,40],46:[2,40],47:[2,40],48:[2,40]},{5:[2,6],11:[2,6],12:[2,6],26:[2,6],35:[2,6],36:[2,6]},{8:[2,15],15:[2,15],16:[2,15]},{24:[2,20]},{12:[2,22],26:[2,22],42:[2,22],43:[2,22],44:[2,22],45:[2,22],46:[2,22],47:[2,22],48:[2,22]},{12:[2,23],26:[2,23],42:[2,23],43:[2,23],44:[2,23],45:[2,23],46:[2,23],47:[2,23],48:[2,23]},{12:[2,24],26:[2,24],42:[2,24],43:[2,24],44:[2,24],45:[2,24],46:[2,24],47:[2,24],48:[2,24]},{12:[2,25],26:[2,25],42:[2,25],43:[2,25],44:[2,25],45:[2,25],46:[2,25],47:[2,25],48:[2,25]},{12:[2,26],26:[2,26],42:[2,26],43:[2,26],44:[2,26],45:[2,26],46:[2,26],47:[2,26],48:[2,26]},{5:[2,53],8:[2,53],10:[2,53],11:[2,53],12:[2,53],15:[2,53],16:[2,53],24:[2,53],26:[2,53],35:[2,53],36:[2,53],38:[2,53],42:[2,53],43:[2,53],44:[2,53],45:[2,53],46:[2,53],47:[2,53],48:[2,53],51:[2,53]},{11:[1,62],12:[1,32],13:59,26:[1,38],34:41,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40],54:[1,61],57:83,58:60},{12:[2,70],16:[2,70],26:[2,70],42:[2,70],43:[2,70],44:[2,70],45:[2,70],46:[2,70],47:[2,70],48:[2,70],51:[2,70]},{12:[2,71],16:[2,71],26:[2,71],42:[2,71],43:[2,71],44:[2,71],45:[2,71],46:[2,71],47:[2,71],48:[2,71],51:[2,71]},{10:[2,38],12:[2,38],26:[2,38],38:[2,38],42:[2,38],43:[2,38],44:[2,38],45:[2,38],46:[2,38],47:[2,38],48:[2,38]},{12:[1,32],13:84,26:[1,38],34:41,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40]},{12:[1,32],13:85,26:[1,38],34:41,42:[1,33],43:[1,34],44:[1,35],45:[1,36],46:[1,37],47:[1,39],48:[1,40]},{16:[2,65],51:[2,65]},{10:[2,41],12:[2,41],16:[2,41],26:[2,41],38:[2,41],42:[2,41],43:[2,41],44:[2,41],45:[2,41],46:[2,41],47:[2,41],48:[2,41]},{10:[2,42],12:[2,42],16:[2,42],26:[2,42],38:[2,42],42:[2,42],43:[2,42],44:[2,42],45:[2,42],46:[2,42],47:[2,42],48:[2,42]}],
defaultActions: {12:[2,30],13:[2,31],14:[2,1],70:[2,20]},
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
  var AttributeNode, AttributeSelectorNode, CssAST, FunctionNode, ImportantNode, LiteralNode, MetaNode, MetaSelectorNode, MultiLiteral, RuleNode, RulesNode, SelectorNode, StringNode, UnitNumberNode, collectStrings;
  collectStrings = function(list) {
    var item, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = list.length; _i < _len; _i++) {
      item = list[_i];
      _results.push(item.string());
    }
    return _results;
  };
  CssAST = {
    RulesNode: RulesNode = (function() {
      function RulesNode(rules) {
        this.rules = [];
        this.metaRules = [];
        this.elementRules = {};
        this.index(rules);
      }
      RulesNode.prototype.index = function(rules) {
        var rule, _i, _len;
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
      };
      RulesNode.prototype.indexRule = function(rule) {
        if (this.elementRules[rule.selector.string()]) {
          this.elementRules[rule.selector.string()].meta = this.meta;
          this.elementRules[rule.selector.string()].mergeAttributes(rule.attributes);
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
            _ref = rule.attributesHash;
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
          attr = rule.attributesHash[attribute];
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
        var attribute, _i, _len;
        this.selector = selector;
        this.attributes = [];
        this.attributesHash = {};
        for (_i = 0, _len = attributes.length; _i < _len; _i++) {
          attribute = attributes[_i];
          this.addAttribute(attribute);
        }
      }
      RuleNode.prototype.addAttribute = function(attribute) {
        attribute.rule = this;
        this.attributes.push(attribute);
        return this.attributesHash[attribute.name] = attribute;
      };
      RuleNode.prototype.mergeAttributes = function(attributes) {
        var attribute, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = attributes.length; _i < _len; _i++) {
          attribute = attributes[_i];
          _results.push(this.addAttribute(attribute));
        }
        return _results;
      };
      RuleNode.prototype.cssAttributes = function() {
        var attr, hash, name, _ref;
        hash = {};
        _ref = this.attributesHash;
        for (name in _ref) {
          attr = _ref[name];
          hash[name] = attr.value();
        }
        return hash;
      };
      RuleNode.prototype.attributesString = function() {
        return collectStrings(this.attributes).join("; ");
      };
      RuleNode.prototype.string = function() {
        return "" + (this.selector.string()) + " { " + (this.attributesString()) + " }";
      };
      return RuleNode;
    })(),
    MetaNode: MetaNode = (function() {
      function MetaNode(name, value) {
        this.name = name;
        this.value = value;
      }
      MetaNode.prototype.string = function() {
        return "@" + this.name + " " + this.value;
      };
      return MetaNode;
    })(),
    SelectorNode: SelectorNode = (function() {
      function SelectorNode(selector, attributes, meta) {
        this.selector = selector;
        this.attributes = attributes != null ? attributes : null;
        this.meta = meta != null ? meta : null;
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
      }
      MetaSelectorNode.prototype.string = function() {
        return "" + this.operator + (this.value.string());
      };
      return MetaSelectorNode;
    })(),
    AttributeNode: AttributeNode = (function() {
      function AttributeNode(name, values) {
        this.name = name;
        this.values = values;
      }
      AttributeNode.prototype.isImportant = function() {
        var value, _i, _len, _ref;
        _ref = this.values;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          value = _ref[_i];
          if (value.important) {
            return true;
          }
        }
        return false;
      };
      AttributeNode.prototype.weight = function() {
        var w;
        if (!this.rule) {
          throw "Can't calculate weight of an deatached attribute";
        }
        w = this.rule.selector.weight();
        if (this.isImportant()) {
          w += 1000;
        }
        return w;
      };
      AttributeNode.prototype.value = function() {
        return collectStrings(this.values).join(" ");
      };
      AttributeNode.prototype.string = function() {
        return "" + this.name + ": " + (this.value());
      };
      return AttributeNode;
    })(),
    FunctionNode: FunctionNode = (function() {
      function FunctionNode(name, arguments) {
        this.name = name;
        this.arguments = arguments;
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
      }
      AttributeSelectorNode.prototype.string = function() {
        return "" + this.name + this.operator + (this.value.string());
      };
      return AttributeSelectorNode;
    })(),
    LiteralNode: LiteralNode = (function() {
      function LiteralNode(value) {
        this.value = value;
      }
      LiteralNode.prototype.string = function() {
        return this.value.toString();
      };
      return LiteralNode;
    })(),
    StringNode: StringNode = (function() {
      function StringNode(value) {
        this.value = value;
        this.text = this.value.substr(1, this.value.length - 2);
      }
      StringNode.prototype.string = function() {
        return this.value.toString();
      };
      return StringNode;
    })(),
    UnitNumberNode: UnitNumberNode = (function() {
      function UnitNumberNode(value) {
        var _ref;
        this.value = value;
        _ref = value.match(/(.+?)([a-zA-Z%]+)/), this.value = _ref[0], this.number = _ref[1], this.unit = _ref[2];
        this.number = parseFloat(this.number);
      }
      UnitNumberNode.prototype.string = function() {
        return this.value.toString();
      };
      return UnitNumberNode;
    })(),
    MultiLiteral: MultiLiteral = (function() {
      function MultiLiteral(literals, separator) {
        this.literals = literals;
        this.separator = separator;
      }
      MultiLiteral.prototype.string = function() {
        return collectStrings(this.literals).join(this.separator);
      };
      return MultiLiteral;
    })(),
    ImportantNode: ImportantNode = (function() {
      function ImportantNode() {
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
  if (typeof module != "undefined" && module !== null) {
    module.exports = CssAST;
  }
}).call(this);
(function() {
  ScriptedCss.CssParser.yy = CssAST;
}).call(this);
