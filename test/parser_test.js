(function() {
  var ast, parser;
  parser = ScriptedCss.CssParser;
  ast = CssAST;
  module("Parser");
  test("test it parsing metadata", function() {
    var css;
    css = parser.parse("@media screen");
    same(css.rules[0].name, "media");
    return same(css.rules[0].value.string(), "screen");
  });
  test("test it parsing complex metadata", function() {
    var css;
    css = parser.parse("@font-face { font-family: 'scarface'; src: url(scarface-webfont.eot); src: local('scarface'), url('scarface-webfont.ttf') format('truetype'); }");
    same(css.rules[0].name, "font-face");
    same(css.rules[0].value.items[0].name, "font-family");
    same(css.rules[0].value.items[0].value(), "'scarface'");
    same(css.rules[0].value.items[1].name, "src");
    same(css.rules[0].value.items[1].value(), "url('scarface-webfont.eot')");
    same(css.rules[0].value.items[2].name, "src");
    return same(css.rules[0].value.items[2].value(), "local('scarface'), url('scarface-webfont.ttf') format('truetype')");
  });
  test("test it parsing simple selector", function() {
    var css;
    css = parser.parse("body {}");
    return same(css.rules[0].selector.string(), "body");
  });
  test("test parsing id selector", function() {
    var css;
    css = parser.parse("#body {}");
    return same(css.rules[0].selector.string(), "#body");
  });
  test("test parsing class selector", function() {
    var css;
    css = parser.parse(".body {}");
    return same(css.rules[0].selector.string(), ".body");
  });
  test("test it parsing multiple selectors", function() {
    var css;
    css = parser.parse("body, div { background-color: black }");
    same(css.rules[0].selector.string(), "body");
    same(css.rules[1].selector.string(), "div");
    same(css.rules[0].attributes.string(), "{ background-color: black }");
    return same(css.rules[1].attributes.string(), "{ background-color: black }");
  });
  test("test compound selections", function() {
    var css;
    css = parser.parse("div#hello.some.thing, other {}");
    same(css.rules[0].selector.string(), "div#hello.some.thing");
    return same(css.rules[1].selector.string(), "other");
  });
  test("test it should mix correctly multiple and compound", function() {
    var css;
    css = parser.parse("#menu body, ul > li {}");
    same(css.rules[0].selector.selector, "#menu");
    same(css.rules[0].selector.next.selector, "body");
    same(css.rules[0].selector.nextRule, " ");
    same(css.rules[1].selector.selector, "ul");
    same(css.rules[1].selector.next.selector, "li");
    return same(css.rules[1].selector.nextRule, ">");
  });
  test("test it parsing compound rules", function() {
    var css, sep, separators, _i, _len, _results;
    separators = [" ", ">", "+", "~"];
    _results = [];
    for (_i = 0, _len = separators.length; _i < _len; _i++) {
      sep = separators[_i];
      css = parser.parse("body " + sep + " div {}");
      same(css.rules[0].selector.selector, "body");
      same(css.rules[0].selector.next.selector, "div");
      _results.push(same(css.rules[0].selector.nextRule, sep));
    }
    return _results;
  });
  test("test it parsing compound multiple", function() {
    var css, sep, separators, _i, _len, _results;
    separators = [">", "+", "~"];
    _results = [];
    for (_i = 0, _len = separators.length; _i < _len; _i++) {
      sep = separators[_i];
      css = parser.parse("body " + sep + " div " + sep + " p {}");
      same(css.rules[0].selector.selector, "body");
      same(css.rules[0].selector.next.selector, "div");
      same(css.rules[0].selector.nextRule, sep);
      same(css.rules[0].selector.next.next.selector, "p");
      _results.push(same(css.rules[0].selector.next.nextRule, sep));
    }
    return _results;
  });
  test("test it split multiple rules", function() {
    var css;
    css = parser.parse("body, div {}");
    same(css.rules[0].selector.selector, "body");
    return same(css.rules[1].selector.selector, "div");
  });
  test("test it parsing attribute selectors", function() {
    var attr, css, op, operators, _i, _len, _results;
    operators = ["=", "~=", "|=", "^=", "$=", "*="];
    _results = [];
    for (_i = 0, _len = operators.length; _i < _len; _i++) {
      op = operators[_i];
      css = parser.parse("input[type" + op + "text] {}");
      attr = css.rules[0].selector.attributes;
      same(attr.name, "type");
      same(attr.operator, op);
      _results.push(same(attr.value.value, "text"));
    }
    return _results;
  });
  test("test it parsing simple metaselector", function() {
    var css;
    css = parser.parse("body:before {}");
    same(css.rules[0].selector.selector, "body");
    return same(css.rules[0].selector.meta.string(), ":before");
  });
  test("test it parsing metaselector", function() {
    var css;
    css = parser.parse("body::slot(a) {}");
    same(css.rules[0].selector.selector, "body");
    return same(css.rules[0].selector.meta.string(), "::slot(a)");
  });
  test("test it parsing meta selector without tag", function() {
    var css;
    css = parser.parse(":focus {}");
    same(css.rules[0].selector.selector, "*");
    return same(css.rules[0].selector.meta.string(), ":focus");
  });
  test("test it parsing selector with a meta selector as nested one", function() {
    var css;
    css = parser.parse("body :focus {}");
    same(css.rules[0].selector.selector, "body");
    same(css.rules[0].selector.next.selector, "*");
    return same(css.rules[0].selector.next.meta.string(), ":focus");
  });
  test("test simple attribute", function() {
    var css;
    css = parser.parse("body {color: #fff}");
    same(css.rules[0].attributes.items[0].name, "color");
    return same(css.rules[0].attributes.items[0].value(), "#fff");
  });
  test("test attributes hash", function() {
    var css;
    css = parser.parse("body {color: #fff; display: none; color: #000;}");
    same(css.rules[0].attributes.hash["color"].value(), "#000");
    return same(css.rules[0].attributes.hash["display"].value(), "none");
  });
  test("test multiple values", function() {
    var css;
    css = parser.parse("body {background-color: #fff; color: #000;}");
    same(css.rules[0].attributes.items[0].name, "background-color");
    same(css.rules[0].attributes.items[0].value(), "#fff");
    same(css.rules[0].attributes.items[1].name, "color");
    return same(css.rules[0].attributes.items[1].value(), "#000");
  });
  test("test unit value", function() {
    var css;
    css = parser.parse("body {margin: 10px;}");
    same(css.rules[0].attributes.items[0].value(), "10px");
    same(css.rules[0].attributes.items[0].values[0].number, 10);
    return same(css.rules[0].attributes.items[0].values[0].unit, "px");
  });
  test("test identifier value", function() {
    var css;
    css = parser.parse("body {color: white;}");
    return same(css.rules[0].attributes.items[0].value(), "white");
  });
  test("test string value", function() {
    var css;
    css = parser.parse("body {font-family: 'Times New Roman';}");
    same(css.rules[0].attributes.items[0].value(), "'Times New Roman'");
    return same(css.rules[0].attributes.items[0].values[0].text, "Times New Roman");
  });
  test("test 3 digit hex number value", function() {
    var css;
    css = parser.parse("body {color: #f00;}");
    return same(css.rules[0].attributes.items[0].value(), "#f00");
  });
  test("test 6 digit hex number value", function() {
    var css;
    css = parser.parse("body {color: #f00f12;}");
    return same(css.rules[0].attributes.items[0].value(), "#f00f12");
  });
  test("test number value", function() {
    var css;
    css = parser.parse("body {margin: 0;}");
    return same(css.rules[0].attributes.items[0].value(), "0");
  });
  test("test unit number value", function() {
    var css;
    css = parser.parse("body {margin: 10px;}");
    return same(css.rules[0].attributes.items[0].value(), "10px");
  });
  test("test function value", function() {
    var css;
    css = parser.parse("body {margin: minmax(100px, 200px);}");
    same(css.rules[0].attributes.items[0].values[0].name, "minmax");
    return same(css.rules[0].attributes.items[0].values[0].argumentsString(), "100px,200px");
  });
  test("test function with multi-item params", function() {
    var css;
    css = parser.parse("body {background-image: gradient(linear, left top, left bottom);}");
    same(css.rules[0].attributes.items[0].values[0].name, "gradient");
    same(css.rules[0].attributes.items[0].values[0].arguments[0].string(), "linear");
    same(css.rules[0].attributes.items[0].values[0].arguments[1].string(), "left top");
    return same(css.rules[0].attributes.items[0].values[0].arguments[2].string(), "left bottom");
  });
  test("test IE filter function", function() {
    var css;
    css = parser.parse("body {filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#f4f4f4',endColorstr='#ececec');}");
    same(css.rules[0].attributes.items[0].values[0].name, "progid:DXImageTransform.Microsoft.gradient");
    same(css.rules[0].attributes.items[0].values[0].namedArguments["GradientType"].string(), "0");
    same(css.rules[0].attributes.items[0].values[0].namedArguments["startColorstr"].string(), "'#f4f4f4'");
    return same(css.rules[0].attributes.items[0].values[0].namedArguments["endColorstr"].string(), "'#ececec'");
  });
  test("test url function", function() {
    var css;
    css = parser.parse("body {background-image: url(../testing/file.png)}");
    same(css.rules[0].attributes.items[0].values[0].name, "url");
    return same(css.rules[0].attributes.items[0].values[0].argumentsString(), "'../testing/file.png'");
  });
  test("test full complex attribute", function() {
    var css;
    css = parser.parse("body {display: 'aaa' / 20px 'bcc' 100px * minmax(80px, 120px);}");
    return same(css.rules[0].attributes.items[0].value(), "'aaa' / 20px 'bcc' 100px * minmax(80px,120px)");
  });
  test("test multi-item value", function() {
    var css;
    css = parser.parse("body {display: a, b, c d;}");
    same(css.rules[0].attributes.items[0].values[0].string(), "a, b, c");
    return same(css.rules[0].attributes.items[0].values[1].string(), "d");
  });
  test("test selector generating string", function() {
    var selector;
    selector = new ast.SelectorNode("body");
    selector.nestSelector(new ast.SelectorNode("p", new ast.AttributeSelectorNode("type", "=", new ast.LiteralNode("text")), new ast.MetaSelectorNode(new ast.LiteralNode("before"), ":")), ">");
    return same(selector.string(), "body > p[type=text]:before");
  });
}).call(this);
