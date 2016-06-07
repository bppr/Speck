public class Reporter {
	public enum Event {
		case Start
		case Finish
		case SuiteStart(_: Suite)
		case SuiteFinish(_: Suite)
		case ExampleStart(_: Example)
		case ExampleFinish(_: Example)
	}

	public init() {}

	var onStartHandlers = [(Void) -> Void]()
	var onFinishHandlers = [(Void) -> Void]()

	var onSuiteStartHandlers = [(Suite) -> Void]()
	var onSuiteFinishHandlers = [(Suite) -> Void]()

	var onExampleStartHandlers = [(Example) -> Void]()
	var onExampleFinishHandlers = [(Example) -> Void]()

	public func onStart(_ cb: (Void) -> Void) {
		onStartHandlers.append(cb)
	}

	public func onFinish(_ cb: (Void) -> Void) {
		onFinishHandlers.append(cb)
	}

	public func onSuiteStart(_ cb: (Suite) -> Void) {
		onSuiteStartHandlers.append(cb)
	}

	public func onSuiteFinish(_ cb: (Suite) -> Void) {
		onSuiteFinishHandlers.append(cb)
	}

	public func onExampleFinish(_ cb: (Example) -> Void) {
		onExampleFinishHandlers.append(cb)
	}

	public func onExampleStart(_ cb: (Example) -> Void) {
		onExampleStartHandlers.append(cb)
	}

	public func trigger(event: Event) {
		switch event {
		case .Start:
			onStartHandlers.forEach { fn in fn() }

		case .Finish:
			onFinishHandlers.forEach { fn in fn() }

		case .SuiteStart(let suite):
			onSuiteStartHandlers.forEach { fn in fn(suite) }

		case .SuiteFinish(let suite):
			onSuiteFinishHandlers.forEach { fn in fn(suite) }

		case .ExampleStart(let example):
			onExampleStartHandlers.forEach { fn in fn(example) }

		case .ExampleFinish(let example):
			onExampleFinishHandlers.forEach { fn in fn(example) }
		}
	}
}
