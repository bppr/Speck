import SpeckCore

public class VoidExpectation: BasicExpectation {
	public typealias Function = () throws -> Void

	let subject: Function

	public var not: VoidExpectation {
		self.reversed = !reversed
		return self
	}

	public init(
		subject: @escaping Function,
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
		change value: () throws -> T?,
		from expectedFromValue: T?,
		to expectedToValue: T?
	) {
		do {
			let actualFromValue = try value()
			try self.subject()
			let actualToValue = try value()

			self.assert(
				actualFromValue == expectedFromValue && actualToValue == expectedToValue,
				msg: "to change value from \(String(describing: expectedFromValue)) "
					+ "to \(String(describing: expectedToValue)), "
					+ "but changed value from \(String(describing: actualFromValue)) "
					+ "to \(String(describing: actualToValue))"
			)
		} catch let err {
			self.assert(false, msg: "error: \(err)")
		}
	}

	public func to<T:Equatable>(
		change value: () throws -> T?,
		to newValue: T?
	) {
		do {
			try self.subject()
			let value = try value()

			self.assert(
				value == newValue,
				msg: "to change value to \(String(describing: newValue)), got \(String(describing: value))"
			)
		} catch let err {
			self.assert(false, msg: "error: \(err)")
		}
	}

	public func to<T:Error>(throwError errType: T.Type) {
		do {
			try self.subject()
			self.assert(false, msg: "throw \(errType) error; no error was thrown")

		} catch let err as T {
			self.assert(true, msg: "throw \(errType) error, threw \(errType).\(err)")

		} catch let err {
			self.assert(
				false,
				msg: "throw \(errType) error, got \(type(of: err)).\(err)"
			)
		}
	}

	public func to<T:Error>(throwError errType: T) {
		do {
			try self.subject()
			self.assert(false, msg: "throw \(errType) error; no error was thrown")

		} catch let err as T where "\(err)" == "\(errType)" {
			self.assert(true, msg: "throw \(errType) error")

		} catch let err {
			self.assert(
				false,
				msg: "throw \(errType) error, got \(type(of: err)).\(err)"
			)
		}
	}
}



