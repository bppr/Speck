import SpeckCore

public class Expectation<Subject>: BasicExpectation {
	public let subject: Subject?

	public var not: Expectation {
		self.reversed = !reversed
		return self
	}

	public init(
		subject: Subject?,
		reversed: Bool = false,
		file: String = #file,
		line: UInt = #line
	) {
		self.subject = subject
		super.init(cursor: Cursor(file: file, line: line))
		self.reversed = reversed
	}

	override public func assert(_ condition: Bool, msg: String) {
		let verb = reversed ? "not to" : "to"

		let subjectAsString: String

		if let subject = subject {
			subjectAsString = "\(subject)"
		} else {
			// remove 'Optional' to give terse type information
			let typeStr = "\(type(of: subject))"
			let startIdx = typeStr.index(typeStr.startIndex, offsetBy: 8)

			subjectAsString = "nil \(typeStr[startIdx..<typeStr.endIndex])"
		}

		let message = "expected \(subjectAsString) \(verb) \(msg)"

		super.assert(condition, msg: message)
	}
}
