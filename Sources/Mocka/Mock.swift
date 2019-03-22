public protocol Mock: class {
    associatedtype Stubbing: Stub
    associatedtype Verifying: Verification
    static var identifier: String { get }
    var stub: Stubbing { get }
    func createVerification(mode: VerificationMode, file: StaticString, line: UInt) -> Verifying
}
