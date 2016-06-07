import SpeckCore

public class VoidExpectation: BasicExpectation {
	public typealias Function = (Void) throws -> Void

	let subject: Function

	public var not: VoidExpectation {
		self.reversed = !reversed
		return self
	}

	public init(
		subject: Function,
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
		super.assert(condition, msg: "expected function \(verb) \(msg)")
	}

	public func to<T:Equatable>(
		change value: (Void) throws -> T?,
		to newValue: T?
	) {
		do {
			try self.subject()
			let value = try value()

			self.assert(
				value == newValue,
				msg: "to change value to \(newValue), got \(value)"
			)
		} catch let err {
			self.assert(false, msg: "error: \(err)")
		}
	}

	public func to<T:ErrorProtocol>(throwError errType: T.Type) {
		do {
			try self.subject()
			self.assert(false, msg: "throw \(errType) error; no error was thrown")

		} catch let err as T {
			self.assert(true, msg: "throw \(errType) error, threw \(errType).\(err)")

		} catch let err {
			self.assert(
				false,
				msg: "throw \(errType) error, got \(err.dynamicType).\(err)"
			)
		}
	}

	public func to<T:ErrorProtocol>(throwError errType: T) {
		do {
			try self.subject()
			self.assert(false, msg: "throw \(errType) error; no error was thrown")

		} catch let err as T where "\(err)" == "\(errType)" {
			self.assert(true, msg: "throw \(errType) error")

		} catch let err {
			self.assert(
				false,
				msg: "throw \(errType) error, got \(err.dynamicType).\(err)"
			)
		}
	}
}
