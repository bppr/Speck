// swift-tools-version:4.0
import PackageDescription

let package = Package(
	name: "Speck",
	products: [
		.library(name: "Speck", targets: ["Speck"])
	],
	targets: [
		.target(name: "SpeckCore"),
		.target(name: "SpeckAsserts", dependencies: [ "SpeckCore" ]),
		.target(name: "Speck", dependencies: [ "SpeckCore", "SpeckAsserts" ]),

		.testTarget(name: "SpeckCoreTests", dependencies: ["SpeckCore"]),
		.testTarget(name: "SpeckAssertsTests", dependencies: ["SpeckAsserts"])
	]
)
