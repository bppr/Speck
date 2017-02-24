import XCTest

@testable import SpeckAsserts
import SpeckCore

class ArrayTest: XCTestCase {
	func test_equalsPassesIfArraysAreEqual() {
		let expectation = Expectation(subject: ["an", "array"])
		expectation.to(equal: ["an", "array"])

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_equalsPassesIfBothArraysAreNil() {
		let nilArray: [Int]? = nil
		let expectation = Expectation(subject: nilArray)
		expectation.to(equal: nil)

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_equalsFailsIfArraysArentEqual() {
		let expectation = Expectation(subject: ["a"])
		expectation.to(equal: ["b"])

		XCTAssertEqual(expectation.status, Status.Fail)
	}

	func test_equalsFailsIfSubjectArrayIsNil() {
		let nilArray: [Int]? = nil
		let expectation = Expectation(subject: nilArray)
		expectation.to(equal: [1])

		XCTAssertEqual(expectation.status, Status.Fail)
	}

	func test_equalsFailsIfObjectArrayIsNil() {
		let expectation = Expectation(subject: [1])
		expectation.to(equal: nil)

		XCTAssertEqual(expectation.status, Status.Fail)
	}
}

#if _runtime(_ObjC)
#else
extension ArrayTest {
  static var allTests: [(String, (ArrayTest) -> () throws -> Void)] {
    return [
      ("test_equalsPassesIfArraysAreEqual", test_equalsPassesIfArraysAreEqual),
      ("test_equalsPassesIfBothArraysAreNil", test_equalsPassesIfBothArraysAreNil),
      ("test_equalsFailsIfArraysArentEqual", test_equalsFailsIfArraysArentEqual),
      ("test_equalsFailsIfSubjectArrayIsNil", test_equalsFailsIfSubjectArrayIsNil),
      ("test_equalsFailsIfObjectArrayIsNil", test_equalsFailsIfObjectArrayIsNil)
    ]
  }
}
#endif
