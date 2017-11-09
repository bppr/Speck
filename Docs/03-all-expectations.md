Expectations
============

Speck comes with a variety of expectations. Most expectations are based on some
sort of Swift protocol value -- `Equatable`, `Comparable`, `Sequence`,
`Collection`, and so on. This means that if your code implements these protocols,
Speck will automatically know how to assert against it.

There are also some specific expectations for Swift's less-basic types: `Array`,
`String`, and `Dictionary` to be exact have some convenience expectations built
in.

_Note: All expectations are negate-able using `not`:_
```swift
expect("a-thing").not.to(equal: "another-thing")
```

### Equatable
#### `equal`

A simple equality-check for types implementing the `Equatable` protocol. Works
for both optional and non-optional values.

```swift
expect(someValue).to(equal: anotherValue)
expect(someValue).to(equal: nil)
```

(_note: Swift's `Array` and `Dictionary` types both also have special-cased
calls to `equal` and work exactly like scalar values do_)

### Comparable
Comparison checks for types implementing the `Comparable` protocol.

#### `beGreaterThan` / `beLessThan`

Assert that an object is greater or less than the given value.

```swift
expect(3.14).to(beGreaterThan: 3.13)
expect(3.14).to(beLessThan: 3.15)
```

#### `beGreaterThanOrEqual` / `beLessThanOrEqual`

Assert that an object is greater/less than or equal to the given value.

```swift
expect(3.14).to(beGreaterThanOrEqual: 3.13)
expect(3.14).to(beLessThanOrEqual: 3.15)
```


### Sequence
#### `contain`

Assert that a sequence contains an element.

```swift
let set: Set<Int> = [1, 2]

expect(set).to(contain: 1)
expect(set).to(contain: 2)
```


### Collection
#### `startWith`

Assert that a collection starts with an element

```swift
expect([1, 2, 3]).to(startWith: 1)
```

#### `endWith`
If the collection is a `BidirectionalCollection`, you can also assert that
it ends with an element


```swift
expect([1, 2, 3]).to(startWith: 3)
```

### String
#### `startWith`
Assert that a string starts with another string

```swift
expect("horse-battery-staple").to(startWith: "horse")
```

#### `endWith`
Assert that a string ends with another string

```swift
expect("horse-battery-staple").to(endWith: "staple")
```

#### `contain`
Assert that a string contains another string

```swift
expect("horse-battery-staple").to(contain: "battery")
```

### Dictionary
#### `haveKey`
Assert that a dictionary contains the given key

```swift
expect(["a-key": "a-value"]).to(haveKey: "a-key")
```

#### `haveValue`
Assert that a dictionary contains the given value

```swift
expect(["a-key": "a-value"]).to(haveValue: "a-value")
```

#### `contain`
Assert that a dictionary contains the given key-value pair

```swift
expect(["a-key": "a-value"]).to(contain: ("a-key", "a-value"))
```

### Void Functions

#### `throwError`
There are two versions of tests for error throwing: one is member-wise and the
other is based on a type:

```swift
// we can assert directly on the contents of an error
expect {
  try doSomethingDangerous()
}.to(throwError: MyErrors.BadThing(msg: "Oh no"))

// or just catch the error's type
expect { try doSomethingDangerous() }.to(throwError: MyErrors.self)
```

#### `change`
Assert that the given value has changed to another value

```swift
var a = 0

expect { a += 1 }.to(change: a, by: 1)
expect { a += 1 }.to(change: a, from: 1, to: 2)
```
