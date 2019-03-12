public protocol Stub {
    associatedtype Mocking: Mock where Mocking.Stubbing == Self
    var mock: Mocking { get }
}

public class StubMethod<Mocking: Mock, Input, Output> {

    let mock: Mocking
    let identifier: String
    let input: Input

    public init(mock: Mocking, identifier: String, input: Input) {
        self.mock = mock
        self.identifier = identifier
        self.input = input
    }
}

public class StubProperty<Mocking: Mock, T> {

    let mock: Mocking
    let identifier: String

    public init(mock: Mocking, identifier: String) {
        self.mock = mock
        self.identifier = "\(Mocking.identifier).\(identifier)"
    }

    public var get: StubMethod<Mocking, Void, T> {
        return StubMethod(mock: mock, identifier: identifier + "#get", input: ())
    }

    public func set<M: Matchable>(_ parameter: M) -> StubMethod<Mocking, M, Void> where M.MatchedType == T {
        return StubMethod(mock: mock, identifier: identifier + "#set", input: parameter)
    }
}

class StubAction<Mocking: Mock, Input, Output> {
    private init() {}

    static func doNothing() -> StubAction<Mocking, Input, Output> {
        return StubAction()
    }

    static func `do`(_ closure: (Input) -> Output) -> StubAction<Mocking, Input, Output> {
        return StubAction()
    }

    static func `return`(_ output: Output) -> StubAction<Mocking, Input, Output> {
        return StubAction()
    }
}

public class ThenStubAction<Mocking: Mock, Input, Output> {

    private let function: StubMethod<Mocking, Input, Output>

    init(function: StubMethod<Mocking, Input, Output>) {
        self.function = function
    }

    @discardableResult
    public func thenDoNothing() -> ThenStubAction<Mocking, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    public func thenDo(_ action: ((Input) -> Void)) -> ThenStubAction<Mocking, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    public func thenReturn(_ output: Output) -> ThenStubAction<Mocking, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    public func thenReturn(_ action: (Input) -> Output) -> ThenStubAction<Mocking, Input, Output> {
        // save action
        return self
    }
}
