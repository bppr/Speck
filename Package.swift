import PackageDescription

let package = Package(
	name: "Speck",
	targets: [
		Target(name: "SpeckCore"),

		Target(name: "SpeckAsserts", dependencies: [
			.Target(name: "SpeckCore")
		]),

		Target(name: "Speck", dependencies: [
			.Target(name: "SpeckCore"),
			.Target(name: "SpeckAsserts")
		])
	]
)
