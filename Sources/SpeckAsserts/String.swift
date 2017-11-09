import SpeckCore

#if _runtime(_ObjC)
#else
extension String {
  func hasPrefix(_ prefix: String) -> Bool {
    let end = index(startIndex, offsetBy: prefix.length)
    return self[startIndex ..< end] == prefix
  }

  func hasSuffix(_ suffix: String) -> Bool {
    let start = index(endIndex, offsetBy: -suffix.length)
    return self[start ..< endIndex] == suffix
  }
}
#endif

public protocol StringExpectable {
  var asString: String { get }
}

extension String: StringExpectable {
  public var asString: String { return self }
}

public extension Expectation where Subject: StringExpectable {
  func to(contain string: String) {
    assert(
      subject?.asString.contains(string: string) ?? false,
      msg: "contain string '\(string)'"
    )
  }

  func to(endWith suffix: String) {
    assert(
      subject?.asString.hasSuffix(suffix) ?? false,
      msg: "end with '\(suffix)'"
    )
  }

  func to(startWith prefix: String) {
    assert(
      subject?.asString.hasPrefix(prefix) ?? false,
      msg: "start with '\(prefix)'"
    )
  }
}

private extension String {
  var length: Int { return self.characters.count }
  var first: Character? { return self.characters.first }

  func contains(string other: String) -> Bool {
    return self.index(ofString: other) != nil
  }

  func index(ofString other: String) -> Index? {
    if other.length == 0 {
      return nil
    }

    guard let startAt = self.characters.index(of: other.first!) else {
      return nil
    }

    var idx = startAt

    while idx <= self.index(self.endIndex, offsetBy: -other.length) {
      let fragment = self[idx..<self.index(idx, offsetBy: other.length)]

      if fragment == other {
        return idx
      }

      idx = self.index(after: idx)
    }

    return nil
  }
}
