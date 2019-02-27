// Protocols

public protocol Mock {
    associatedtype Stubbing: Stub
    associatedtype Verificating: Verification
    static var identifier: String { get }
    var stub: Stubbing { get }
    var verification: Verificating { get }
}

public protocol Stub {
    associatedtype Mocking: Mock where Mocking.Stubbing == Self
    var mock: Mocking { get }
}

public protocol Verification {
    associatedtype Mocking: Mock where Mocking.Verificating == Self
    var mock: Mocking { get }
}

public class StubFunction<M: Mock, Input, Output> {

    let mock: M
    let identifier: String
    let input: Input

    init(mock: M, identifier: String, input: Input) {
        self.mock = mock
        self.identifier = identifier
        self.input = input
    }
}

public class StubProperty<M: Mock, T> {

    let mock: M
    let identifier: String

    init(mock: M, identifier: String) {
        self.mock = mock
        self.identifier = "\(M.identifier).\(identifier)"
    }

    var get: StubFunction<M, Void, T> {
        return StubFunction(mock: mock, identifier: identifier + "#get", input: ())
    }

    func set(_ value: T) -> StubFunction<M, T, Void> {
        return StubFunction(mock: mock, identifier: identifier + "#set", input: value)
    }
}

public class Then<M: Mock, Input, Output> {

    private let function: StubFunction<M, Input, Output>

    init(function: StubFunction<M, Input, Output>) {
        self.function = function
    }

    @discardableResult
    func thenDoNothing() -> Then<M, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    func thenDo(_ action: ((Input) -> Void)) -> Then<M, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    func thenReturn(_ output: Output) -> Then<M, Input, Output> {
        // save action
        return self
    }

    @discardableResult
    func thenReturn(_ action: (Input) -> Output) -> Then<M, Input, Output> {
        // save action
        return self
    }
}

class StubAction<M: Mock, Input, Output> {
    private init() {}

    static func doNothing() -> StubAction<M, Input, Output> {
        return StubAction()
    }

    static func `do`(_ closure: (Input) -> Output) -> StubAction<M, Input, Output> {
        return StubAction()
    }

    static func `return`(_ output: Output) -> StubAction<M, Input, Output> {
        return StubAction()
    }
}

// Functions

public func stub<M: Mock>(_ mock: M, _ stubbing: ((M.Stubbing) -> Void)) {
    stubbing(mock.stub)
}

public func when<M, Input, Output>(_ function: StubFunction<M, Input, Output>) -> Then<M, Input, Output> {
    return Then(function: function)
}

public func verify<M: Mock>(_ mock: M, times: UInt = 1) -> M.Verificating {
    return mock.stub
}
