@testable import SpeckAsserts
import XCTest

class ExpectationTest: XCTestCase {
	func test_assertSetsMessageBodyAndSuffix() {
		let expectation = Expectation(subject: "subject")
		expectation.assert(false, msg: "suffix")

		XCTAssertEqual(expectation.message, "expected subject to suffix")
	}

	func test_reversedAssertSetsMessageBodyAndSuffix() {
		let expectation = Expectation(subject: "subject").not
		expectation.assert(false, msg: "suffix")

		XCTAssertEqual(expectation.message, "expected subject not to suffix")
	}

	func test_nilSubjectMessageShowsType() {
		let expectation = Expectation<String>(subject: nil)
		expectation.assert(false, msg: "suffix")

		XCTAssertEqual(expectation.message, "expected nil <String> to suffix")
	}
}
