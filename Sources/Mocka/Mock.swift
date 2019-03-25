public protocol Mock: class {
    associatedtype _MethodSignature: MethodSignature<Self>
    static var identifier: String { get }
}
