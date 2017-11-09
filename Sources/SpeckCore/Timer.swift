#if _runtime(_ObjC)
  import Darwin.C
#else
  import Glibc
#endif

public protocol Timed { var timer: Timer { get }}

extension Timed {
  /// the measured time in µs, or nil if timing has not finished
  public var elapsedTime: Int? { return self.timer.elapsedTime }
}

/// utility for measuring real time in µs
public class Timer {
  public typealias Timeable = () throws -> Void

  /// time the given block and return the elapsed time in µs
  public static func time(_ fn: Timeable) rethrows -> Int {
    let timer = Timer()
    try timer.measure(fn)

    return timer.elapsedTime ?? 0
  }

  var startTime: Int?
  var finishTime: Int?

  public init() {}

  /// measure the time for the given function to execute
  public func measure(_ fn: Timeable) rethrows {
    start()
    try fn()
    finish()
  }

  /// record the current time as the timer's start time
  public func start() {
    startTime = Time.now()
  }

  /// record the current time as the timer's finish time
  public func finish() {
    finishTime = Time.now()
  }

  /// elapsed time in µs, or nil if the timer isn't finished
  public var elapsedTime: Int? {
    guard let sTime = startTime, let fTime = finishTime else { return nil }
    return fTime - sTime
  }
}

public class Time {
  public static func now() -> Int {
    let val = UnsafeMutablePointer<timeval>.allocate(capacity: 1)
    defer { val.deallocate(capacity: 1) }

    gettimeofday(val, nil)

    let time = val.pointee
    return Int(time.tv_sec * 1_000_000) + Int(time.tv_usec)
  }
}
