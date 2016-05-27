@_exported import SpeckAsserts
@_exported import SpeckCore

let context = Context()

@discardableResult
public func describe(_ description: String, _ fn: Suite.Function) -> Suite {
	let suite = Suite(description: description, fn: fn)
	try! context.register(suite: suite)
	return suite
}

public func it(_ description: String, fn: Example.Function) {
	context.currentSuite.add(example: Example(description: description, fn: fn))
}

public func before(_ fn: Suite.Function) {
	context.currentSuite.beforeHooks.append(fn)
}

public func after(_ fn: Suite.Function) {
	context.currentSuite.afterHooks.append(fn)
}

public func register(_ suites: [Suite]) {}
