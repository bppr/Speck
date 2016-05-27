Speck
========

_A tiny, Linux-compatible, pure-Swift BDD framework for Swift projects.
(insert bird-pun)_

**Current Version:** 0.0.1

[Documentation](Docs/00-main.md) | [Quick Start](Docs/02-running.md) | [Example Project](https://github.com/bppr/Speck.Example)

### Features
* easy-to-extend core testing framework.
* minimalistic, Swift 3-friendly API inspired by RSpec and Jasmine
* customizable / configurable reporters
* hooks for tests: `before`, and `after` (`around` coming soon!)
* a wide variety of expectations for most Swift types and protocols
* zero dependencies: just libC and Swift

```swift
let ExampleSpec = describe("testing with Speck") {
  it("makes testing simple and easy") {
    expect(testing).to(equal: "fun")
  }
}
```
