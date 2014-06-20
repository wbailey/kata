var calculator = require("../lib/calculator");

describe("Calculator", function() {
  it("sets the expression", function() {
    var expectation = "1,2";
    calculator.setExpr(expectation);
    var expr = calculator.getExpr();
    expect(expr).toBe(expectation);
  });
});
