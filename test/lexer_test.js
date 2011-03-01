(function() {
  var Lexer, operator, sep, separators, _fn, _fn2, _i, _j, _len, _len2, _ref;
  Lexer = ScriptedCss.CssParser.Lexer;
  module("Lexer");
  test("test simple identifier", function() {
    var tokens;
    tokens = Lexer.tokenize("body");
    return same(tokens, [["IDENTIFIER", "body", 0]], "");
  });
  test("test skip comments", function() {
    var tokens;
    tokens = Lexer.tokenize("    /* some comment * here */\n    @media screen  ");
    return same(tokens, [["@", "@", 1], ["IDENTIFIER", "media", 1], ["IDENTIFIER", "screen", 1]]);
  });
  test("test skip multiline comments", function() {
    var tokens;
    tokens = Lexer.tokenize("    /*\n      some multiline\n      comment * /\n      here\n    */\n    @media screen  ");
    return same(tokens, [["@", "@", 5], ["IDENTIFIER", "media", 5], ["IDENTIFIER", "screen", 5]]);
  });
  test("test lexing selectors", function() {
    var tokens;
    tokens = Lexer.tokenize("div.some#id");
    return same(tokens, [["IDENTIFIER", "div.some#id", 0]]);
  });
  test("test some chain", function() {
    var tokens;
    tokens = Lexer.tokenize("* html .clearfix{height:1%;}");
    return same(tokens, [["IDENTIFIER", "*", 0], ["SELECTOR_OPERATOR", " ", 0], ["IDENTIFIER", "html", 0], ["SELECTOR_OPERATOR", " ", 0], ["IDENTIFIER", ".clearfix", 0], ["{", "{", 0], ["IDENTIFIER", "height", 0], [":", ":", 0], ["UNITNUMBER", "1%", 0], [";", ";", 0], ["}", "}", 0]]);
  });
  test("some tabs", function() {
    var tokens;
    tokens = Lexer.tokenize("\t\t\t#top     { position: a; }");
    return same(tokens, [["IDENTIFIER", "#top", 0], ["{", "{", 0], ["IDENTIFIER", "position", 0], [":", ":", 0], ["IDENTIFIER", "a", 0], [";", ";", 0], ["}", "}", 0]]);
  });
  separators = [' ', '+', ">", "~"];
  _fn = function() {
    var separator;
    separator = sep;
    return test("test lexing selector '" + separator + "' separator", function() {
      var tokens;
      tokens = Lexer.tokenize("body " + separator + " div , p");
      same(tokens[0][0], "IDENTIFIER");
      same(tokens[1][0], "SELECTOR_OPERATOR");
      same(tokens[1][1], separator);
      same(tokens[2][0], "IDENTIFIER");
      same(tokens[3][0], ",");
      return same(tokens[4][0], "IDENTIFIER");
    });
  };
  for (_i = 0, _len = separators.length; _i < _len; _i++) {
    sep = separators[_i];
    _fn();
  }
  _ref = ["=", "~=", "|=", "^=", "$=", "*="];
  _fn2 = function() {
    var op;
    op = operator;
    return test("test lexing selector attributes " + op, function() {
      var tokens;
      tokens = Lexer.tokenize("input[type" + op + "text] {}");
      return same(tokens, [["IDENTIFIER", "input", 0], ["[", "[", 0], ["IDENTIFIER", "type", 0], [op, op, 0], ["IDENTIFIER", "text", 0], ["]", "]", 0], ["{", "{", 0], ["}", "}", 0]]);
    });
  };
  for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
    operator = _ref[_j];
    _fn2();
  }
  test("test lexing meta selector without params", function() {
    var tokens;
    tokens = Lexer.tokenize("input:focus");
    return same(tokens, [["IDENTIFIER", "input", 0], [":", ":", 0], ["IDENTIFIER", "focus", 0]]);
  });
  test("test lexing meta selector with double colons", function() {
    var tokens;
    tokens = Lexer.tokenize("input::focus");
    return same(tokens, [["IDENTIFIER", "input", 0], ["::", "::", 0], ["IDENTIFIER", "focus", 0]]);
  });
  test("test lexing meta selector with params", function() {
    var tokens;
    tokens = Lexer.tokenize("field:custom(some , things) div");
    return same(tokens, [["IDENTIFIER", "field", 0], [":", ":", 0], ["IDENTIFIER", "custom", 0], ["(", "(", 0], ["IDENTIFIER", "some", 0], [",", ",", 0], ["IDENTIFIER", "things", 0], [")", ")", 0], ["SELECTOR_OPERATOR", " ", 0], ["IDENTIFIER", "div", 0]]);
  });
  test("test lexing basic attribute", function() {
    var tokens;
    tokens = Lexer.tokenize("{ margin-top: 10px }");
    return same(tokens, [["{", "{", 0], ["IDENTIFIER", "margin-top", 0], [":", ":", 0], ["UNITNUMBER", "10px", 0], ["}", "}", 0]]);
  });
  test("test lexing IE7 hack attribute", function() {
    var tokens;
    tokens = Lexer.tokenize("{ *margin-top: 10px }");
    return same(tokens, [["{", "{", 0], ["IDENTIFIER", "*margin-top", 0], [":", ":", 0], ["UNITNUMBER", "10px", 0], ["}", "}", 0]]);
  });
  test("test lexing urls", function() {
    var tokens;
    tokens = Lexer.tokenize("{ background: url ( ../some_crazy/url.gif?id=5 ) }");
    return same(tokens, [["{", "{", 0], ["IDENTIFIER", "background", 0], [":", ":", 0], ["IDENTIFIER", "url", 0], ["(", "(", 0], ["STRING", "'../some_crazy/url.gif?id=5'", 0], [")", ")", 0], ["}", "}", 0]]);
  });
  test("test lexing number units", function() {
    var tokens;
    tokens = Lexer.tokenize("{ margin: 50% 100pxx; }");
    return same(tokens, [["{", "{", 0], ["IDENTIFIER", "margin", 0], [":", ":", 0], ["UNITNUMBER", "50%", 0], ["NUMBER", "100", 0], ["IDENTIFIER", "pxx", 0], [";", ";", 0], ["}", "}", 0]]);
  });
  test("test lexing !important", function() {
    var tokens;
    tokens = Lexer.tokenize("{ margin: 5px !important}");
    return same(tokens, [["{", "{", 0], ["IDENTIFIER", "margin", 0], [":", ":", 0], ["UNITNUMBER", "5px", 0], ["IMPORTANT", "!important", 0], ["}", "}", 0]]);
  });
  test("test lexing complex function names", function() {
    var tokens;
    tokens = Lexer.tokenize("{filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#f4f4f4',endColorstr='#ececec');}");
    return same(tokens, [["{", "{", 0], ["IDENTIFIER", "filter", 0], [":", ":", 0], ["IDENTIFIER", "progid:DXImageTransform.Microsoft.gradient", 0], ["(", "(", 0], ["IDENTIFIER", "GradientType", 0], ["=", "=", 0], ["NUMBER", "0", 0], [",", ",", 0], ["IDENTIFIER", "startColorstr", 0], ["=", "=", 0], ["STRING", "'#f4f4f4'", 0], [",", ",", 0], ["IDENTIFIER", "endColorstr", 0], ["=", "=", 0], ["STRING", "'#ececec'", 0], [")", ")", 0], [";", ";", 0], ["}", "}", 0]]);
  });
  test("test lexing a multiline thing", function() {
    var css, tokens;
    css = "    body {\n      color: #333;\n      background: #f6f6f6 url(../images/background.png);\n    }  ";
    tokens = Lexer.tokenize(css);
    return same(tokens, [["IDENTIFIER", "body", 0], ["{", "{", 0], ["IDENTIFIER", "color", 1], [":", ":", 1], ["HEXNUMBER", "#333", 1], [";", ";", 1], ["IDENTIFIER", "background", 2], [":", ":", 2], ["HEXNUMBER", "#f6f6f6", 2], ["IDENTIFIER", "url", 2], ["(", "(", 2], ["STRING", "'../images/background.png'", 2], [")", ")", 2], [";", ";", 2], ["}", "}", 3]]);
  });
}).call(this);
