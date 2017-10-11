import SpeckCore

public extension Expectation where
	Subject : Collection,
	Subject.Iterator.Element : Equatable
{
	func to(startWith element: Subject.Iterator.Element) {
		assert(subject?.first == element, msg: "start with \(element)")
	}
}

public extension Expectation where
	Subject.Iterator.Element: Equatable,
	Subject: BidirectionalCollection {
	
	func to(endWith element: Subject.Iterator.Element) {
		assert(subject?.last == element, msg: "end with \(element)")
	}
}
