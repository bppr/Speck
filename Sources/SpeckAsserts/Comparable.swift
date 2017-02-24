import SpeckCore

public extension Expectation where Subject: Comparable {
	func to(beGreaterThan other: Subject) {
		assert(
			self.subject != nil && self.subject! > other,
			msg: "be greater than \(other)"
		)
	}

	func to(beLessThan other: Subject) {
		assert(
			self.subject != nil && self.subject! < other,
			msg: "be less than \(other)"
		)
	}

	func to(beGreaterThanOrEqual other: Subject) {
		assert(
			self.subject != nil && self.subject! >= other,
			msg: "be greater than or equal to \(other)"
		)
	}

	func to(beLessThanOrEqual other: Subject) {
		assert(
			self.subject != nil && self.subject! <= other,
			msg: "be less than or equal to \(other)"
		)
	}
}
