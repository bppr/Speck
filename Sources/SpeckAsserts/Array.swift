import SpeckCore

public protocol ArrayExpectable {
  associatedtype Element

  var asArray: [Element] { get }
}

extension Array: ArrayExpectable {
  public var asArray: [Element] { return self }
}

public extension Expectation where
  Subject: ArrayExpectable,
  Subject.Element: Equatable {

  func to(equal other: [Subject.Element]?) {
    let equals: Bool

    if let subject = subject, let other = other {
      equals = subject.asArray == other
    } else {
      equals = subject == nil && other == nil
    }

    self.assert(equals, msg: "equal \(String(describing: other))")
  }

  func to(equal other: [Subject.Element]) {
    self.assert(
      subject != nil && subject!.asArray == other,
      msg: "equal \(other)"
    )
  }
}
