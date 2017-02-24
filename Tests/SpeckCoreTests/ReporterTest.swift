@testable import SpeckCore
import XCTest

class ReporterTest: XCTestCase {
	var reporter = Reporter()

	func test_addsAndTriggersStartEventHandler() {
		var handlerCalled = false

		reporter.onStart { handlerCalled = true }
		reporter.trigger(event: .Start)

		XCTAssert(handlerCalled)
	}

	func test_addsAndTriggersFinishEventHandler() {
		var handlerCalled = false

		reporter.onFinish { handlerCalled = true }
		reporter.trigger(event: .Finish)

		XCTAssert(handlerCalled)
	}

	func test_addsAndTriggersOnSuiteStartHandler() {
		var handlerCalledWith: Suite? = nil
		let suite = Suite(description: "example-suite", fn: {})

		reporter.onSuiteStart { handlerCalledWith = $0 }
		reporter.trigger(event: .SuiteStart(suite))

		XCTAssertEqual(handlerCalledWith, suite)
	}

	func test_addsAndTriggersOnSuiteFinishHandler() {
		var handlerCalledWith: Suite? = nil
		let suite = Suite(description: "example-suite", fn: {})

		reporter.onSuiteFinish { handlerCalledWith = $0 }
		reporter.trigger(event: .SuiteFinish(suite))

		XCTAssertEqual(handlerCalledWith, suite)
	}

	func test_addsAndTriggersOnExampleStartHandler() {
		var handlerCalledWith: Example? = nil
		let example = Example(description: "example-example", fn: {})

		reporter.onExampleStart { handlerCalledWith = $0 }
		reporter.trigger(event: .ExampleStart(example))

		XCTAssertEqual(handlerCalledWith?.description, example.description)
	}

	func test_addsAndTriggersOnExampleFinishHandler() {
		var handlerCalledWith: Example? = nil
		let example = Example(description: "example-example", fn: {})

		reporter.onExampleFinish { handlerCalledWith = $0 }
		reporter.trigger(event: .ExampleFinish(example))

		XCTAssertEqual(handlerCalledWith?.description, example.description)
	}
}

#if _runtime(_ObjC)
#else
extension ReporterTest {
  static var allTests: [(String, (ReporterTest) -> () throws -> Void)] {
    return [
      ("test_addsAndTriggersStartEventHandler", test_addsAndTriggersStartEventHandler),
      ("test_addsAndTriggersFinishEventHandler", test_addsAndTriggersFinishEventHandler),
      ("test_addsAndTriggersOnSuiteStartHandler", test_addsAndTriggersOnSuiteStartHandler),
      ("test_addsAndTriggersOnSuiteFinishHandler", test_addsAndTriggersOnSuiteFinishHandler),
      ("test_addsAndTriggersOnExampleStartHandler", test_addsAndTriggersOnExampleStartHandler),
      ("test_addsAndTriggersOnExampleFinishHandler", test_addsAndTriggersOnExampleFinishHandler)
    ]
  }
}
#endif
