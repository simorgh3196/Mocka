import Foundation

// Mocka:Protocol
protocol SimpleProtocol {

    var readWriteProperty: Int { get set }

    var optionalProperty: Int? { get set }

    func noReturn()

    func withParam(_ param1: String, param2: String) -> Int
}

// Mocka:Protocol
protocol NormalProtocol {

    init() throws

    init(labelA a: String, _ b: String, c: Int)

    var readOnlyProperty: String { get }

    var readWriteProperty: Int { get set }

    var optionalProperty: Int? { get set }

    static var staticReadOnlyProperty: String { get }

    static var staticReadWriteProperty: Int { get set }

    static var staticOptionalProperty: Int? { get set }

    func noReturn()

    func withThrows() throws -> Int

    func withNoReturnThrows() throws

    func withParam(_ param: String) -> Int

    func withClosure(_ closure: (String) -> Int) -> Int

    func withParamAndClosure(param: String, closure:(String) -> Int) -> Int

    func withEscapeClosure(closure: @escaping (String) -> Void)

    func withOptionalClosure(closure: ((String) -> Void)?)

    func withOptionalClosureAndReturn(closure: ((String) -> Void)?) -> Int

    func withLabelAndUnderscore(labelA a: String, _ b: String)

    func withNamedTuple(tuple: (a: String, b: String)) -> Int

    func withImplicitlyUnwrappedOptional(i: Int!) -> String

    static func staticNoReturn()

    static func staticWithThrows() throws -> Int

    static func staticWithNoReturnThrows() throws

    static func staticWithParam(_ param: String) -> Int

    static func staticWithClosure(_ closure: (String) -> Int) -> Int

    static func staticWithParamAndClosure(param: String, closure:(String) -> Int) -> Int

    static func staticWithEscapeClosure(closure: @escaping (String) -> Void)

    static func staticWithOptionalClosure(closure: ((String) -> Void)?)

    static func staticWithOptionalClosureAndReturn(closure: ((String) -> Void)?) -> Int

    static func staticWithLabelAndUnderscore(labelA a: String, _ b: String)

    static func staticWithNamedTuple(tuple: (a: String, b: String)) -> Int

    static func staticWithImplicitlyUnwrappedOptional(i: Int!) -> String
}

protocol SubProtocol: NormalProtocol {
}

@objc protocol ObjcProtocol {
    @objc optional func optionalMethod()
}

protocol SubNSObjectProtocol: NSObjectProtocol {
}
