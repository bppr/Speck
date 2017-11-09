let rootSuite = Suite(description: "") {}
let nullExample = Example(description: "") {}

class Context {
  var suiteStack = [rootSuite]
  var currentSuite: Suite {
    return suiteStack[suiteStack.count - 1]
  }

  var currentExample = nullExample

  func register(suite: Suite) throws {
    currentSuite.add(suite: suite)

    suiteStack.append(suite)
    try suite.fn()
    suiteStack.removeLast()
  }

  func with(example: Example, do fn: () throws -> Void) throws {
    currentExample = example
    try fn()
    currentExample = nullExample
  }
}
