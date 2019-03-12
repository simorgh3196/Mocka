public protocol Verification {
    associatedtype Mocking: Mock where Mocking.Verifying == Self

    var mock: Mocking { get }
    var call: CallMatcher { get }
    var sourceLocation: (file: StaticString, line: UInt) { get }

    init(mock: Mocking, call: CallMatcher, file: StaticString, line: UInt)
}

public class VerificationMethod<Mocking: Mock, Input, Output> {

    let mock: Mocking
    let identifier: String
    let input: Input

    init(mock: Mocking, identifier: String, input: Input) {
        self.mock = mock
        self.identifier = identifier
        self.input = input

        // verify function
    }
}

public class VerificationProperty<Mocking: Mock, T> {

    let mock: Mocking
    let identifier: String

    init(mock: Mocking, identifier: String) {
        self.mock = mock
        self.identifier = "\(Mocking.identifier).\(identifier)"
    }

    @discardableResult
    func get() -> VerificationMethod<Mocking, Void, T> {
        return VerificationMethod(mock: mock, identifier: identifier + "#get", input: ())
    }

    @discardableResult
    func set(_ value: T) -> VerificationMethod<Mocking, T, Void> {
        return VerificationMethod(mock: mock, identifier: identifier + "#set", input: value)
    }
}
