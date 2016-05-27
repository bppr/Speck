public class Example : HasStatus {
	public typealias Function = (Void) throws -> Void

	public let description: String
	public let fn: Function

	public var expectations = [BasicExpectation]()

	public var status: Status {
		return expectations.contains(Status.equals(.Fail)) ? .Fail : .Pass
	}

	public init(description: String, fn: Function) {
		self.description = description
		self.fn = fn
	}

	public func add(expectation: BasicExpectation) {
		expectations.append(expectation)
	}
}
