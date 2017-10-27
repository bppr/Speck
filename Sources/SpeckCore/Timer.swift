#if os(OSX)
import Darwin.C
#else
import Glibc
#endif

public class Timer {
	public static func time(fn: () throws -> Void) throws -> Double {
		let start = clock()
		try fn()
		let finish = clock()

		return Double(finish - start) / Double(CLOCKS_PER_SEC)
	}
}
