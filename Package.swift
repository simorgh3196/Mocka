// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Mocka",
    products: [
        .library(name: "Mocka", targets: ["Mocka"]),
        .executable(name: "mocka", targets: ["MockaGenerator"])
    ],
    dependencies: [
        .package(url: "https://github.com/Carthage/Commandant.git", .exact("0.15.0")),
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.40200.0")),
        .package(url: "https://github.com/SwiftGen/StencilSwiftKit.git", .exact("2.7.2"))
    ],
    targets: [
        .target(name: "Mocka"),
        .target(name: "MockaGenerator", dependencies: [
            "Commandant",
            "SwiftSyntax",
            "StencilSwiftKit"
            ]),
        .testTarget(name: "MockaTests", dependencies: ["Mocka"]),
        .testTarget(name: "MockaGeneratorTests")
    ]
)
