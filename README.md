Speck
========

_A tiny, Linux-compatible, pure-Swift BDD framework for Swift projects.
(insert bird-pun)_

**Current Version:** 0.1.0 | Swift 4+

[Documentation](/Docs/00-main.md) | [Quick Start](/Docs/02-running.md) | [Example Project](https://github.com/bppr/Speck.Example)

### Features
* easy-to-extend core testing framework.
* minimalistic, Swift 3+-friendly API inspired by RSpec and Jasmine
* customizable / configurable reporters
* hooks for tests: `before`, and `after`
* a wide variety of expectations for most Swift types and protocols
* zero dependencies: just libC and Swift
* plays nicely with SwiftPM

```swift
let ExampleSpec = describe("testing with Speck") {
  it("makes testing expressive and fun") {
    expect(testing).to(equal: "fun")
  }
}
```
