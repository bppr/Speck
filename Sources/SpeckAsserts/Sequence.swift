import SpeckCore

public extension Expectation where
  Subject : Sequence,
  Subject.Iterator.Element : Equatable {
  func to(contain element: Subject.Iterator.Element) {
    self.assert(
      subject?.contains(where: { $0 == element }) ?? false,
      msg: "contain \(element)"
    )
  }

  func to(contain element: Subject.Iterator.Element?) {
    self.assert(
      subject?.contains(where: { $0 == element }) ?? false,
      msg: "contain \(String(describing: element))"
    )
  }
}
