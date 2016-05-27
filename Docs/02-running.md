Running Tests
=============

#### _Important: `Speck` is meant to be used with Swift 3 projects._

If you don't know which version of Swift you have, `swift --version` should tell
you. If you don't see `3.0-dev` (or, `3.0`) somewhere in the output, head
to [swift.org](https://swift.org/download) to get the latest and greatest.

### Using SwiftPM

Speck uses the Swift Package Manager to define and run test targets (for now).
(note that Speck itself doesn't have any XCode or XCTest compatibility built-in)

Step 0 is adding Speck to your SwiftPM `dependencies` and running `swift build`

##### Step 1: Creating Test Targets
You can create test targets by creating a new folder inside your `Sources`
directory, calling it whatever you want.

Next, add the target to your SwiftPM project:

```swift
import PackageDescription

let package = Package(
  name: "MyCoolApp",
  // whatever
  targets: [
    .Target(name: "MyCoolLibrary"),
    .Target(name: "<your-spec-folder-name-here>", dependencies: [
      .Target(named: "MyCoolLibrary")
    ])
  ]
)
```

##### Step 2: Adding some test files

Now, we can't build it until we add some test files:

```swift
// in Sources/<my-spec-target>/FirstSpec.swift
import Speck

let FirstSpec = describe("addition") {
  it("adds the first number to the second") {
    expect(2 + 2).to(equal: 4)
  }
}

// in Sources/<my-spec-target>/SecondSpec.swift
import Speck

let SecondSpec = describe("subtraction") {
  it("subtracts the first number to the second") {
    expect(2 - 2).to(equal: 0)
  }
}
```

Excellent. So now we have two test files that "define" specs. All we need is
a `main` file that will run them!

##### Step 3: Creating a `main.swift`

```swift
// in Sources/<my-spec-target>/main.swift
import Speck

Speck.register([FirstSpec, SecondSpec])
Speck.Reporter.listen(reporter)
try Speck.run()
```

##### Step 4: Build and Run!

Use `swift build` to build the tests, and then run them by executing your target in the `.build/Debug` folder.
