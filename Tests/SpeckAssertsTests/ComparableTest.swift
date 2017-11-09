import XCTest

@testable import SpeckAsserts
import SpeckCore

class ComparableTest: XCTestCase {
	func test_GreaterThanPassesWhenSubjectIsGreater() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThan: 4)

		XCTAssertEqual(expectation.status, Status.pass)
	}

	func test_GreaterThanFailsWhenSubjectIsLesser() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThan: 6)

		XCTAssertEqual(expectation.status, Status.fail)
	}

	func test_LessThanPassesWhenSubjectIsLesser() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThan: 6)

		XCTAssertEqual(expectation.status, Status.pass)
	}

	func test_LessThanFailsWhenSubjectIsGreater() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThan: 4)

		XCTAssertEqual(expectation.status, Status.fail)
	}

	func test_GreaterThanOrEqualPassesWhenSubjectIsGreater() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThanOrEqual: 4)

		XCTAssertEqual(expectation.status, Status.pass)
	}

	func test_GreaterThanOrEqualPassesWhenSubjectIsEqual() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThanOrEqual: 5)

		XCTAssertEqual(expectation.status, Status.pass)
	}

	func test_GreaterThanOrEqualFailsWhenSubjectIsLesser() {
		let expectation = Expectation(subject: 5)
		expectation.to(beGreaterThanOrEqual: 6)

		XCTAssertEqual(expectation.status, Status.fail)
	}

	func test_LessThanOrEqualPassesWhenSubjectIsLess() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThanOrEqual: 6)

		XCTAssertEqual(expectation.status, Status.pass)
	}

	func test_LessThanOrEqualPassesWhenSubjectIsEqual() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThanOrEqual: 5)

		XCTAssertEqual(expectation.status, Status.pass)
	}

	func test_LessThanOrEqualFailsWhenSubjectIsGreater() {
		let expectation = Expectation(subject: 5)
		expectation.to(beLessThanOrEqual: 4)

		XCTAssertEqual(expectation.status, Status.fail)
	}
}

#if _runtime(_ObjC)
#else
extension ComparableTest {
  static var allTests: [(String, (ComparableTest) -> () throws -> Void)] {
    return [
      ("test_GreaterThanPassesWhenSubjectIsGreater", test_GreaterThanPassesWhenSubjectIsGreater),
      ("test_GreaterThanFailsWhenSubjectIsLesser", test_GreaterThanFailsWhenSubjectIsLesser),
      ("test_LessThanPassesWhenSubjectIsLesser", test_LessThanPassesWhenSubjectIsLesser),
      ("test_LessThanFailsWhenSubjectIsGreater", test_LessThanFailsWhenSubjectIsGreater),
      ("test_GreaterThanOrEqualPassesWhenSubjectIsGreater", test_GreaterThanOrEqualPassesWhenSubjectIsGreater),
      ("test_GreaterThanOrEqualPassesWhenSubjectIsEqual", test_GreaterThanOrEqualPassesWhenSubjectIsEqual),
      ("test_GreaterThanOrEqualFailsWhenSubjectIsLesser", test_GreaterThanOrEqualFailsWhenSubjectIsLesser),
      ("test_LessThanOrEqualPassesWhenSubjectIsLess", test_LessThanOrEqualPassesWhenSubjectIsLess),
      ("test_LessThanOrEqualPassesWhenSubjectIsEqual", test_LessThanOrEqualPassesWhenSubjectIsEqual),
      ("test_LessThanOrEqualFailsWhenSubjectIsGreater", test_LessThanOrEqualFailsWhenSubjectIsGreater)
    ]
  }
}
#endif
