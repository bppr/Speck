#if os(OSX)
  import Darwin.C
#else
  import Glibc
#endif

public class System {
  public static var out = stdout
  public static var `in` = stdin
  public static var err = stderr
}

public typealias FilePointer = UnsafeMutablePointer<FILE>

public func log(_ msg: String, toStream stream: FilePointer = System.out) {
  fputs(msg, stream)
}
