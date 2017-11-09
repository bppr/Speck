public enum Status {
  case pass, fail, pending

  public static func isFailing(_ obj: HasStatus) -> Bool {
    return obj.status == .fail
  }
}

public protocol HasStatus {
  var status: Status { get }
}
