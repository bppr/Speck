@testable import SpeckCore
import XCTest

class BasicExpectationTest: XCTestCase {
	func test_assertTrueSetsResultStatusToTrue() {
		let expectation = BasicExpectation()
		expectation.assert(true, msg: "passed")

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_assertFalseSetsResultStatusToFail() {
		let expectation = BasicExpectation()
		expectation.assert(false, msg: "failed")

		XCTAssertEqual(expectation.status, Status.Fail)
	}

	func test_reversedAssertFalseSetsResultStatusToPass() {
		let expectation = BasicExpectation()

		expectation.reversed = true
		expectation.assert(false, msg: "passed")

		XCTAssertEqual(expectation.status, Status.Pass)
	}

	func test_reversedAssertTrueSetsResultStatusToFail() {
		let expectation = BasicExpectation()

		expectation.reversed = true
		expectation.assert(true, msg: "failed")

		XCTAssertEqual(expectation.status, Status.Fail)
	}
}

#if _runtime(_ObjC)
#else
extension BasicExpectationTest {
  static var allTests: [(String, (BasicExpectationTest) -> () throws -> Void)] {
    return [
      ("test_assertTrueSetsResultStatusToTrue", test_assertTrueSetsResultStatusToTrue),
      ("test_assertFalseSetsResultStatusToFail", test_assertFalseSetsResultStatusToFail),
      ("test_reversedAssertFalseSetsResultStatusToPass", test_reversedAssertFalseSetsResultStatusToPass),
      ("test_reversedAssertTrueSetsResultStatusToFail", test_reversedAssertTrueSetsResultStatusToFail)
    ]
  }
}
#endif
