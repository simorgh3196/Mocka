public class MethodSignature<Mocking: Mock, Input, Output> {

    weak var mock: Mocking?
    public let identifier: MethodIdentifier
    public let matcher: ParameterMatcher<Input>

    public init(mock: Mocking, identifier: MethodIdentifier, matcher: ParameterMatcher<Input>) {
        self.mock = mock
        self.identifier = identifier
        self.matcher = matcher
    }
}
