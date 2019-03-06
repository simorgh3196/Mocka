public protocol Mock {
    associatedtype Stubbing: Stub
    associatedtype Verifying: Verification
    static var identifier: String { get }
    var stub: Stubbing { get }
    var verification: Verifying { get }
}
