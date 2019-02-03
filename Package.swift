// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Mocka",
    products: [
        .library(name: "Mocka", targets: ["Mocka"]),
        .library(name: "MockaGenerator", targets: ["MockaGenerator"]),
        .executable(name: "mocka", targets: ["MockaCommand"])
    ],
    dependencies: [
        .package(url: "https://github.com/Carthage/Commandant.git", .upToNextMajor(from: "0.15.0")),
        .package(url: "https://github.com/apple/swift-syntax.git", .upToNextMajor(from: "0.40200.0")),
        .package(url: "https://github.com/SwiftGen/StencilSwiftKit.git", .upToNextMajor(from: "2.7.2"))
    ],
    targets: [
        .target(name: "Mocka"),
        .target(name: "MockaGenerator", dependencies: [
            "SwiftSyntax",
            "StencilSwiftKit"
            ]),
        .target(name: "MockaCommand", dependencies: [
            "Commandant",
            "MockaGenerator"
            ]),
        .testTarget(name: "MockaTests", dependencies: ["Mocka"]),
        .testTarget(name: "MockaGeneratorTests", dependencies: ["MockaGenerator", "Mocka"]),
        .testTarget(name: "MockaCommandTests", dependencies: ["MockaCommand", "MockaGeneratorTests"])
    ]
)
