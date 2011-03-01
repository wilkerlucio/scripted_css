(function() {
  var parser, testAddedAttributes, testExpansion;
  module("Module - Border Radius");
  parser = ScriptedCss.CssParser;
  testExpansion = function(attr, expected) {
    var css, i, item, _len, _results;
    css = parser.parse("* {" + attr + "}");
    attr = css.rules[0].attributes;
    _results = [];
    for (i = 0, _len = expected.length; i < _len; i++) {
      item = expected[i];
      same(attr.items[i].name, item[0]);
      _results.push(same(attr.items[i].value(), item[1]));
    }
    return _results;
  };
  testAddedAttributes = function(attr, expected, step) {
    var css, i, item, _len, _results;
    if (step == null) {
      step = 1;
    }
    css = parser.parse("* {" + attr + "}");
    ScriptedCss.trigger("scriptLoaded", css);
    attr = css.rules[0].attributes;
    console.log(attr);
    _results = [];
    for (i = 0, _len = expected.length; i < _len; i++) {
      item = expected[i];
      same(attr.items[i + step].name, item[0]);
      _results.push(same(attr.items[i + step].value(), item[1]));
    }
    return _results;
  };
  test("test expanding border radius with one value", function() {
    return testExpansion("border-radius: 10px", [["border-top-left-radius", "10px"], ["border-top-right-radius", "10px"], ["border-bottom-right-radius", "10px"], ["border-bottom-left-radius", "10px"]]);
  });
  test("test expanding border radius with two values", function() {
    return testExpansion("border-radius: 10px 5px", [["border-top-left-radius", "10px"], ["border-top-right-radius", "5px"], ["border-bottom-right-radius", "10px"], ["border-bottom-left-radius", "5px"]]);
  });
  test("test expanding border radius with three values", function() {
    return testExpansion("border-radius: 10px 5px 8px", [["border-top-left-radius", "10px"], ["border-top-right-radius", "5px"], ["border-bottom-right-radius", "8px"], ["border-bottom-left-radius", "5px"]]);
  });
  test("test expanding border radius with four values", function() {
    return testExpansion("border-radius: 10px 5px 8px 2px", [["border-top-left-radius", "10px"], ["border-top-right-radius", "5px"], ["border-bottom-right-radius", "8px"], ["border-bottom-left-radius", "2px"]]);
  });
  test("test expanding border radius with one second value", function() {
    return testExpansion("border-radius: 10px / 5px", [["border-top-left-radius", "10px 5px"], ["border-top-right-radius", "10px 5px"], ["border-bottom-right-radius", "10px 5px"], ["border-bottom-left-radius", "10px 5px"]]);
  });
  test("test expanding border radius with two second values", function() {
    return testExpansion("border-radius: 10px / 5px 8px", [["border-top-left-radius", "10px 5px"], ["border-top-right-radius", "10px 8px"], ["border-bottom-right-radius", "10px 5px"], ["border-bottom-left-radius", "10px 8px"]]);
  });
  test("test expanding border radius with three second values", function() {
    return testExpansion("border-radius: 10px / 5px 8px 4px", [["border-top-left-radius", "10px 5px"], ["border-top-right-radius", "10px 8px"], ["border-bottom-right-radius", "10px 4px"], ["border-bottom-left-radius", "10px 8px"]]);
  });
  test("test expanding border radius with four second values", function() {
    return testExpansion("border-radius: 10px / 5px 8px 4px 6px", [["border-top-left-radius", "10px 5px"], ["border-top-right-radius", "10px 8px"], ["border-bottom-right-radius", "10px 4px"], ["border-bottom-left-radius", "10px 6px"]]);
  });
  test("adding browser specific rounded borders for top left", function() {
    return testAddedAttributes("border-top-left-radius: 5px", [["-moz-border-radius-topleft", "5px"], ["-webkit-border-top-left-radius", "5px"]]);
  });
  test("adding browser specific rounded borders for top right", function() {
    return testAddedAttributes("border-top-right-radius: 5px", [["-moz-border-radius-topright", "5px"], ["-webkit-border-top-right-radius", "5px"]]);
  });
  test("adding browser specific rounded borders for bottom right", function() {
    return testAddedAttributes("border-bottom-right-radius: 5px", [["-moz-border-radius-bottomright", "5px"], ["-webkit-border-bottom-right-radius", "5px"]]);
  });
  test("adding browser specific rounded borders for bottom left", function() {
    return testAddedAttributes("border-bottom-left-radius: 5px", [["-moz-border-radius-bottomleft", "5px"], ["-webkit-border-bottom-left-radius", "5px"]]);
  });
}).call(this);
