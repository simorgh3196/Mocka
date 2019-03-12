// MARK: - Mocks generated by Mocka
// Don't edit this file

import Mocka
@testable import Mocka

func test() {
    let mock = MockSimpleProtocol()

    stub(mock) { stub in
        when(stub.readWriteProperty.get)
                .thenReturn(10)
                .thenReturn(10)
                .thenReturn { 10 * 20 }
    }

    verify(mock).readWriteProperty.get()
}

class MockSimpleProtocol: SimpleProtocol, Mock {
    static let identifier: String = "SimpleProtocol"
    lazy var stub = Stubbing(mock: self)
    lazy var verification = Verifying(mock: self)

    var readWriteProperty: Int = 0
    var optionalProperty: Int? = 0
    func noReturn() {}
    func withParam(_ param: String, param2: String) -> Int {
        // status
        fatalError()
    }

    class Stubbing: Stub {

        let mock: MockSimpleProtocol

        init(mock: MockSimpleProtocol) {
            self.mock = mock
        }

        var readWriteProperty: StubProperty<MockSimpleProtocol, Int> {
            return StubProperty(mock: mock, identifier: "readWriteProperty")
        }

        var optionalProperty: StubProperty<MockSimpleProtocol, Int?> {
            return StubProperty(mock: mock, identifier: "optionalProperty")
        }

        func noReturn() -> StubMethod<MockSimpleProtocol, Void, Void> {
            return StubMethod(
                mock: mock,
                identifier: "noReturn()",
                input: ()
            )
        }

        func withParam<M1: Matchable, M2: Matchable>(_ param: M1, param2: M2) -> StubMethod<MockSimpleProtocol, (M1, M2), Int>
                where M1.MatchedType == String, M2.MatchedType == String
        {
            return StubMethod(
                mock: mock,
                identifier: "withParam(_ param: String, param2: String) -> Int",
                input: (param, param2)
            )
        }
    }

    class Verifying: Verification {

        let mock: MockSimpleProtocol

        init(mock: MockSimpleProtocol) {
            self.mock = mock
        }

        var readWriteProperty: VerificationProperty<MockSimpleProtocol, Int> {
            return VerificationProperty(mock: mock, identifier: "readWriteProperty")
        }

        var optionalProperty: VerificationProperty<MockSimpleProtocol, Int?> {
            return VerificationProperty(mock: mock, identifier: "optionalProperty")
        }

        @discardableResult
        func noReturn() -> VerificationMethod<MockSimpleProtocol, Void, Void> {
            return VerificationMethod(
                    mock: mock,
                    identifier: "noReturn()",
                    input: ()
            )
        }

        @discardableResult
        func withParam<M1: Matchable, M2: Matchable>(_ param: M1, param2: M2) -> VerificationMethod<MockSimpleProtocol, (M1, M2), Int>
                where M1.MatchedType == String, M2.MatchedType == String
        {
            return VerificationMethod(
                    mock: mock,
                    identifier: "withParam(_ param: String, param2: String) -> Int",
                    input: (param, param2)
            )
    }
}
