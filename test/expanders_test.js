(function() {
  var attribute, direction, parser, testExpansion, testImplosion, _fn, _fn2, _i, _j, _len, _len2, _ref, _ref2;
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
    testExpansion("background: #000 url('test.gif') no-repeat fixed center", [["background-attachment", "fixed"], ["background-color", "#000"], ["background-image", "url('test.gif')"], ["background-position", "center"], ["background-repeat", "no-repeat"]]);
    return testExpansion("background: transparent", [["background-attachment", "scroll"], ["background-color", "transparent"], ["background-image", "none"], ["background-position", "0 0"], ["background-repeat", "repeat"]]);
  });
  test("test imploding background", function() {
    return testImplosion("background-color: #000; background-image: url('some.png'); background-repeat: repeat-x", ["background", "#000 url('some.png') repeat-x"]);
  });
  test("test expanding border", function() {
    return testExpansion("border: 1px solid #000", [["border-top-color", "#000"], ["border-top-style", "solid"], ["border-top-width", "1px"], ["border-right-color", "#000"], ["border-right-style", "solid"], ["border-right-width", "1px"], ["border-bottom-color", "#000"], ["border-bottom-style", "solid"], ["border-bottom-width", "1px"], ["border-left-color", "#000"], ["border-left-style", "solid"], ["border-left-width", "1px"]]);
  });
  _ref = ["top", "right", "bottom", "left"];
  _fn = function() {
    var dir;
    dir = direction;
    return test("test expanding border-" + dir, function() {
      testExpansion("border-" + dir + ": 1px solid #000", [["border-" + dir + "-color", "#000"], ["border-" + dir + "-style", "solid"], ["border-" + dir + "-width", "1px"]]);
      return testExpansion("border-" + dir + ": none", [["border-" + dir + "-color", ""], ["border-" + dir + "-style", "none"], ["border-" + dir + "-width", "medium"]]);
    });
  };
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    direction = _ref[_i];
    _fn();
  }
  _ref2 = ["margin", "padding"];
  _fn2 = function() {
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
  for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
    attribute = _ref2[_j];
    _fn2();
  }
  test("expanding list-style", function() {
    testExpansion("list-style: square inside url('/images/blueball.gif');", [["list-style-image", "url('/images/blueball.gif')"], ["list-style-position", "inside"], ["list-style-type", "square"]]);
    return testExpansion("list-style: none;", [["list-style-image", "none"], ["list-style-position", "outside"], ["list-style-type", "none"]]);
  });
  test("expanding outline", function() {
    testExpansion("outline: #00ff00 dotted thick", [["outline-color", "#00ff00"], ["outline-style", "dotted"], ["outline-width", "thick"]]);
    return testExpansion("outline: none", [["outline-color", "invert"], ["outline-style", "none"], ["outline-width", "medium"]]);
  });
  test("expanding font", function() {
    testExpansion("font: italic bold 12px/30px Georgia, serif", [["font-family", "Georgia, serif"], ["font-size", "12px"], ["line-height", "30px"], ["font-style", "italic"], ["font-variant", "normal"], ["font-weight", "bold"]]);
    return testExpansion("font: 'Courier New', Georgia, serif;", [["font-family", "'Courier New', Georgia, serif"], ["font-size", "medium"], ["font-style", "normal"], ["font-variant", "normal"], ["font-weight", "normal"]]);
  });
}).call(this);
