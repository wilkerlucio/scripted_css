/* Jison generated parser */
ScriptedCss.CssParser = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"Root":3,"Rules":4,"Rule":5,"Selectors":6,"{":7,"Attributes":8,"}":9,"@":10,"RegularIdentifier":11,"Value":12,"Selector":13,"SelectorOperator":14,",":15,">":16,"+":17,"~":18,"SelectorName":19,"[":20,"AttributeSelector":21,"]":22,"MetaSelector":23,"*":24,"SELECTOR":25,"SelectorContext":26,"#":27,".":28,"AttributeSelectorOperator":29,"=":30,"|":31,"^":32,"$":33,"MetaSelectorOperator":34,"MetaSelectorItem":35,"Function":36,":":37,"::":38,"Attribute":39,";":40,"ValueList":41,"ValueListItem":42,"ComaListValue":43,"IDENTIFIER":44,"STRING":45,"HEXNUMBER":46,"UNITNUMBER":47,"NUMBER":48,"/":49,"!":50,"IMPORTANT":51,"(":52,"ArgList":53,")":54,"URLIDENTIFIER":55,"UrlArg":56,"UrlArgItem":57,"?":58,"&":59,"ArgListValue":60,"MultiArg":61,"$accept":0,"$end":1},
terminals_: {2:"error",7:"{",9:"}",10:"@",15:",",16:">",17:"+",18:"~",20:"[",22:"]",24:"*",25:"SELECTOR",27:"#",28:".",30:"=",31:"|",32:"^",33:"$",37:":",38:"::",40:";",44:"IDENTIFIER",45:"STRING",46:"HEXNUMBER",47:"UNITNUMBER",48:"NUMBER",49:"/",50:"!",51:"IMPORTANT",52:"(",54:")",55:"URLIDENTIFIER",58:"?",59:"&"},
productions_: [0,[3,1],[4,1],[4,2],[5,4],[5,3],[6,1],[6,2],[6,3],[6,3],[14,1],[14,1],[14,1],[13,1],[13,4],[13,5],[13,2],[19,1],[19,1],[19,1],[19,2],[26,1],[26,1],[21,3],[29,1],[29,2],[29,2],[29,2],[29,2],[29,2],[23,2],[35,1],[35,1],[34,1],[34,1],[8,0],[8,1],[8,3],[8,2],[39,3],[39,4],[41,1],[41,2],[42,1],[42,1],[43,3],[43,3],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[36,4],[36,4],[56,1],[56,1],[56,2],[57,1],[57,1],[57,1],[57,1],[57,1],[57,1],[57,1],[57,1],[57,1],[11,1],[11,1],[53,0],[53,1],[53,3],[60,1],[60,1],[60,1],[60,1],[61,2],[61,2]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
case 1:this.$ = new yy.RulesNode($$[$0]); return this.$
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
case 5:this.$ = [new yy.MetaNode($$[$0-1], $$[$0].string())];
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
case 18:this.$ = $$[$0];
break;
case 19:this.$ = $$[$0];
break;
case 20:this.$ = $$[$0-1] + $$[$0];
break;
case 23:this.$ = new yy.AttributeSelectorNode($$[$0-2], $$[$0-1], $$[$0]);
break;
case 24:this.$ = $$[$0];
break;
case 25:this.$ = $$[$0-1] + $$[$0];
break;
case 26:this.$ = $$[$0-1] + $$[$0];
break;
case 27:this.$ = $$[$0-1] + $$[$0];
break;
case 28:this.$ = $$[$0-1] + $$[$0];
break;
case 29:this.$ = $$[$0-1] + $$[$0];
break;
case 30:this.$ = new yy.MetaSelectorNode($$[$0], $$[$0-1]);
break;
case 31:this.$ = new yy.LiteralNode($$[$0]);
break;
case 32:this.$ = $$[$0];
break;
case 33:this.$ = $$[$0];
break;
case 34:this.$ = $$[$0];
break;
case 35:this.$ = [];
break;
case 36:this.$ = [$$[$0]];
break;
case 37:this.$ = $$[$0-2].concat($$[$0]);
break;
case 38:this.$ = $$[$0-1];
break;
case 39:this.$ = new yy.AttributeNode($$[$0-2], $$[$0]);
break;
case 40:this.$ = new yy.AttributeNode($$[$0-3], $$[$0-1]);
break;
case 41:this.$ = [$$[$0]];
break;
case 42:this.$ = $$[$0-1].concat($$[$0]);
break;
case 43:this.$ = $$[$0];
break;
case 44:this.$ = new yy.MultiLiteral($$[$0], ", ");
break;
case 45:this.$ = [$$[$0-2], $$[$0]];
break;
case 46:this.$ = $$[$0-2].concat($$[$0]);
break;
case 47:this.$ = new yy.LiteralNode($$[$0]);
break;
case 48:this.$ = new yy.StringNode($$[$0]);
break;
case 49:this.$ = new yy.LiteralNode($$[$0]);
break;
case 50:this.$ = new yy.UnitNumberNode($$[$0]);
break;
case 51:this.$ = new yy.LiteralNode($$[$0]);
break;
case 52:this.$ = new yy.LiteralNode($$[$0]);
break;
case 53:this.$ = new yy.LiteralNode($$[$0]);
break;
case 54:this.$ = new yy.LiteralNode($$[$0]);
break;
case 55:this.$ = new yy.ImportantNode();
break;
case 56:this.$ = $$[$0];
break;
case 57:this.$ = new yy.FunctionNode($$[$0-3], $$[$0-1]);
break;
case 58:this.$ = new yy.FunctionNode($$[$0-3], [new yy.LiteralNode($$[$0-1])]);
break;
case 59:this.$ = new yy.StringNode($$[$0]).text;
break;
case 60:this.$ = $$[$0];
break;
case 61:this.$ = $$[$0-1] + $$[$0];
break;
case 62:this.$ = $$[$0];
break;
case 63:this.$ = $$[$0];
break;
case 64:this.$ = $$[$0];
break;
case 65:this.$ = $$[$0];
break;
case 66:this.$ = $$[$0];
break;
case 67:this.$ = $$[$0];
break;
case 68:this.$ = $$[$0];
break;
case 69:this.$ = $$[$0];
break;
case 70:this.$ = $$[$0];
break;
case 71:this.$ = $$[$0];
break;
case 72:this.$ = $$[$0];
break;
case 73:this.$ = [];
break;
case 74:this.$ = [$$[$0]];
break;
case 75:this.$ = $$[$0-2].concat($$[$0]);
break;
case 76:this.$ = $$[$0];
break;
case 77:this.$ = new yy.MultiLiteral($$[$0], " ");
break;
case 78:this.$ = new yy.LiteralNode($$[$0]);
break;
case 79:this.$ = new yy.LiteralNode($$[$0]);
break;
case 80:this.$ = [$$[$0-1], $$[$0]];
break;
case 81:this.$ = $$[$0-1].concat($$[$0]);
break;
}
},
table: [{3:1,4:2,5:3,6:4,10:[1,5],11:10,13:6,19:7,24:[1,8],25:[1,9],26:11,27:[1,14],28:[1,15],44:[1,12],55:[1,13]},{1:[3]},{1:[2,1],5:16,6:4,10:[1,5],11:10,13:6,19:7,24:[1,8],25:[1,9],26:11,27:[1,14],28:[1,15],44:[1,12],55:[1,13]},{1:[2,2],10:[2,2],24:[2,2],25:[2,2],27:[2,2],28:[2,2],44:[2,2],55:[2,2]},{7:[1,17],11:10,13:18,14:19,15:[1,20],16:[1,21],17:[1,22],18:[1,23],19:7,24:[1,8],25:[1,9],26:11,27:[1,14],28:[1,15],44:[1,12],55:[1,13]},{11:24,44:[1,12],55:[1,13]},{7:[2,6],15:[2,6],16:[2,6],17:[2,6],18:[2,6],24:[2,6],25:[2,6],27:[2,6],28:[2,6],44:[2,6],55:[2,6]},{7:[2,13],15:[2,13],16:[2,13],17:[2,13],18:[2,13],20:[1,25],23:26,24:[2,13],25:[2,13],27:[2,13],28:[2,13],34:27,37:[1,28],38:[1,29],44:[2,13],55:[2,13]},{7:[2,17],15:[2,17],16:[2,17],17:[2,17],18:[2,17],20:[2,17],24:[2,17],25:[2,17],27:[2,17],28:[2,17],37:[2,17],38:[2,17],44:[2,17],55:[2,17]},{7:[2,18],15:[2,18],16:[2,18],17:[2,18],18:[2,18],20:[2,18],24:[2,18],25:[2,18],27:[2,18],28:[2,18],37:[2,18],38:[2,18],44:[2,18],55:[2,18]},{7:[2,19],15:[2,19],16:[2,19],17:[2,19],18:[2,19],20:[2,19],24:[2,19],25:[2,19],27:[2,19],28:[2,19],37:[2,19],38:[2,19],44:[2,19],55:[2,19]},{11:30,44:[1,12],55:[1,13]},{7:[2,71],15:[2,71],16:[2,71],17:[2,71],18:[2,71],20:[2,71],24:[2,71],25:[2,71],27:[2,71],28:[2,71],30:[2,71],31:[2,71],32:[2,71],33:[2,71],37:[2,71],38:[2,71],44:[2,71],45:[2,71],46:[2,71],47:[2,71],48:[2,71],49:[2,71],50:[2,71],51:[2,71],54:[2,71],55:[2,71],58:[2,71],59:[2,71]},{7:[2,72],15:[2,72],16:[2,72],17:[2,72],18:[2,72],20:[2,72],24:[2,72],25:[2,72],27:[2,72],28:[2,72],30:[2,72],31:[2,72],32:[2,72],33:[2,72],37:[2,72],38:[2,72],44:[2,72],45:[2,72],46:[2,72],47:[2,72],48:[2,72],49:[2,72],50:[2,72],51:[2,72],54:[2,72],55:[2,72],58:[2,72],59:[2,72]},{44:[2,21],55:[2,21]},{44:[2,22],55:[2,22]},{1:[2,3],10:[2,3],24:[2,3],25:[2,3],27:[2,3],28:[2,3],44:[2,3],55:[2,3]},{8:31,9:[2,35],11:33,24:[1,34],39:32,40:[2,35],44:[1,12],55:[1,13]},{7:[2,7],15:[2,7],16:[2,7],17:[2,7],18:[2,7],24:[2,7],25:[2,7],27:[2,7],28:[2,7],44:[2,7],55:[2,7]},{11:10,13:35,19:7,24:[1,8],25:[1,9],26:11,27:[1,14],28:[1,15],44:[1,12],55:[1,13]},{11:10,13:36,19:7,24:[1,8],25:[1,9],26:11,27:[1,14],28:[1,15],44:[1,12],55:[1,13]},{24:[2,10],25:[2,10],27:[2,10],28:[2,10],44:[2,10],55:[2,10]},{24:[2,11],25:[2,11],27:[2,11],28:[2,11],44:[2,11],55:[2,11]},{24:[2,12],25:[2,12],27:[2,12],28:[2,12],44:[2,12],55:[2,12]},{12:37,24:[1,44],36:47,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48]},{11:50,21:49,44:[1,12],55:[1,13]},{7:[2,16],15:[2,16],16:[2,16],17:[2,16],18:[2,16],24:[2,16],25:[2,16],27:[2,16],28:[2,16],44:[2,16],55:[2,16]},{11:52,35:51,36:53,44:[1,54],55:[1,55]},{44:[2,33],55:[2,33]},{44:[2,34],55:[2,34]},{7:[2,20],15:[2,20],16:[2,20],17:[2,20],18:[2,20],20:[2,20],24:[2,20],25:[2,20],27:[2,20],28:[2,20],37:[2,20],38:[2,20],44:[2,20],55:[2,20]},{9:[1,56],40:[1,57]},{9:[2,36],40:[2,36]},{37:[1,58]},{11:59,44:[1,12],55:[1,13]},{7:[2,8],15:[2,8],16:[2,8],17:[2,8],18:[2,8],24:[2,8],25:[2,8],27:[2,8],28:[2,8],44:[2,8],55:[2,8]},{7:[2,9],15:[2,9],16:[2,9],17:[2,9],18:[2,9],24:[2,9],25:[2,9],27:[2,9],28:[2,9],44:[2,9],55:[2,9]},{1:[2,5],10:[2,5],24:[2,5],25:[2,5],27:[2,5],28:[2,5],44:[2,5],55:[2,5]},{1:[2,47],9:[2,47],10:[2,47],15:[2,47],22:[2,47],24:[2,47],25:[2,47],27:[2,47],28:[2,47],40:[2,47],44:[2,47],45:[2,47],46:[2,47],47:[2,47],48:[2,47],49:[2,47],50:[2,47],51:[2,47],52:[1,60],54:[2,47],55:[2,47]},{1:[2,48],9:[2,48],10:[2,48],15:[2,48],22:[2,48],24:[2,48],25:[2,48],27:[2,48],28:[2,48],40:[2,48],44:[2,48],45:[2,48],46:[2,48],47:[2,48],48:[2,48],49:[2,48],50:[2,48],51:[2,48],54:[2,48],55:[2,48]},{1:[2,49],9:[2,49],10:[2,49],15:[2,49],22:[2,49],24:[2,49],25:[2,49],27:[2,49],28:[2,49],40:[2,49],44:[2,49],45:[2,49],46:[2,49],47:[2,49],48:[2,49],49:[2,49],50:[2,49],51:[2,49],54:[2,49],55:[2,49]},{1:[2,50],9:[2,50],10:[2,50],15:[2,50],22:[2,50],24:[2,50],25:[2,50],27:[2,50],28:[2,50],40:[2,50],44:[2,50],45:[2,50],46:[2,50],47:[2,50],48:[2,50],49:[2,50],50:[2,50],51:[2,50],54:[2,50],55:[2,50]},{1:[2,51],9:[2,51],10:[2,51],15:[2,51],22:[2,51],24:[2,51],25:[2,51],27:[2,51],28:[2,51],40:[2,51],44:[2,51],45:[2,51],46:[2,51],47:[2,51],48:[2,51],49:[2,51],50:[2,51],51:[2,51],54:[2,51],55:[2,51]},{1:[2,52],9:[2,52],10:[2,52],15:[2,52],22:[2,52],24:[2,52],25:[2,52],27:[2,52],28:[2,52],40:[2,52],44:[2,52],45:[2,52],46:[2,52],47:[2,52],48:[2,52],49:[2,52],50:[2,52],51:[2,52],54:[2,52],55:[2,52]},{1:[2,53],9:[2,53],10:[2,53],15:[2,53],22:[2,53],24:[2,53],25:[2,53],27:[2,53],28:[2,53],40:[2,53],44:[2,53],45:[2,53],46:[2,53],47:[2,53],48:[2,53],49:[2,53],50:[2,53],51:[2,53],54:[2,53],55:[2,53]},{1:[2,54],9:[2,54],10:[2,54],15:[2,54],22:[2,54],24:[2,54],25:[2,54],27:[2,54],28:[2,54],40:[2,54],44:[2,54],45:[2,54],46:[2,54],47:[2,54],48:[2,54],49:[2,54],50:[2,54],51:[2,54],54:[2,54],55:[2,54]},{1:[2,55],9:[2,55],10:[2,55],15:[2,55],22:[2,55],24:[2,55],25:[2,55],27:[2,55],28:[2,55],40:[2,55],44:[2,55],45:[2,55],46:[2,55],47:[2,55],48:[2,55],49:[2,55],50:[2,55],51:[2,55],54:[2,55],55:[2,55]},{1:[2,56],9:[2,56],10:[2,56],15:[2,56],22:[2,56],24:[2,56],25:[2,56],27:[2,56],28:[2,56],40:[2,56],44:[2,56],45:[2,56],46:[2,56],47:[2,56],48:[2,56],49:[2,56],50:[2,56],51:[2,56],54:[2,56],55:[2,56]},{52:[1,61]},{22:[1,62]},{18:[1,65],24:[1,69],29:63,30:[1,64],31:[1,66],32:[1,67],33:[1,68]},{7:[2,30],15:[2,30],16:[2,30],17:[2,30],18:[2,30],24:[2,30],25:[2,30],27:[2,30],28:[2,30],44:[2,30],55:[2,30]},{7:[2,31],15:[2,31],16:[2,31],17:[2,31],18:[2,31],24:[2,31],25:[2,31],27:[2,31],28:[2,31],44:[2,31],55:[2,31]},{7:[2,32],15:[2,32],16:[2,32],17:[2,32],18:[2,32],24:[2,32],25:[2,32],27:[2,32],28:[2,32],44:[2,32],55:[2,32]},{7:[2,71],15:[2,71],16:[2,71],17:[2,71],18:[2,71],24:[2,71],25:[2,71],27:[2,71],28:[2,71],44:[2,71],52:[1,60],55:[2,71]},{7:[2,72],15:[2,72],16:[2,72],17:[2,72],18:[2,72],24:[2,72],25:[2,72],27:[2,72],28:[2,72],44:[2,72],52:[1,61],55:[2,72]},{1:[2,4],10:[2,4],24:[2,4],25:[2,4],27:[2,4],28:[2,4],44:[2,4],55:[2,4]},{9:[2,38],11:33,24:[1,34],39:70,40:[2,38],44:[1,12],55:[1,13]},{12:73,24:[1,44],36:47,41:71,42:72,43:74,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48]},{37:[1,75]},{10:[1,81],12:78,15:[2,73],24:[1,44],28:[1,80],36:47,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],53:76,54:[2,73],55:[1,48],60:77,61:79},{11:85,25:[1,86],28:[1,88],30:[1,91],37:[1,89],44:[1,12],45:[1,83],48:[1,93],49:[1,87],55:[1,13],56:82,57:84,58:[1,90],59:[1,92]},{7:[2,14],15:[2,14],16:[2,14],17:[2,14],18:[2,14],23:94,24:[2,14],25:[2,14],27:[2,14],28:[2,14],34:27,37:[1,28],38:[1,29],44:[2,14],55:[2,14]},{12:95,24:[1,44],36:47,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48]},{24:[2,24],44:[2,24],45:[2,24],46:[2,24],47:[2,24],48:[2,24],49:[2,24],50:[2,24],51:[2,24],55:[2,24]},{30:[1,96]},{30:[1,97]},{30:[1,98]},{30:[1,99]},{30:[1,100]},{9:[2,37],40:[2,37]},{9:[2,39],12:73,24:[1,44],36:47,40:[2,39],42:101,43:74,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48]},{9:[2,41],24:[2,41],40:[2,41],44:[2,41],45:[2,41],46:[2,41],47:[2,41],48:[2,41],49:[2,41],50:[2,41],51:[2,41],55:[2,41]},{9:[2,43],15:[1,102],24:[2,43],40:[2,43],44:[2,43],45:[2,43],46:[2,43],47:[2,43],48:[2,43],49:[2,43],50:[2,43],51:[2,43],55:[2,43]},{9:[2,44],15:[1,103],24:[2,44],40:[2,44],44:[2,44],45:[2,44],46:[2,44],47:[2,44],48:[2,44],49:[2,44],50:[2,44],51:[2,44],55:[2,44]},{12:73,24:[1,44],36:47,41:104,42:72,43:74,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48]},{15:[1,106],54:[1,105]},{15:[2,74],54:[2,74]},{12:107,15:[2,76],24:[1,44],36:47,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],54:[2,76],55:[1,48]},{12:108,15:[2,77],24:[1,44],36:47,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],54:[2,77],55:[1,48]},{15:[2,78],54:[2,78]},{15:[2,79],54:[2,79]},{11:85,25:[1,86],28:[1,88],30:[1,91],37:[1,89],44:[1,12],48:[1,93],49:[1,87],54:[1,109],55:[1,13],57:110,58:[1,90],59:[1,92]},{25:[2,59],28:[2,59],30:[2,59],37:[2,59],44:[2,59],48:[2,59],49:[2,59],54:[2,59],55:[2,59],58:[2,59],59:[2,59]},{25:[2,60],28:[2,60],30:[2,60],37:[2,60],44:[2,60],48:[2,60],49:[2,60],54:[2,60],55:[2,60],58:[2,60],59:[2,60]},{25:[2,62],28:[2,62],30:[2,62],37:[2,62],44:[2,62],48:[2,62],49:[2,62],54:[2,62],55:[2,62],58:[2,62],59:[2,62]},{25:[2,63],28:[2,63],30:[2,63],37:[2,63],44:[2,63],48:[2,63],49:[2,63],54:[2,63],55:[2,63],58:[2,63],59:[2,63]},{25:[2,64],28:[2,64],30:[2,64],37:[2,64],44:[2,64],48:[2,64],49:[2,64],54:[2,64],55:[2,64],58:[2,64],59:[2,64]},{25:[2,65],28:[2,65],30:[2,65],37:[2,65],44:[2,65],48:[2,65],49:[2,65],54:[2,65],55:[2,65],58:[2,65],59:[2,65]},{25:[2,66],28:[2,66],30:[2,66],37:[2,66],44:[2,66],48:[2,66],49:[2,66],54:[2,66],55:[2,66],58:[2,66],59:[2,66]},{25:[2,67],28:[2,67],30:[2,67],37:[2,67],44:[2,67],48:[2,67],49:[2,67],54:[2,67],55:[2,67],58:[2,67],59:[2,67]},{25:[2,68],28:[2,68],30:[2,68],37:[2,68],44:[2,68],48:[2,68],49:[2,68],54:[2,68],55:[2,68],58:[2,68],59:[2,68]},{25:[2,69],28:[2,69],30:[2,69],37:[2,69],44:[2,69],48:[2,69],49:[2,69],54:[2,69],55:[2,69],58:[2,69],59:[2,69]},{25:[2,70],28:[2,70],30:[2,70],37:[2,70],44:[2,70],48:[2,70],49:[2,70],54:[2,70],55:[2,70],58:[2,70],59:[2,70]},{7:[2,15],15:[2,15],16:[2,15],17:[2,15],18:[2,15],24:[2,15],25:[2,15],27:[2,15],28:[2,15],44:[2,15],55:[2,15]},{22:[2,23]},{24:[2,25],44:[2,25],45:[2,25],46:[2,25],47:[2,25],48:[2,25],49:[2,25],50:[2,25],51:[2,25],55:[2,25]},{24:[2,26],44:[2,26],45:[2,26],46:[2,26],47:[2,26],48:[2,26],49:[2,26],50:[2,26],51:[2,26],55:[2,26]},{24:[2,27],44:[2,27],45:[2,27],46:[2,27],47:[2,27],48:[2,27],49:[2,27],50:[2,27],51:[2,27],55:[2,27]},{24:[2,28],44:[2,28],45:[2,28],46:[2,28],47:[2,28],48:[2,28],49:[2,28],50:[2,28],51:[2,28],55:[2,28]},{24:[2,29],44:[2,29],45:[2,29],46:[2,29],47:[2,29],48:[2,29],49:[2,29],50:[2,29],51:[2,29],55:[2,29]},{9:[2,42],24:[2,42],40:[2,42],44:[2,42],45:[2,42],46:[2,42],47:[2,42],48:[2,42],49:[2,42],50:[2,42],51:[2,42],55:[2,42]},{12:111,24:[1,44],36:47,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48]},{12:112,24:[1,44],36:47,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48]},{9:[2,40],12:73,24:[1,44],36:47,40:[2,40],42:101,43:74,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48]},{1:[2,57],7:[2,57],9:[2,57],10:[2,57],15:[2,57],16:[2,57],17:[2,57],18:[2,57],22:[2,57],24:[2,57],25:[2,57],27:[2,57],28:[2,57],40:[2,57],44:[2,57],45:[2,57],46:[2,57],47:[2,57],48:[2,57],49:[2,57],50:[2,57],51:[2,57],54:[2,57],55:[2,57]},{10:[1,81],12:78,24:[1,44],28:[1,80],36:47,44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,43],50:[1,45],51:[1,46],55:[1,48],60:113,61:79},{15:[2,80],24:[2,80],44:[2,80],45:[2,80],46:[2,80],47:[2,80],48:[2,80],49:[2,80],50:[2,80],51:[2,80],54:[2,80],55:[2,80]},{15:[2,81],24:[2,81],44:[2,81],45:[2,81],46:[2,81],47:[2,81],48:[2,81],49:[2,81],50:[2,81],51:[2,81],54:[2,81],55:[2,81]},{1:[2,58],7:[2,58],9:[2,58],10:[2,58],15:[2,58],16:[2,58],17:[2,58],18:[2,58],22:[2,58],24:[2,58],25:[2,58],27:[2,58],28:[2,58],40:[2,58],44:[2,58],45:[2,58],46:[2,58],47:[2,58],48:[2,58],49:[2,58],50:[2,58],51:[2,58],54:[2,58],55:[2,58]},{25:[2,61],28:[2,61],30:[2,61],37:[2,61],44:[2,61],48:[2,61],49:[2,61],54:[2,61],55:[2,61],58:[2,61],59:[2,61]},{9:[2,45],15:[2,45],24:[2,45],40:[2,45],44:[2,45],45:[2,45],46:[2,45],47:[2,45],48:[2,45],49:[2,45],50:[2,45],51:[2,45],55:[2,45]},{9:[2,46],15:[2,46],24:[2,46],40:[2,46],44:[2,46],45:[2,46],46:[2,46],47:[2,46],48:[2,46],49:[2,46],50:[2,46],51:[2,46],55:[2,46]},{15:[2,75],54:[2,75]}],
defaultActions: {95:[2,23]},
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
case 0:return 55;
break;
case 1:return 46
break;
case 2:return 51
break;
case 3:return 47
break;
case 4:return 47
break;
case 5:return 48
break;
case 6:return 48
break;
case 7:return 25;
break;
case 8:return 44;
break;
case 9:return 45;
break;
case 10:/* skip whitespaces */
break;
case 11:/* skip comments */
break;
case 12:return 10;
break;
case 13:return 33;
break;
case 14:return 17;
break;
case 15:return 7;
break;
case 16:return 9;
break;
case 17:return 52;
break;
case 18:return 54;
break;
case 19:return 20;
break;
case 20:return 22;
break;
case 21:return '<';
break;
case 22:return 16;
break;
case 23:return 32;
break;
case 24:return 58;
break;
case 25:return 59;
break;
case 26:return 50;
break;
case 27:return 18;
break;
case 28:return 30;
break;
case 29:return '-';
break;
case 30:return 31;
break;
case 31:return 27;
break;
case 32:return 28;
break;
case 33:return 38;
break;
case 34:return 37;
break;
case 35:return 40;
break;
case 36:return 24;
break;
case 37:return '';
break;
case 38:return 49;
break;
case 39:return 15;
break;
}
};
lexer.rules = [/^url/,/^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6})\b/,/^[!]important\b/,/^-?\d+(\.\d+)?(%|in|cm|mm|em|ex|pt|pc|px|ms|s)/,/^-?\.\d+(%|in|cm|mm|em|ex|pt|pc|px|ms|s)/,/^-?\d+(\.\d+)?/,/^-?\.\d+/,/^[.#]?[a-zA-Z_-][a-zA-Z0-9_-]*[.#][a-zA-Z0-9.#_-]+/,/^[a-zA-Z_-][a-zA-Z0-9_-]*/,/^("[^"]*"|'[^']*')/,/^\s+/,/^\/\*.*?\*\//,/^\@/,/^\$/,/^\+/,/^\{/,/^\}/,/^\(/,/^\)/,/^\[/,/^\]/,/^\</,/^\>/,/^\^/,/^\?/,/^\&/,/^\!/,/^\~/,/^=/,/^\-/,/^\|/,/^\#/,/^\./,/^::/,/^:/,/^;/,/^\*/,/^\\/,/^\//,/^,/];
lexer.conditions = {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39],"inclusive":true}};return lexer;})()
parser.lexer = lexer;
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
        relativeIndexes = [];
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
              if (part.toUpperCase() !== elementTag) {
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
