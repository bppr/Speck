@testable import SpeckCore
import XCTest

class SuiteTest: XCTestCase {
  func test_addSuiteSetsTheParentOnTheAddedSuite() {
    let childSuite = Suite(description: "child", fn: {})
    let parentSuite = Suite(description: "parent", fn: {})

    parentSuite.add(suite: childSuite)

    XCTAssertEqual(childSuite.parent, parentSuite)
    XCTAssertEqual(parentSuite.children, [childSuite])
  }

  func test_addExampleAddsAnExampleToTheParent() {
    let suite = Suite(description: "example-suite", fn: {})
    suite.add(example: Example(description: "example-example", fn: {}))

    XCTAssertEqual(suite.examples.map { $0.description }, ["example-example"])
  }

  func test_StatusIsPassingByDefault() {
    let suite = Suite(description: "example-suite", fn: {})
    XCTAssertEqual(suite.status, Status.pass)
  }

  func test_StatusIsFailingWhenContainingFailingExamples() {
    let suite = Suite(description: "example-suite", fn: {})
    suite.add(example: Example(description: "example-example", fn: {}))

    let expectation = BasicExpectation()
    expectation.status = .fail

    suite.examples.first?.add(expectation: expectation)

    XCTAssertEqual(suite.status, Status.fail)
  }

  func test_StatusIsFailingWhenContainingFailingChildrenSuites() {
    let parentSuite = Suite(description: "parent-suite", fn: {})
    let childSuite = Suite(description: "child-suite", fn: {})

    let expectation = BasicExpectation()
    expectation.status = .fail

    let example = Example(description: "example-example", fn: {})
    example.add(expectation: expectation)

    childSuite.add(example: example)
    parentSuite.add(suite: childSuite)

    XCTAssertEqual(parentSuite.status, Status.fail)
  }
}

#if _runtime(_ObjC)
#else
  extension SuiteTest {
    static var allTests: [(String, (SuiteTest) -> () throws -> Void)] {
      return [
        ("test_addSuiteSetsTheParentOnTheAddedSuite", test_addSuiteSetsTheParentOnTheAddedSuite),
        ("test_addExampleAddsAnExampleToTheParent", test_addExampleAddsAnExampleToTheParent),
        ("test_StatusIsPassingByDefault", test_StatusIsPassingByDefault),
        ("test_StatusIsFailingWhenContainingFailingExamples", test_StatusIsFailingWhenContainingFailingExamples)
      ]
    }
  }
#endif
