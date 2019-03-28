
public class Then<Mocking: Mock, Input, Output> {

    weak var mock: Mocking?

    init(mock: Mocking) {
        self.mock = mock
    }

    public func then(return value: Output) -> Then<Mocking, Input, Output> {
        // mock.register(stubAction: )
        return self
    }

    public func then(return action: ((Input) -> Output)) -> Then<Mocking, Input, Output> {
        // mock.register(stubAction: )
        return self
    }
}

public typealias MethodIdentifier = String

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
    public let parameterMatcher: ((Input) -> Bool)
    public let action: (Input) -> Output
    public var invocationCount: Int
    public var isVerified: Bool

    public init(identifier: MethodIdentifier, parameterMatcher: @escaping ((Input) -> Bool), action: @escaping (Input) -> Output) {
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




class Hoge {
    func hoge() {}
    func fuga(arg: String) -> Int { return arg.count }
    func fuga(arg: Bool) -> Int { return 1 }
    func piyo<T: Equatable>(arg: T) -> String { return "" }
}

final class MockHoge: Hoge, Mock {
    static var identifier = "Hoge"
    let stubMethodHolder = StubMethodHolder<MockHoge>()

    class _MethodSignature {

        func hoge() -> _MethodSignature {
            let method = ConcreateStubMethod(identifier: "hoge()", parameterMatcher: any(), action: <#T##(_) -> _#>)

            return .init()
        }

        func fuga<M1: ParameterMatchable>(arg: M1) -> _MethodSignature where M1.MatchedType == Bool {
            return .init()
        }

        func fuga<M1: ParameterMatchable, T>(arg: M1) -> _MethodSignature where M1.MatchedType == T {
            return .init()
        }
    }

    class _ThrowableMethodSignature {
    }
}
