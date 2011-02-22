/* Jison generated parser */
var CssParser = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"Root":3,"Rules":4,"Rule":5,"Selectors":6,"{":7,"Attributes":8,"}":9,"@":10,"RegularIdentifier":11,"Value":12,"Selector":13,"SelectorOperator":14,",":15,">":16,"+":17,"~":18,"SelectorName":19,"[":20,"AttributeSelector":21,"]":22,"MetaSelector":23,"*":24,"SelectorContext":25,"#":26,".":27,"AttributeSelectorOperator":28,"=":29,"|":30,"^":31,"$":32,"MetaSelectorOperator":33,"MetaSelectorItem":34,"Function":35,":":36,"::":37,"Attribute":38,";":39,"ValueList":40,"ValueListItem":41,"ComaListValue":42,"IDENTIFIER":43,"STRING":44,"HEXNUMBER":45,"UNITNUMBER":46,"NUMBER":47,"/":48,"!":49,"(":50,"ArgList":51,")":52,"URLIDENTIFIER":53,"UrlArg":54,"UrlArgItem":55,"?":56,"&":57,"ArgListValue":58,"MultiArg":59,"$accept":0,"$end":1},
terminals_: {2:"error",7:"{",9:"}",10:"@",15:",",16:">",17:"+",18:"~",20:"[",22:"]",24:"*",26:"#",27:".",29:"=",30:"|",31:"^",32:"$",36:":",37:"::",39:";",43:"IDENTIFIER",44:"STRING",45:"HEXNUMBER",46:"UNITNUMBER",47:"NUMBER",48:"/",49:"!",50:"(",52:")",53:"URLIDENTIFIER",56:"?",57:"&"},
productions_: [0,[3,1],[4,1],[4,2],[5,4],[5,3],[6,1],[6,2],[6,3],[6,3],[14,1],[14,1],[14,1],[13,1],[13,4],[13,5],[13,2],[19,1],[19,1],[19,2],[25,1],[25,1],[21,3],[28,1],[28,2],[28,2],[28,2],[28,2],[28,2],[23,2],[34,1],[34,1],[33,1],[33,1],[8,0],[8,1],[8,3],[8,2],[38,3],[38,4],[40,1],[40,2],[41,1],[41,1],[42,3],[42,3],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[12,1],[35,4],[35,4],[54,1],[54,1],[54,2],[55,1],[55,1],[55,1],[55,1],[55,1],[55,1],[55,1],[55,1],[11,1],[11,1],[51,0],[51,1],[51,3],[58,1],[58,1],[59,2],[59,2]],
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
case 18:this.$ = $$[$0];
break;
case 19:this.$ = $$[$0-1] + $$[$0];
break;
case 22:this.$ = new yy.AttributeSelectorNode($$[$0-2], $$[$0-1], $$[$0]);
break;
case 23:this.$ = $$[$0];
break;
case 24:this.$ = $$[$0-1] + $$[$0];
break;
case 25:this.$ = $$[$0-1] + $$[$0];
break;
case 26:this.$ = $$[$0-1] + $$[$0];
break;
case 27:this.$ = $$[$0-1] + $$[$0];
break;
case 28:this.$ = $$[$0-1] + $$[$0];
break;
case 29:this.$ = new yy.MetaSelectorNode($$[$0], $$[$0-1]);
break;
case 30:this.$ = new yy.LiteralNode($$[$0]);
break;
case 31:this.$ = $$[$0];
break;
case 32:this.$ = $$[$0];
break;
case 33:this.$ = $$[$0];
break;
case 34:this.$ = [];
break;
case 35:this.$ = [$$[$0]];
break;
case 36:this.$ = $$[$0-2].concat($$[$0]);
break;
case 37:this.$ = $$[$0-1];
break;
case 38:this.$ = new yy.AttributeNode($$[$0-2], $$[$0]);
break;
case 39:this.$ = new yy.AttributeNode($$[$0-3], $$[$0-1]);
break;
case 40:this.$ = [$$[$0]];
break;
case 41:this.$ = $$[$0-1].concat($$[$0]);
break;
case 42:this.$ = $$[$0];
break;
case 43:this.$ = new yy.MultiLiteral($$[$0], ", ");
break;
case 44:this.$ = [$$[$0-2], $$[$0]];
break;
case 45:this.$ = $$[$0-2].concat($$[$0]);
break;
case 46:this.$ = new yy.LiteralNode($$[$0]);
break;
case 47:this.$ = new yy.LiteralNode($$[$0]);
break;
case 48:this.$ = new yy.LiteralNode($$[$0]);
break;
case 49:this.$ = new yy.LiteralNode($$[$0]);
break;
case 50:this.$ = new yy.LiteralNode($$[$0]);
break;
case 51:this.$ = new yy.LiteralNode($$[$0]);
break;
case 52:this.$ = new yy.LiteralNode($$[$0]);
break;
case 53:this.$ = new yy.LiteralNode($$[$0]);
break;
case 54:this.$ = $$[$0];
break;
case 55:this.$ = new yy.FunctionNode($$[$0-3], $$[$0-1]);
break;
case 56:this.$ = new yy.FunctionNode($$[$0-3], [new yy.LiteralNode($$[$0-1])]);
break;
case 57:this.$ = $$[$0];
break;
case 58:this.$ = $$[$0];
break;
case 59:this.$ = $$[$0-1] + $$[$0];
break;
case 60:this.$ = $$[$0];
break;
case 61:this.$ = $$[$0];
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
case 70:this.$ = [];
break;
case 71:this.$ = [$$[$0]];
break;
case 72:this.$ = $$[$0-2].concat($$[$0]);
break;
case 73:this.$ = $$[$0];
break;
case 74:this.$ = new yy.MultiLiteral($$[$0], " ");
break;
case 75:this.$ = [$$[$0-1], $$[$0]];
break;
case 76:this.$ = $$[$0-1].concat($$[$0]);
break;
}
},
table: [{3:1,4:2,5:3,6:4,10:[1,5],11:9,13:6,19:7,24:[1,8],25:10,26:[1,13],27:[1,14],43:[1,11],53:[1,12]},{1:[3]},{1:[2,1],5:15,6:4,10:[1,5],11:9,13:6,19:7,24:[1,8],25:10,26:[1,13],27:[1,14],43:[1,11],53:[1,12]},{1:[2,2],10:[2,2],24:[2,2],26:[2,2],27:[2,2],43:[2,2],53:[2,2]},{7:[1,16],11:9,13:17,14:18,15:[1,19],16:[1,20],17:[1,21],18:[1,22],19:7,24:[1,8],25:10,26:[1,13],27:[1,14],43:[1,11],53:[1,12]},{11:23,43:[1,11],53:[1,12]},{7:[2,6],15:[2,6],16:[2,6],17:[2,6],18:[2,6],24:[2,6],26:[2,6],27:[2,6],43:[2,6],53:[2,6]},{7:[2,13],15:[2,13],16:[2,13],17:[2,13],18:[2,13],20:[1,24],23:25,24:[2,13],26:[2,13],27:[2,13],33:26,36:[1,27],37:[1,28],43:[2,13],53:[2,13]},{7:[2,17],15:[2,17],16:[2,17],17:[2,17],18:[2,17],20:[2,17],24:[2,17],26:[2,17],27:[2,17],36:[2,17],37:[2,17],43:[2,17],53:[2,17]},{7:[2,18],15:[2,18],16:[2,18],17:[2,18],18:[2,18],20:[2,18],24:[2,18],26:[2,18],27:[2,18],36:[2,18],37:[2,18],43:[2,18],53:[2,18]},{11:29,43:[1,11],53:[1,12]},{7:[2,68],15:[2,68],16:[2,68],17:[2,68],18:[2,68],20:[2,68],24:[2,68],26:[2,68],27:[2,68],29:[2,68],30:[2,68],31:[2,68],32:[2,68],36:[2,68],37:[2,68],43:[2,68],44:[2,68],45:[2,68],46:[2,68],47:[2,68],48:[2,68],49:[2,68],53:[2,68]},{7:[2,69],15:[2,69],16:[2,69],17:[2,69],18:[2,69],20:[2,69],24:[2,69],26:[2,69],27:[2,69],29:[2,69],30:[2,69],31:[2,69],32:[2,69],36:[2,69],37:[2,69],43:[2,69],44:[2,69],45:[2,69],46:[2,69],47:[2,69],48:[2,69],49:[2,69],53:[2,69]},{43:[2,20],53:[2,20]},{43:[2,21],53:[2,21]},{1:[2,3],10:[2,3],24:[2,3],26:[2,3],27:[2,3],43:[2,3],53:[2,3]},{8:30,9:[2,34],11:32,24:[1,33],38:31,39:[2,34],43:[1,11],53:[1,12]},{7:[2,7],15:[2,7],16:[2,7],17:[2,7],18:[2,7],24:[2,7],26:[2,7],27:[2,7],43:[2,7],53:[2,7]},{11:9,13:34,19:7,24:[1,8],25:10,26:[1,13],27:[1,14],43:[1,11],53:[1,12]},{11:9,13:35,19:7,24:[1,8],25:10,26:[1,13],27:[1,14],43:[1,11],53:[1,12]},{24:[2,10],26:[2,10],27:[2,10],43:[2,10],53:[2,10]},{24:[2,11],26:[2,11],27:[2,11],43:[2,11],53:[2,11]},{24:[2,12],26:[2,12],27:[2,12],43:[2,12],53:[2,12]},{12:36,24:[1,43],35:45,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46]},{11:48,21:47,43:[1,11],53:[1,12]},{7:[2,16],15:[2,16],16:[2,16],17:[2,16],18:[2,16],24:[2,16],26:[2,16],27:[2,16],43:[2,16],53:[2,16]},{11:50,34:49,35:51,43:[1,52],53:[1,53]},{43:[2,32],53:[2,32]},{43:[2,33],53:[2,33]},{7:[2,19],15:[2,19],16:[2,19],17:[2,19],18:[2,19],20:[2,19],24:[2,19],26:[2,19],27:[2,19],36:[2,19],37:[2,19],43:[2,19],53:[2,19]},{9:[1,54],39:[1,55]},{9:[2,35],39:[2,35]},{36:[1,56]},{11:57,43:[1,11],53:[1,12]},{7:[2,8],15:[2,8],16:[2,8],17:[2,8],18:[2,8],24:[2,8],26:[2,8],27:[2,8],43:[2,8],53:[2,8]},{7:[2,9],15:[2,9],16:[2,9],17:[2,9],18:[2,9],24:[2,9],26:[2,9],27:[2,9],43:[2,9],53:[2,9]},{1:[2,5],10:[2,5],24:[2,5],26:[2,5],27:[2,5],43:[2,5],53:[2,5]},{1:[2,46],9:[2,46],10:[2,46],15:[2,46],22:[2,46],24:[2,46],26:[2,46],27:[2,46],39:[2,46],43:[2,46],44:[2,46],45:[2,46],46:[2,46],47:[2,46],48:[2,46],49:[2,46],50:[1,58],52:[2,46],53:[2,46]},{1:[2,47],9:[2,47],10:[2,47],15:[2,47],22:[2,47],24:[2,47],26:[2,47],27:[2,47],39:[2,47],43:[2,47],44:[2,47],45:[2,47],46:[2,47],47:[2,47],48:[2,47],49:[2,47],52:[2,47],53:[2,47]},{1:[2,48],9:[2,48],10:[2,48],15:[2,48],22:[2,48],24:[2,48],26:[2,48],27:[2,48],39:[2,48],43:[2,48],44:[2,48],45:[2,48],46:[2,48],47:[2,48],48:[2,48],49:[2,48],52:[2,48],53:[2,48]},{1:[2,49],9:[2,49],10:[2,49],15:[2,49],22:[2,49],24:[2,49],26:[2,49],27:[2,49],39:[2,49],43:[2,49],44:[2,49],45:[2,49],46:[2,49],47:[2,49],48:[2,49],49:[2,49],52:[2,49],53:[2,49]},{1:[2,50],9:[2,50],10:[2,50],15:[2,50],22:[2,50],24:[2,50],26:[2,50],27:[2,50],39:[2,50],43:[2,50],44:[2,50],45:[2,50],46:[2,50],47:[2,50],48:[2,50],49:[2,50],52:[2,50],53:[2,50]},{1:[2,51],9:[2,51],10:[2,51],15:[2,51],22:[2,51],24:[2,51],26:[2,51],27:[2,51],39:[2,51],43:[2,51],44:[2,51],45:[2,51],46:[2,51],47:[2,51],48:[2,51],49:[2,51],52:[2,51],53:[2,51]},{1:[2,52],9:[2,52],10:[2,52],15:[2,52],22:[2,52],24:[2,52],26:[2,52],27:[2,52],39:[2,52],43:[2,52],44:[2,52],45:[2,52],46:[2,52],47:[2,52],48:[2,52],49:[2,52],52:[2,52],53:[2,52]},{1:[2,53],9:[2,53],10:[2,53],15:[2,53],22:[2,53],24:[2,53],26:[2,53],27:[2,53],39:[2,53],43:[2,53],44:[2,53],45:[2,53],46:[2,53],47:[2,53],48:[2,53],49:[2,53],52:[2,53],53:[2,53]},{1:[2,54],9:[2,54],10:[2,54],15:[2,54],22:[2,54],24:[2,54],26:[2,54],27:[2,54],39:[2,54],43:[2,54],44:[2,54],45:[2,54],46:[2,54],47:[2,54],48:[2,54],49:[2,54],52:[2,54],53:[2,54]},{50:[1,59]},{22:[1,60]},{18:[1,63],24:[1,67],28:61,29:[1,62],30:[1,64],31:[1,65],32:[1,66]},{7:[2,29],15:[2,29],16:[2,29],17:[2,29],18:[2,29],24:[2,29],26:[2,29],27:[2,29],43:[2,29],53:[2,29]},{7:[2,30],15:[2,30],16:[2,30],17:[2,30],18:[2,30],24:[2,30],26:[2,30],27:[2,30],43:[2,30],53:[2,30]},{7:[2,31],15:[2,31],16:[2,31],17:[2,31],18:[2,31],24:[2,31],26:[2,31],27:[2,31],43:[2,31],53:[2,31]},{7:[2,68],15:[2,68],16:[2,68],17:[2,68],18:[2,68],24:[2,68],26:[2,68],27:[2,68],43:[2,68],50:[1,58],53:[2,68]},{7:[2,69],15:[2,69],16:[2,69],17:[2,69],18:[2,69],24:[2,69],26:[2,69],27:[2,69],43:[2,69],50:[1,59],53:[2,69]},{1:[2,4],10:[2,4],24:[2,4],26:[2,4],27:[2,4],43:[2,4],53:[2,4]},{9:[2,37],11:32,24:[1,33],38:68,39:[2,37],43:[1,11],53:[1,12]},{12:71,24:[1,43],35:45,40:69,41:70,42:72,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46]},{36:[1,73]},{12:76,15:[2,70],24:[1,43],35:45,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],51:74,52:[2,70],53:[1,46],58:75,59:77},{27:[1,83],29:[1,86],36:[1,84],43:[1,81],44:[1,79],47:[1,88],48:[1,82],54:78,55:80,56:[1,85],57:[1,87]},{7:[2,14],15:[2,14],16:[2,14],17:[2,14],18:[2,14],23:89,24:[2,14],26:[2,14],27:[2,14],33:26,36:[1,27],37:[1,28],43:[2,14],53:[2,14]},{12:90,24:[1,43],35:45,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46]},{24:[2,23],43:[2,23],44:[2,23],45:[2,23],46:[2,23],47:[2,23],48:[2,23],49:[2,23],53:[2,23]},{29:[1,91]},{29:[1,92]},{29:[1,93]},{29:[1,94]},{29:[1,95]},{9:[2,36],39:[2,36]},{9:[2,38],12:71,24:[1,43],35:45,39:[2,38],41:96,42:72,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46]},{9:[2,40],24:[2,40],39:[2,40],43:[2,40],44:[2,40],45:[2,40],46:[2,40],47:[2,40],48:[2,40],49:[2,40],53:[2,40]},{9:[2,42],15:[1,97],24:[2,42],39:[2,42],43:[2,42],44:[2,42],45:[2,42],46:[2,42],47:[2,42],48:[2,42],49:[2,42],53:[2,42]},{9:[2,43],15:[1,98],24:[2,43],39:[2,43],43:[2,43],44:[2,43],45:[2,43],46:[2,43],47:[2,43],48:[2,43],49:[2,43],53:[2,43]},{12:71,24:[1,43],35:45,40:99,41:70,42:72,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46]},{15:[1,101],52:[1,100]},{15:[2,71],52:[2,71]},{12:102,15:[2,73],24:[1,43],35:45,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],52:[2,73],53:[1,46]},{12:103,15:[2,74],24:[1,43],35:45,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],52:[2,74],53:[1,46]},{27:[1,83],29:[1,86],36:[1,84],43:[1,81],47:[1,88],48:[1,82],52:[1,104],55:105,56:[1,85],57:[1,87]},{27:[2,57],29:[2,57],36:[2,57],43:[2,57],47:[2,57],48:[2,57],52:[2,57],56:[2,57],57:[2,57]},{27:[2,58],29:[2,58],36:[2,58],43:[2,58],47:[2,58],48:[2,58],52:[2,58],56:[2,58],57:[2,58]},{27:[2,60],29:[2,60],36:[2,60],43:[2,60],47:[2,60],48:[2,60],52:[2,60],56:[2,60],57:[2,60]},{27:[2,61],29:[2,61],36:[2,61],43:[2,61],47:[2,61],48:[2,61],52:[2,61],56:[2,61],57:[2,61]},{27:[2,62],29:[2,62],36:[2,62],43:[2,62],47:[2,62],48:[2,62],52:[2,62],56:[2,62],57:[2,62]},{27:[2,63],29:[2,63],36:[2,63],43:[2,63],47:[2,63],48:[2,63],52:[2,63],56:[2,63],57:[2,63]},{27:[2,64],29:[2,64],36:[2,64],43:[2,64],47:[2,64],48:[2,64],52:[2,64],56:[2,64],57:[2,64]},{27:[2,65],29:[2,65],36:[2,65],43:[2,65],47:[2,65],48:[2,65],52:[2,65],56:[2,65],57:[2,65]},{27:[2,66],29:[2,66],36:[2,66],43:[2,66],47:[2,66],48:[2,66],52:[2,66],56:[2,66],57:[2,66]},{27:[2,67],29:[2,67],36:[2,67],43:[2,67],47:[2,67],48:[2,67],52:[2,67],56:[2,67],57:[2,67]},{7:[2,15],15:[2,15],16:[2,15],17:[2,15],18:[2,15],24:[2,15],26:[2,15],27:[2,15],43:[2,15],53:[2,15]},{22:[2,22]},{24:[2,24],43:[2,24],44:[2,24],45:[2,24],46:[2,24],47:[2,24],48:[2,24],49:[2,24],53:[2,24]},{24:[2,25],43:[2,25],44:[2,25],45:[2,25],46:[2,25],47:[2,25],48:[2,25],49:[2,25],53:[2,25]},{24:[2,26],43:[2,26],44:[2,26],45:[2,26],46:[2,26],47:[2,26],48:[2,26],49:[2,26],53:[2,26]},{24:[2,27],43:[2,27],44:[2,27],45:[2,27],46:[2,27],47:[2,27],48:[2,27],49:[2,27],53:[2,27]},{24:[2,28],43:[2,28],44:[2,28],45:[2,28],46:[2,28],47:[2,28],48:[2,28],49:[2,28],53:[2,28]},{9:[2,41],24:[2,41],39:[2,41],43:[2,41],44:[2,41],45:[2,41],46:[2,41],47:[2,41],48:[2,41],49:[2,41],53:[2,41]},{12:106,24:[1,43],35:45,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46]},{12:107,24:[1,43],35:45,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46]},{9:[2,39],12:71,24:[1,43],35:45,39:[2,39],41:96,42:72,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46]},{1:[2,55],7:[2,55],9:[2,55],10:[2,55],15:[2,55],16:[2,55],17:[2,55],18:[2,55],22:[2,55],24:[2,55],26:[2,55],27:[2,55],39:[2,55],43:[2,55],44:[2,55],45:[2,55],46:[2,55],47:[2,55],48:[2,55],49:[2,55],52:[2,55],53:[2,55]},{12:76,24:[1,43],35:45,43:[1,37],44:[1,38],45:[1,39],46:[1,40],47:[1,41],48:[1,42],49:[1,44],53:[1,46],58:108,59:77},{15:[2,75],24:[2,75],43:[2,75],44:[2,75],45:[2,75],46:[2,75],47:[2,75],48:[2,75],49:[2,75],52:[2,75],53:[2,75]},{15:[2,76],24:[2,76],43:[2,76],44:[2,76],45:[2,76],46:[2,76],47:[2,76],48:[2,76],49:[2,76],52:[2,76],53:[2,76]},{1:[2,56],7:[2,56],9:[2,56],10:[2,56],15:[2,56],16:[2,56],17:[2,56],18:[2,56],22:[2,56],24:[2,56],26:[2,56],27:[2,56],39:[2,56],43:[2,56],44:[2,56],45:[2,56],46:[2,56],47:[2,56],48:[2,56],49:[2,56],52:[2,56],53:[2,56]},{27:[2,59],29:[2,59],36:[2,59],43:[2,59],47:[2,59],48:[2,59],52:[2,59],56:[2,59],57:[2,59]},{9:[2,44],15:[2,44],24:[2,44],39:[2,44],43:[2,44],44:[2,44],45:[2,44],46:[2,44],47:[2,44],48:[2,44],49:[2,44],53:[2,44]},{9:[2,45],15:[2,45],24:[2,45],39:[2,45],43:[2,45],44:[2,45],45:[2,45],46:[2,45],47:[2,45],48:[2,45],49:[2,45],53:[2,45]},{15:[2,72],52:[2,72]}],
defaultActions: {90:[2,22]},
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
case 0:return 53;
break;
case 1:return 43;
break;
case 2:return 44;
break;
case 3:return 45
break;
case 4:return 46
break;
case 5:return 46
break;
case 6:return 47
break;
case 7:return 47
break;
case 8:/* skip whitespaces */
break;
case 9:/* skip comments */
break;
case 10:return 10;
break;
case 11:return 32;
break;
case 12:return 17;
break;
case 13:return 7;
break;
case 14:return 9;
break;
case 15:return 50;
break;
case 16:return 52;
break;
case 17:return 20;
break;
case 18:return 22;
break;
case 19:return '<';
break;
case 20:return 16;
break;
case 21:return 31;
break;
case 22:return 56;
break;
case 23:return 57;
break;
case 24:return 49;
break;
case 25:return 18;
break;
case 26:return 29;
break;
case 27:return '-';
break;
case 28:return 30;
break;
case 29:return 26;
break;
case 30:return 27;
break;
case 31:return 37;
break;
case 32:return 36;
break;
case 33:return 39;
break;
case 34:return 24;
break;
case 35:return '';
break;
case 36:return 48;
break;
case 37:return 15;
break;
}
};
lexer.rules = [/^url/,/^[a-zA-Z_-][a-zA-Z0-9_-]*/,/^("[^"]*"|'[^']*')/,/^#([0-9a-fA-F]+)\b/,/^-?\d+(\.\d+)?(%|in|cm|mm|em|ex|pt|pc|px)/,/^-?\.\d+(%|in|cm|mm|em|ex|pt|pc|px)/,/^-?\d+(\.\d+)?/,/^-?\.\d+/,/^\s+/,/^\/\*.*?\*\//,/^\@/,/^\$/,/^\+/,/^\{/,/^\}/,/^\(/,/^\)/,/^\[/,/^\]/,/^\</,/^\>/,/^\^/,/^\?/,/^\&/,/^\!/,/^\~/,/^=/,/^\-/,/^\|/,/^\#/,/^\./,/^::/,/^:/,/^;/,/^\*/,/^\\/,/^\//,/^,/];
lexer.conditions = {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37],"inclusive":true}};return lexer;})()
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
}(function() {
  var AttributeNode, AttributeSelectorNode, CssAST, FunctionNode, LiteralNode, MetaNode, MetaSelectorNode, MultiLiteral, RuleNode, RulesNode, SelectorNode, collectStrings;
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
        this.rules = rules;
      }
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
      function RuleNode(selectors, attributes) {
        this.selectors = selectors;
        this.attributes = attributes;
      }
      RuleNode.prototype.selectorsString = function() {
        return collectStrings(this.selectors).join(" , ");
      };
      RuleNode.prototype.attributesString = function() {
        return collectStrings(this.attributes).join("; ");
      };
      RuleNode.prototype.string = function() {
        return "" + (this.selectorsString()) + " { " + (this.attributesString()) + " }";
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
      }
      SelectorNode.prototype.nestSelector = function(selector, rule) {
        if (rule == null) {
          rule = " ";
        }
        if (this.next) {
          this.next.nestSelector.call(this.next, selector, rule);
        } else {
          this.next = selector;
          this.nextRule = rule;
        }
        return this;
      };
      SelectorNode.prototype.nextString = function() {
        if (this.next) {
          return " " + this.nextRule + " " + (this.next.string());
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
    MultiLiteral: MultiLiteral = (function() {
      function MultiLiteral(literals, separator) {
        this.literals = literals;
        this.separator = separator;
      }
      MultiLiteral.prototype.string = function() {
        return collectStrings(this.literals).join(this.separator);
      };
      return MultiLiteral;
    })()
  };
  if (typeof window != "undefined" && window !== null) {
    window.CssAST = CssAST;
  }
  if (typeof module != "undefined" && module !== null) {
    module.exports = CssAST;
  }
}).call(this);
