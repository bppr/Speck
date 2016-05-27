import XCTest

@testable import SpeckAsserts
import SpeckCore

class ComparableTest: XCTestCase {
	func test_GreaterThanPassesWhenSubjectIsGreater() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThan: 4)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_GreaterThanFailsWhenSubjectIsLesser() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThan: 6)

		XCTAssertEqual(expectation.status, Status.Fail)
	}

	func test_LessThanPassesWhenSubjectIsLesser() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThan: 6)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_LessThanFailsWhenSubjectIsGreater() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThan: 4)

		XCTAssertEqual(expectation.status, Status.Fail)
	}

	func test_GreaterThanOrEqualPassesWhenSubjectIsGreater() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThanOrEqual: 4)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_GreaterThanOrEqualPassesWhenSubjectIsEqual() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThanOrEqual: 5)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_GreaterThanOrEqualFailsWhenSubjectIsLesser() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThanOrEqual: 6)

		XCTAssertEqual(expectation.status, Status.Fail)
	}

	func test_LessThanOrEqualPassesWhenSubjectIsLess() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThanOrEqual: 6)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_LessThanOrEqualPassesWhenSubjectIsEqual() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThanOrEqual: 5)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_LessThanOrEqualFailsWhenSubjectIsGreater() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThanOrEqual: 4)

		XCTAssertEqual(expectation.status, Status.Fail)
	}
}
