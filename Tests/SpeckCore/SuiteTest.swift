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
		XCTAssertEqual(suite.status, Status.Pass)
	}

	func test_StatusIsFailingWhenContainingFailingExamples() {
		let suite = Suite(description: "example-suite", fn: {})
		suite.add(example: Example(description: "example-example", fn: {}))

		let expectation = BasicExpectation()
		expectation.status = .Fail

		suite.examples.first?.add(expectation: expectation)

		XCTAssertEqual(suite.status, Status.Fail)
	}
}
