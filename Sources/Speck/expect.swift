@_exported import SpeckAsserts
@_exported import SpeckCore

public func expect<T>(
	_ subject: T?,
	file: String = #file,
	line: UInt = #line
) -> Expectation<T> {
	let expectation =  Expectation(subject: subject, file: file, line: line)
	context.currentExample.add(expectation: expectation)

	return expectation
}

public func expect(
	file: String = #file,
	line: UInt = #line,
	_ subject: @escaping () throws -> Void
) -> VoidExpectation {
	let expectation = VoidExpectation(subject: subject, file: file, line: line)
	context.currentExample.add(expectation: expectation)

	return expectation
}

