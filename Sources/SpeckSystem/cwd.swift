#if os(OSX)
  import Darwin.C
#else
  import Glibc
#endif

public let maxNameLength = Int(MAXNAMLEN)

public let cwd: String = {
  var buf = [Int8](repeating: 0, count: maxNameLength)
  return String(cString: getcwd(&buf, maxNameLength))
}()
