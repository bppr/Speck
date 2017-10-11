import SpeckCore

public extension Expectation where Subject : Equatable {
	func to(equal other: Subject?) {
		self.assert(subject == other, msg: "equal \(String(describing: other))")
	}

	func to(equal other: Subject) {
		self.assert(subject == other, msg: "equal \(other)")
	}
}
