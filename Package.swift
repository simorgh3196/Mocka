// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "SwiftMocka",
    products: [
        .library(name: "SwiftMocka", targets: ["SwiftMocka"]),
        .library(name: "SwiftMockaGenerator", targets: ["SwiftMockaGenerator"]),
        .executable(name: "mocka", targets: ["MockaCommand"])
    ],
    dependencies: [
        .package(url: "https://github.com/Carthage/Commandant.git", .exact("0.15.0")),
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.40200.0")),
        .package(url: "https://github.com/SwiftGen/StencilSwiftKit.git", .exact("2.7.2"))
    ],
    targets: [
        .target(name: "SwiftMocka"),
        .target(name: "SwiftMockaGenerator", dependencies: [
            "SwiftSyntax",
            "StencilSwiftKit"
            ]),
        .target(name: "MockaCommand", dependencies: [
            "Commandant",
            "SwiftMockaGenerator"
            ]),
        .testTarget(name: "SwiftMockaTests", dependencies: ["SwiftMocka"]),
        .testTarget(name: "SwiftMockaGeneratorTests", dependencies: ["SwiftMockaGenerator", "SwiftMocka"]),
        .testTarget(name: "MockaCommandTests", dependencies: ["MockaCommand", "SwiftMockaGeneratorTests"])
    ]
)
