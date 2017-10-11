public class Example : HasStatus {
	public typealias Function = () throws -> Void

	public let description: String
	public let fn: Function

	public var expectations = [BasicExpectation]()

	public var status: Status {
		return expectations.contains(where: Status.equals(.Fail)) ? .Fail : .Pass
	}

	public init(description: String, fn: @escaping Function) {
		self.description = description
		self.fn = fn
	}

	public func add(expectation: BasicExpectation) {
		expectations.append(expectation)
	}
}
