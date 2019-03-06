public protocol Stub {
    associatedtype Mocking: Mock where Mocking.Stubbing == Self
    var mock: Mocking { get }
}

public class StubFunction<Mocking: Mock, Input, Output> {

    let mock: Mocking
    let identifier: String
    let input: Input

    init(mock: Mocking, identifier: String, input: Input) {
        self.mock = mock
        self.identifier = identifier
        self.input = input
    }
}

public class StubProperty<Mocking: Mock, T> {

    let mock: Mocking
    let identifier: String

    init(mock: Mocking, identifier: String) {
        self.mock = mock
        self.identifier = "\(Mocking.identifier).\(identifier)"
    }

    var get: StubFunction<Mocking, Void, T> {
        return StubFunction(mock: mock, identifier: identifier + "#get", input: ())
    }

    func set(_ value: T) -> StubFunction<Mocking, T, Void> {
        return StubFunction(mock: mock, identifier: identifier + "#set", input: value)
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

    private let function: StubFunction<Mocking, Input, Output>

    init(function: StubFunction<Mocking, Input, Output>) {
        self.function = function
    }

    @discardableResult
    func thenDoNothing() -> ThenStubAction<Mocking, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    func thenDo(_ action: ((Input) -> Void)) -> ThenStubAction<Mocking, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    func thenReturn(_ output: Output) -> ThenStubAction<Mocking, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    func thenReturn(_ action: (Input) -> Output) -> ThenStubAction<Mocking, Input, Output> {
        // save action
        return self
    }
}
