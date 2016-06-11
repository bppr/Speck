@testable import SpeckCore
import XCTest

class ExampleTest: XCTestCase {
	func test_addsAnExpectation() {
		let example = Example(description: "example-example", fn: {})

		let expectation = BasicExpectation()
		expectation.message = "example-message"

		example.add(expectation: expectation)

		XCTAssertEqual(example.expectations.first?.message, expectation.message)
	}

	func test_ExampleStatusIsFailWhenExampleContainsFailingExpectations() {
		let example = Example(description: "example-example", fn: {})
		let failingExpectation = BasicExpectation()
		let passingExpectation = BasicExpectation()

		failingExpectation.status = .Fail
		passingExpectation.status = .Pass

		example.add(expectation: failingExpectation)
		example.add(expectation: passingExpectation)

		XCTAssertEqual(example.status, Status.Fail)
	}

	func test_ExampleStatusIsPassWhenExampleContainsOnlyPassingExpectations() {
		let example = Example(description: "example-example", fn: {})
		let passingExpectation = BasicExpectation()
		passingExpectation.status = .Pass
		example.add(expectation: passingExpectation)

		XCTAssertEqual(example.status, Status.Pass)
	}
}

#if _runtime(_ObjC)
#else
extension ExampleTest {
  static var allTests: [(String, (ExampleTest) -> () throws -> Void)] {
    return [
      ("test_addsAnExpectation", test_addsAnExpectation),
      ("test_ExampleStatusIsFailWhenExampleContainsFailingExpectations", test_ExampleStatusIsFailWhenExampleContainsFailingExpectations),
      ("test_ExampleStatusIsPassWhenExampleContainsOnlyPassingExpectations", test_ExampleStatusIsPassWhenExampleContainsOnlyPassingExpectations)
    ]
  }
}
#endif
