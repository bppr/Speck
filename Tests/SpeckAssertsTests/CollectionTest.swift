import XCTest

@testable import SpeckAsserts
import SpeckCore

class CollectionTest: XCTestCase {
	func test_startWithPassesWhenFirstElementMatches() {
		let expectation = Expectation(subject: [1, 2, 3])
		expectation.to(startWith: 1)

		XCTAssertEqual(expectation.status, Status.pass)
	}

	func test_startWithFailsWhenFirstElementDoesNotMatch() {
		let expectation = Expectation(subject: [Int]())
		expectation.to(startWith: 2)

		XCTAssertEqual(expectation.status, Status.fail)
	}

	func test_endWithPassesWhenLastElementMatches() {
		let expectation = Expectation(subject: [1, 2, 3])
		expectation.to(endWith: 3)

		XCTAssertEqual(expectation.status, Status.pass)
	}

	func test_endWithFailsWhenLastElementDoesNotMatch() {
		let expectation = Expectation(subject: [1, 2, 3])
		expectation.to(endWith: 1)

		XCTAssertEqual(expectation.status, Status.fail)
	}
}

#if _runtime(_ObjC)
#else
extension CollectionTest {
  static var allTests: [(String, (CollectionTest) -> () throws -> Void)] {
    return [
      ("test_startWithPassesWhenFirstElementMatches", test_startWithPassesWhenFirstElementMatches),
      ("test_startWithFailsWhenFirstElementDoesNotMatch", test_startWithFailsWhenFirstElementDoesNotMatch),
      ("test_endWithPassesWhenLastElementMatches", test_endWithPassesWhenLastElementMatches),
      ("test_endWithFailsWhenLastElementDoesNotMatch", test_endWithFailsWhenLastElementDoesNotMatch)
    ]
  }
}
#endif
