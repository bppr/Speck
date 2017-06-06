#if os(OSX)
import Darwin.C
#else
import Glibc
#endif

func runSuite(suite: Suite) throws {
	reporter.trigger(event: .SuiteStart(suite))

	for example in suite.examples {
		try context.with(example: example, do: runExample(example, suite))
	}

	for child in suite.children { try runSuite(suite: child) }

	reporter.trigger(event: .SuiteFinish(suite))
}

func runExample(_ example: Example, _ suite: Suite) throws -> () throws -> Void {
	return {
		reporter.trigger(event: .ExampleStart(example))

		try runBeforeHooks(suite: suite)
		try example.fn()
		try runAfterHooks(suite: suite)

		reporter.trigger(event: .ExampleFinish(example))
	}
}

func runBeforeHooks(suite: Suite) throws {
	if let parent = suite.parent {
		try runBeforeHooks(suite: parent)
	}

	for hook in suite.beforeHooks { try hook() }
}

func runAfterHooks(suite: Suite) throws {
	if let parent = suite.parent {
		try runAfterHooks(suite: parent)
	}

	for hook in suite.afterHooks { try hook() }
}

public func run() throws {
	reporter.trigger(event: .Start)

	let failures = try rootSuite.children.filter { suite in
		try runSuite(suite: suite)
		return suite.status == .Fail
	}

	reporter.trigger(event: .Finish)

	exit(failures.isEmpty ? 0 : 1)
}
