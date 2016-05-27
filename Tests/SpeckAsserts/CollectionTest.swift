import XCTest

@testable import SpeckAsserts
import SpeckCore

class CollectionTest: XCTestCase {
	func test_startWithPassesWhenFirstElementMatches() {
		let expectation = Expectation(subject: [1, 2, 3])
		expectation.to(startWith: 1)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_startWithFailsWhenFirstElementDoesNotMatch() {
		let expectation = Expectation(subject: [Int]())
		expectation.to(startWith: 2)

		XCTAssertEqual(expectation.status, Status.Fail)
	}

	func test_endWithPassesWhenLastElementMatches() {
		let expectation = Expectation(subject: [1, 2, 3])
		expectation.to(endWith: 3)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_endWithFailsWhenLastElementDoesNotMatch() {
		let expectation = Expectation(subject: [1, 2, 3])
		expectation.to(endWith: 1)

		XCTAssertEqual(expectation.status, Status.Fail)
	}
}
