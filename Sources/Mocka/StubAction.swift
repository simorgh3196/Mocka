public class Then<Mocking: Mock, Input, Output> {

    let methodSignature: MethodSignature<Mocking, Input, Output>

    init(methodSignature: MethodSignature<Mocking, Input, Output>) {
        self.methodSignature = methodSignature
    }

    @discardableResult
    public func then(return value: Output) -> Then<Mocking, Input, Output> {
        let stub = ConcreateStubMethod<Mocking, Input, Output>(
            identifier: methodSignature.identifier,
            matcher: methodSignature.matcher,
            action: { _ in value }
        )
        methodSignature.mock?.stubMethodHolder.register(stub: stub)
        return self
    }

    @discardableResult
    public func then(return action: @escaping ((Input) -> Output)) -> Then<Mocking, Input, Output> {
        let stub = ConcreateStubMethod<Mocking, Input, Output>(
            identifier: methodSignature.identifier,
            matcher: methodSignature.matcher,
            action: action
        )
        methodSignature.mock?.stubMethodHolder.register(stub: stub)
        return self
    }
}

public typealias MethodIdentifier = AnyHashable

public struct StubMethodHolder<Mocking: Mock> {
    public var methods: [MethodIdentifier: [StubMethod]]

    init() {
        methods = [:]
    }

    mutating func register<Input, Output>(stub: ConcreateStubMethod<Mocking, Input, Output>) {
        let methodIdentifier = stub.identifier
        var stubs = methods[methodIdentifier] ?? []
        stubs.append(stub)
        methods[methodIdentifier] = stubs
    }

    func invoke<Input, Output>(_ identifier: MethodIdentifier, input: Input) -> Output {
        guard let stubs = methods[identifier] else {
            fatalError("method not stubbed")
        }
        guard let stubMethods = stubs as? [ConcreateStubMethod<MockHoge, Input, Output>] else {
            fatalError("method type is invalid")
        }
        guard var matchedStubMethod = stubMethods.first(where: { $0.parameterMatcher(input) }) else {
            fatalError("method not stubbed for parameters: \(input)")
        }

        return matchedStubMethod.invoke(with: input)
    }
}

public protocol StubMethod {
}

public struct ConcreateStubMethod<Mocking: Mock, Input, Output>: StubMethod {
    public let identifier: MethodIdentifier
    public let matcher: ParameterMatcher<Input>
    public let action: (Input) -> Output
    public var invocationCount: Int
    public var isVerified: Bool

    public init(identifier: MethodIdentifier, matcher: ParameterMatcher<Input>, action: @escaping ((Input) -> Output)) {
        self.identifier = identifier
        self.parameterMatcher = parameterMatcher
        self.action = action
        self.invocationCount = 0
        self.isVerified = false
    }

    mutating func invoke(with input: Input) -> Output {
        invocationCount += 1 // TODO: Thread safe
        return action(input)
    }

    mutating func verify(count: Int) {
        isVerified = true
    }
}
