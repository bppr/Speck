import SpeckCore
#if os(OSX)
import Darwin.C
#else
import Glibc
#endif

private let maxNameLength = Int(MAXNAMLEN)
var pwd: String = {
	var buf = Array<Int8>(repeating: 0, count: maxNameLength)
	return String(cString: getcwd(&buf, maxNameLength))
}()

func fileMinusPwd(_ file: String) -> String {
	let startIdx = file.index(file.startIndex, offsetBy: pwd.characters.count + 1)
	return String(file[startIdx..<file.endIndex])
}

public class ColorizedString {
	enum Color {
		case Default, Red, Green, Yellow
		
		var colorCode: Int {
			switch self {
			case .Default: return 39
			case .Red:     return 31
			case .Green:   return 32
			case .Yellow:  return 33
			}
		}
	}
	
	static func create(msg: String, color: Color) -> String {
		return "\u{1b}[\(color.colorCode)m\(msg)\u{1b}[39m"
	}
}

public class Printer {
  public var out: (String, Bool) -> Void = { str, newline in
    let msg = newline ? str + "\n" : str
    fputs(msg, stdout)
  }

  public var indentLevel = 0

  func call(_ output: String, newline: Bool = true) {
    var indentation = ""

    if(indentLevel > 0) {
      for _ in 1...indentLevel { indentation += "  " }
    }

    out(indentation + output, newline)
  }

  func lineBreak() { out("", true) }
  func indent() { indentLevel += 1 }
  func dedent() { indentLevel -= 1 }
}

public class Reporter {
	public var printer = Printer()
	var passedCount = 0
	var failedExamples : [Example] = []
	var pendingCount = 0
	var offset = 0

	public static func listen(_ dispatch: SpeckCore.Reporter) {
		let reporter = Reporter()

		dispatch.onFinish(reporter.finished)
		dispatch.onSuiteFinish(reporter.suiteFinished)
	}

	public func finished() {
		printer.lineBreak()

		for ex in failedExamples {
			printer.call(ColorizedString.create(msg: "× \"\(ex.description)\" failed:", color: .Red))
			printer.indent()

			for exp in ex.expectations.filter(Status.equals(.Fail)) {
				printer.call("\(exp.message) (\(fileMinusPwd(exp.cursor.file)):\(exp.cursor.line))")
			}

			printer.lineBreak()

			printer.dedent()
		}

		printer.call(
			":: RESULTS :: " +
			"✓ \(passedCount)/\(runCount()) examples passed :: " +
			"× \(failedExamples.count) failed :: " +
			"★ \(pendingCount) pending\n"
		)
	}

	public func suiteFinished(spec: Suite) {
		if spec.parent == rootSuite { printSpec(spec: spec) }
	}

	func printExample(example: Example) {
		if example.status == .Pass {
			passedCount += 1
			printer.call(ColorizedString.create(msg: "✓ \(example.description)", color: .Green))
		} else if example.status == .Fail {
			failedExamples.append(example)
			printer.call(ColorizedString.create(msg: "× \(example.description)", color: .Red))
		} else {
			pendingCount += 1
			printer.call(ColorizedString.create(msg: "★ \(example.description)", color: .Yellow))
		}
	}

	func printSpec(spec: Suite) {
		if spec.parent == rootSuite { printer.lineBreak() }

		printer.call(spec.description)
		printer.indent()

		spec.examples.forEach(printExample)
		spec.children.forEach(printSpec)

		printer.dedent()
	}

	func runCount() -> Int {
		return [passedCount, failedExamples.count, pendingCount].reduce(0, +)
	}
}

