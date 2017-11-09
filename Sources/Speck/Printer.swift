import SpeckSystem

protocol Printable {
  var asString: String { get }
}

extension String: Printable {
  var asString: String { return self }
}

enum Color: Printable {
  case none(String), red(String), green(String), yellow(String)

  var asString: String {
    var (color, str): (Int, String)

    switch self {
    case .red(let msg):     (color, str) = (31, msg)
    case .green(let msg):   (color, str) = (32, msg)
    case .yellow(let msg):  (color, str) = (33, msg)
    case .none(let msg):    (color, str) = (39, msg)
    }

    return "\u{1b}[\(color)m\(str)\u{1b}[39m"
  }
}

public class Printer {
  public var indentLevel = 0

  public var out: (String, Bool) -> Void = { str, newline in
    SpeckSystem.log(newline ? str + "\n" : str)
  }

  var indentation: String {
    var idx = 0, pad = ""

    while idx < indentLevel {
      pad += "  "
      idx += 1
    }

    return pad
  }

  func call(_ output: Printable..., newline: Bool = true) {
    let fullOutput = ([indentation] + output)
      .map { $0.asString }
      .filter { $0.characters.count > 0 }
      .joined(separator: " ")

    out(fullOutput, newline)
  }

  func lineBreak() {
    out("", true)
  }

  func indent() {
    indentLevel += 1
  }

  func dedent() {
    indentLevel -= 1
  }
}

