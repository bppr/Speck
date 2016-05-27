public struct Cursor {
	public let file: String
	public let line: UInt

	public init(file: String, line: UInt) {
		(self.file, self.line) = (file, line)
	}
}
