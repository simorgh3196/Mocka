public typealias MethodIdentifier = AnyHashable

public class StubMethodHolder<Mocking: Mock> {
    public var methods: [MethodIdentifier: [StubMethod]]

    init() {
        methods = [:]
    }

    func register<Input, Output>(stub: ConcreateStubMethod<Mocking, Input, Output>) {
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
        guard let matchedStubMethod = stubMethods.first(where: { $0.matcher.match(with: input) }) else {
            fatalError("method not stubbed for parameters: \(input)")
        }

        return matchedStubMethod.invoke(with: input)
    }
}

public protocol StubMethod {
}

public class ConcreateStubMethod<Mocking: Mock, Input, Output>: StubMethod {
    public let identifier: MethodIdentifier
    public let matcher: ParameterMatcher<Input>
    public let action: (Input) -> Output
    public var invocationCount: Int
    public var isVerified: Bool

    public init(identifier: MethodIdentifier, matcher: ParameterMatcher<Input>, action: @escaping ((Input) -> Output)) {
        self.identifier = identifier
        self.matcher = matcher
        self.action = action
        self.invocationCount = 0
        self.isVerified = false
    }

    func invoke(with input: Input) -> Output {
        invocationCount += 1 // TODO: Thread safe
        return action(input)
    }

    func verify(count: Int) {
        isVerified = true
    }
}
