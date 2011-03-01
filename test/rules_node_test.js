(function() {
  var AST, parser;
  parser = ScriptedCss.CssParser;
  AST = CssAST;
  module("Rule Node");
  test("test spliting meta things from real rules", function() {
    var css;
    css = parser.parse("@media screen body { background: red; } @media print body { background: white } p { color: #000 }");
    return equals(css.metaRules.length, 2);
  });
  test("test indexing attributes", function() {
    var css;
    css = parser.parse("body {background: #000; display: block} div {display: \"aa\" \"bc\";}");
    equals(css.attribute("display").length, 2);
    same(css.attribute("display")[0].value(), "block");
    equals(css.attribute("background").length, 1);
    return equals(css.attribute("font").length, 0);
  });
  test("test merging rules attributes", function() {
    var css;
    css = parser.parse("body {background: #000; display: block} body {display: inline; color: #fff}");
    same(css.attribute("display").length, 1);
    same(css.elementRules["body"].attributes.get("background").value(), "#000");
    same(css.elementRules["body"].attributes.get("display").value(), "inline");
    return same(css.elementRules["body"].attributes.get("color").value(), "#fff");
  });
  test("test selector index", function() {
    var css;
    css = parser.parse("body div {background: #000; display: block} p.test {} .test.other {} #header {} div:nth-child(2) {display: block}");
    same(css.selectorIndex["DIV"][0].selector.string(), "body div");
    same(css.selectorIndex["DIV"][1].selector.string(), "div:nth-child(2)");
    same(css.selectorIndex[".test"][0].selector.string(), "p.test");
    same(css.selectorIndex[".test"][1].selector.string(), ".test.other");
    same(css.selectorIndex[".other"][0].selector.string(), ".test.other");
    return same(css.selectorIndex["#header"][0].selector.string(), "#header");
  });
}).call(this);
