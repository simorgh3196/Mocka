public protocol Mock: class {
    associatedtype _MethodSignature
    static var identifier: String { get }
    var methodSignature: _MethodSignature { get }
    var stubMethodHolder: StubMethodHolder<Self> { get set }
}
