public class Reporter {
  public enum Event {
    case start
    case finish
    case suiteStart(_: Suite)
    case suiteFinish(_: Suite)
    case exampleStart(_: Example)
    case exampleFinish(_: Example)
  }

  public init() {}

  typealias VoidHandler = () -> Void
  typealias SuiteHandler = (Suite) -> Void
  typealias ExampleHandler = (Example) -> Void

  var onStartHandlers = [VoidHandler]()
  var onFinishHandlers = [VoidHandler]()

  var onSuiteStartHandlers = [SuiteHandler]()
  var onSuiteFinishHandlers = [SuiteHandler]()

  var onExampleStartHandlers = [ExampleHandler]()
  var onExampleFinishHandlers = [ExampleHandler]()

  public func onStart(_ handler: @escaping () -> Void) {
    onStartHandlers.append(handler)
  }

  public func onFinish(_ handler: @escaping () -> Void) {
    onFinishHandlers.append(handler)
  }

  public func onSuiteStart(_ handler: @escaping (Suite) -> Void) {
    onSuiteStartHandlers.append(handler)
  }

  public func onSuiteFinish(_ handler: @escaping (Suite) -> Void) {
    onSuiteFinishHandlers.append(handler)
  }

  public func onExampleFinish(_ handler: @escaping (Example) -> Void) {
    onExampleFinishHandlers.append(handler)
  }

  public func onExampleStart(_ handler: @escaping (Example) -> Void) {
    onExampleStartHandlers.append(handler)
  }

  public func trigger(event: Event) {
    switch event {
    case .start:
      onStartHandlers.forEach { fn in fn() }

    case .finish:
      onFinishHandlers.forEach { fn in fn() }

    case .suiteStart(let suite):
      onSuiteStartHandlers.forEach(applyFn(with: suite))

    case .suiteFinish(let suite):
      onSuiteFinishHandlers.forEach(applyFn(with: suite))

    case .exampleStart(let example):
      onExampleStartHandlers.forEach(applyFn(with: example))

    case .exampleFinish(let example):
      onExampleFinishHandlers.forEach(applyFn(with: example))
    }
  }
}

func applyFn<T>(with arg: T) -> ((T) -> Void) -> Void {
  return { $0(arg) }
}
