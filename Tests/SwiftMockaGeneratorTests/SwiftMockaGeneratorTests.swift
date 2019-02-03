import XCTest
@testable import SwiftMockaGenerator

final class SwiftMockaGeneratorTests: XCTestCase {

    func testPrintToken() {
        let generator = SwiftMockaGenerator()

        let baseFilePath = "/Users/hayakawatomoya/go/src/github.com/simorgh3196/SwiftMocka"
        let path = URL(fileURLWithPath: baseFilePath + "/Tests/Resource/TargetSource/Protocols.swift")
        generator.printProtocols(filePath: path)
    }
}
