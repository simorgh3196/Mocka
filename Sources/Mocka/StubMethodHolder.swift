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
        let matchedStubMethods = stubMethods.filter { $0.matcher.match(with: input) }
        guard !matchedStubMethods.isEmpty else {
            fatalError("method not stubbed for parameters: \(input)")
        }
        let matchedStubMethod = matchedStubMethods.first { !$0.invoked } ?? matchedStubMethods.last!

        return matchedStubMethod.invoke(with: input)
    }
}
