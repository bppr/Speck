import SpeckCore

public protocol DictionaryExpectable {
	associatedtype Key: Hashable
	associatedtype Value

	var asDict: [Key: Value] { get }
}

extension Dictionary : DictionaryExpectable {
	public var asDict: [Key: Value] { return self }
}

public extension Expectation where
	Subject: DictionaryExpectable,
	Subject.Value: Equatable {

	func to(equal other: [Subject.Key: Subject.Value]?) {
		let equals: Bool

		if let subject = subject, let other = other {
			equals = subject.asDict == other
		} else {
			equals = subject == nil && other == nil
		}

		assert(equals, msg: "equal \(String(describing: other))")
	}

	func to(equal other: [Subject.Key: Subject.Value]) {
		assert(
			subject != nil && subject!.asDict == other,
			msg: "equal \(other)"
		)
	}

	func to(contain element: (Subject.Key, Subject.Value)) {
		let (key, value) = element

		assert(
			subject != nil && subject?.asDict[key] == value,
			msg: "contain pair \(element)"
		)
	}

	func to(haveKey key: Subject.Key) {
		assert(
			subject != nil && subject?.asDict.index(forKey: key) != nil,
			msg: "contain key \(key)"
		)
	}

	func to(haveValue value: Subject.Value) {
		assert(
			subject != nil && subject?.asDict.values.contains(value) ?? false,
			msg: "contain value \(value)"
		)
	}
}
