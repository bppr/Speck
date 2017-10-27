public class Suite: HasStatus {
	public typealias Function = () throws -> Void

	public let description: String
	public let fn: Function

	public var examples = [Example]()
	public var children = [Suite]()
	public var beforeHooks = [Function]()
	public var afterHooks = [Function]()
	public weak var parent: Suite?

	public var status: Status {
		return examples.contains(where: Status.equals(.Fail)) ? .Fail : .Pass
	}

	public init(description: String, fn: @escaping Function) {
		self.description = description
		self.fn = fn
	}

	public func add(suite: Suite) {
		suite.parent = self
		children.append(suite)
	}

	public func add(example: Example) {
		examples.append(example)
	}
}

extension Suite: Equatable {}
public func ==(lhs: Suite, rhs: Suite) -> Bool {
	return lhs.description == rhs.description &&
		lhs.children == rhs.children &&
		lhs.examples.map { $0.description } == rhs.examples.map { $0.description }
}
