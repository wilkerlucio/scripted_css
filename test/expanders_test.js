(function() {
  var attribute, parser, testExpansion, testImplosion, _fn, _i, _len, _ref;
  module("Common Expansions");
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
  testImplosion = function(attrs, expected) {
    var attr, css;
    css = parser.parse("* {" + attrs + "}");
    attr = css.rules[0].attributes;
    return same(attr.get(expected[0]).value(), expected[1]);
  };
  test("test expanding background", function() {
    return testExpansion("background: #000 url('test.gif') no-repeat fixed center", [["background-attachment", "fixed"], ["background-color", "#000"], ["background-image", "url('test.gif')"], ["background-position", "center"], ["background-repeat", "no-repeat"]]);
  });
  test("test imploding background", function() {
    return testImplosion("background-color: #000; background-image: url('some.png'); background-repeat: repeat-x", ["background", "#000 url('some.png') repeat-x"]);
  });
  test("test expanding border", function() {
    return testExpansion("border: 1px solid #000", [["border-top-color", "#000"], ["border-top-style", "solid"], ["border-top-width", "1px"], ["border-right-color", "#000"], ["border-right-style", "solid"], ["border-right-width", "1px"], ["border-bottom-color", "#000"], ["border-bottom-style", "solid"], ["border-bottom-width", "1px"], ["border-left-color", "#000"], ["border-left-style", "solid"], ["border-left-width", "1px"]]);
  });
  _ref = ["margin", "padding"];
  _fn = function() {
    var attr;
    attr = attribute;
    test("test expanding " + attr + " with 1 value", function() {
      return testExpansion("" + attr + ": 10px", [["" + attr + "-top", "10px"], ["" + attr + "-right", "10px"], ["" + attr + "-bottom", "10px"], ["" + attr + "-left", "10px"]]);
    });
    test("test expanding " + attr + " with 2 values", function() {
      return testExpansion("" + attr + ": 10px 8px", [["" + attr + "-top", "10px"], ["" + attr + "-right", "8px"], ["" + attr + "-bottom", "10px"], ["" + attr + "-left", "8px"]]);
    });
    test("test expanding " + attr + " with 3 values", function() {
      return testExpansion("" + attr + ": 10px 8px 6px", [["" + attr + "-top", "10px"], ["" + attr + "-right", "8px"], ["" + attr + "-bottom", "6px"], ["" + attr + "-left", "8px"]]);
    });
    return test("test expanding " + attr + " with 4 values", function() {
      return testExpansion("" + attr + ": 10px 8px 6px 4px", [["" + attr + "-top", "10px"], ["" + attr + "-right", "8px"], ["" + attr + "-bottom", "6px"], ["" + attr + "-left", "4px"]]);
    });
  };
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    attribute = _ref[_i];
    _fn();
  }
}).call(this);
