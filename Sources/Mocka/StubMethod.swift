public typealias MethodIdentifier = AnyHashable

public protocol StubMethod {
}

public class ConcreateStubMethod<Mocking: Mock, Input, Output>: StubMethod {
    public let identifier: MethodIdentifier
    public let matcher: ParameterMatcher<Input>
    public let action: (Input) -> Output
    public var invocationCount: Int
    public var isVerified: Bool

    public var invoked: Bool {
        return invocationCount != 0
    }

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
