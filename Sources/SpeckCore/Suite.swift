public class Suite: HasStatus, Timed {
  public typealias Function = () throws -> Void

  public let description: String
  public let fn: Function

  public var examples = [Example]()
  public var children = [Suite]()
  public var beforeHooks = [Function]()
  public var afterHooks = [Function]()
  public var timer = Timer()

  public weak var parent: Suite?

  public var status: Status {
    return containees.contains(where: Status.isFailing) ? .fail : .pass
  }

  public var allExamples: [Example] {
    return examples + children.flatMap { $0.allExamples }
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

  private var containees: [HasStatus] {
    let c: [HasStatus] = self.children
    return c + self.examples
  }
}

extension Suite: Equatable {}
public func == (lhs: Suite, rhs: Suite) -> Bool {
  return lhs.description == rhs.description &&
    lhs.children == rhs.children &&
    lhs.examples.map { $0.description } == rhs.examples.map { $0.description }
}
