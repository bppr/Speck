let nullCursor = Cursor(file: "unknown", line: 0)

open class BasicExpectation: HasStatus {
  public var message: String = ""
  public var status: Status = .pending
  public var reversed: Bool = false
  public var cursor: Cursor

  public init() {
    self.cursor = nullCursor
  }

  public init(cursor: Cursor) {
    self.cursor = cursor
  }

  open func assert(_ condition: Bool, msg: String) {
    self.status = condition != reversed ? .pass : .fail
    self.message = msg
  }
}
