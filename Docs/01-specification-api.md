Specification API
==================

### `describe`
Create a test suite by using `describe`, with a description of the code it's
testing. You can create as many nested `describe` blocks as you'd like.

```swift
let MyProjectSpec = describe("MyProject") {
  describe("doSomething()") {
    describe("when it is daytime") {
      // and so forth
    }
  }
}
```

Of course that's not very useful by itself, so we can add some examples to it
using...

### `it`
Add an example to the parent suite using `it`

```swift
let MyProjectSpec = describe("MyProject") {
  it("does something cool") {
    expect(MyProject.doSomething()).to(equal: 42)
  }
}
```

_note: examples do not nest_

### `before`
Use this to run setup code before each example

```swift
let MyProjectSpec = describe("MyProject") {
  var someValue = "some-default"

  before {
    someValue = "overridden"
  }

  it("sets someValue to 'overridden'") {
    expect(someValue).to(equal: 'overridden')
  }
}
```

### `after`
Use this to run teardown or cleanup code after each example

```swift
let MyProjectSpec = describe("MyProject") {
  before { someValue = "overridden" }
  after { someValue = "some-default" }
}
```
