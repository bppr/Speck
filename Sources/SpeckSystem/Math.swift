#if os(OSX)
  import Darwin.C
#else
  import Glibc
#endif

let __floor = floor

public class Math {
  public static func floor(_ num: Double) -> Double {
    return __floor(num)
  }

  public static func round(_ num: Double, toPlaces places: UInt) -> Double {
    let multiplier = pow(10.0, Double(places))
    return floor(num / multiplier) * multiplier
  }
}
