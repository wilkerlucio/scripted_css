(function() {
  var SelectorNode;
  SelectorNode = CssAST.SelectorNode;
  module("Selector Node");
  test("test spliting selector parts", function() {
    var selector;
    selector = new SelectorNode("div#id.name.other");
    return same(selector.parts(), ["div", "#id", ".name", ".other"]);
  });
  test("test calculating selector weight use 1 for tag selection", function() {
    var selector;
    selector = new SelectorNode("div");
    return same(selector.weight(), 1);
  });
  test("test calculating selector weight use 10 for class selection", function() {
    var selector;
    selector = new SelectorNode(".something");
    return same(selector.weight(), 10);
  });
  test("test calculating selector weight use 100 for id selection", function() {
    var selector;
    selector = new SelectorNode("#menu");
    return same(selector.weight(), 100);
  });
  test("test calculating selector weight accumulate items", function() {
    var selector;
    selector = new SelectorNode("div.name.other");
    return same(selector.weight(), 21);
  });
  test("test calculating selector weight accumulate nested items", function() {
    var selector;
    selector = new SelectorNode("#menu");
    selector.nestSelector(new SelectorNode("div.name.other"));
    return same(selector.weight(), 121);
  });
}).call(this);
