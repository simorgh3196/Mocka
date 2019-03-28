public protocol Mock: class {
    associatedtype _MethodSignature
    static var identifier: String { get }
    var stubMethodHolder: StubMethodHolder<Self> { get }
}
