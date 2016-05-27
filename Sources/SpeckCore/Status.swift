public enum Status {
	case Pass
	case Fail
	case Pending

	public static func equals(_ status: Status) -> (HasStatus) -> Bool {
		return { $0.status == status }
	}
}

public protocol HasStatus {
	var status: Status { get }
}
