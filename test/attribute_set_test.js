(function() {
  var ast, parser;
  parser = ScriptedCss.CssParser;
  ast = CssAST;
  module("Attribute Set");
  test("test initializing attributes", function() {
    var attributes, css;
    css = parser.parse("body { margin-top: 10px }");
    attributes = css.rules[0].attributes;
    same(attributes.items[0].name, "margin-top");
    same(attributes.items[0].value(), "10px");
    return same(attributes.hash["margin-top"].name, "margin-top");
  });
  test("test expanding attributes", function() {
    var attributes, css;
    ast.AttributeSet.registerExpansion("expansion-test", {
      explode: function(attribute) {
        var direction, exploded, values, _i, _len, _ref;
        values = attribute.values;
        exploded = [];
        _ref = ["top", "right", "bottom", "left"];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          direction = _ref[_i];
          exploded.push(new ast.AttributeNode("" + attribute.name + "-" + direction, values));
        }
        return exploded;
      },
      implode: function(attributes, property) {
        return attributes.get("" + property + "-top");
      }
    });
    css = parser.parse("body { expansion-test: 10px }");
    attributes = css.rules[0].attributes;
    same(attributes.items.length, 4);
    same(attributes.items[0].name, "expansion-test-top");
    same(attributes.items[0].value(), "10px");
    same(attributes.items[1].name, "expansion-test-right");
    same(attributes.items[1].value(), "10px");
    same(attributes.items[2].name, "expansion-test-bottom");
    same(attributes.items[2].value(), "10px");
    same(attributes.items[3].name, "expansion-test-left");
    same(attributes.items[3].value(), "10px");
    same(attributes.hash['expansion-test-top'].value(), "10px");
    same(attributes.hash['expansion-test-right'].value(), "10px");
    same(attributes.hash['expansion-test-bottom'].value(), "10px");
    same(attributes.hash['expansion-test-left'].value(), "10px");
    return same(attributes.get("expansion-test").value(), "10px");
  });
}).call(this);
