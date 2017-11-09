import SpeckCore
import SpeckSystem

public class Reporter {
  public var printer = Printer()
  var timer = Timer()
  var passedCount = 0
  var pendingCount = 0
  var failedExamples: [Example] = []

  var runCount: Int {
    return [passedCount, failedExamples.count, pendingCount].reduce(0, +)
  }

  public static func listen(_ dispatch: SpeckCore.Reporter) {
    let reporter = Reporter()

    dispatch.onStart(reporter.timer.start)
    dispatch.onFinish(reporter.reportResults)

    dispatch.onSuiteStart(reporter.onSuiteStart)
    dispatch.onSuiteFinish(reporter.onSuiteFinish)

    dispatch.onExampleFinish(reporter.onExampleFinish)
  }

  func onSuiteStart(suite: Suite) {
    let suiteIsRoot = suite.parent == rootSuite,
      parentHasExamples = suite.parent?.examples.isEmpty ?? true,
      suiteIsFirstChild = (suite.parent?.children.index(of: suite) ?? 0) == 0

    if suiteIsRoot || (!parentHasExamples || !suiteIsFirstChild) {
      printer.lineBreak()
    }

    printer.call(suite.description)
    printer.indent()
  }

  func onSuiteFinish(suite: Suite) {
    if suite.parent == rootSuite {
      printer.lineBreak()
      printer.call("\(suite.allExamples.count) examples", formatSeconds(suite.elapsedTime))
    }

    printer.dedent()
  }

  func onExampleFinish(example: Example) {
    if example.status == .pass {
      passedCount += 1
      printer.call(Color.green("✓ \(example.description)"), Color.none(formatSeconds(example.elapsedTime)))
    } else if example.status == .fail {
      failedExamples.append(example)
      printer.call(Color.red("× \(example.description)"), Color.none(formatSeconds(example.elapsedTime)))
    } else {
      pendingCount += 1
      printer.call(Color.yellow("★ \(example.description)"), Color.none(formatSeconds(example.elapsedTime)))
    }
  }

  public func reportResults() {
    self.timer.finish()

    printer.lineBreak()

    for ex in failedExamples {
      printer.call(Color.red("× \"\(ex.description)\" failed:"))
      printer.indent()

      for exp in ex.expectations.filter(Status.isFailing) {
        printer.call(exp.message, "(./\(fileMinusPwd(exp.cursor.file)):\(exp.cursor.line))")
      }

      printer.lineBreak()
      printer.dedent()
    }

    printer.call(
      ":: RESULTS ::",
      Color.green("✓ \(passedCount)/\(runCount) examples passed ::"),
      Color.red("× \(failedExamples.count) failed ::"),
      Color.yellow("★ \(pendingCount) pending"),
      formatSeconds(self.timer.elapsedTime),
      "\n"
    )
  }

  func formatSeconds(_ elapsedTime: Int?) -> String {
    guard let elapsedTime = elapsedTime else { return "" }

    let time = Double(elapsedTime)

    if time < 100_000 {
      return "(\(time / 1_000)ms)"
    }

    let roundedToThousandth = Math.round(time, toPlaces: 3)
    let convertedToSeconds = roundedToThousandth * 1e-6

    return "(\(convertedToSeconds)s)"
  }
}

func fileMinusPwd(_ file: String) -> String {
  let offset = SpeckSystem.cwd.characters.count + 1
  let startIdx = file.index(file.startIndex, offsetBy: offset)

  return String(file[startIdx..<file.endIndex])
}
