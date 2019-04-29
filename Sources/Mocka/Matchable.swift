public protocol Matchable {
    associatedtype MatchedType
    func match(with parameter: MatchedType) -> Bool
}

public extension Matchable where Self: Equatable {

    func match(with parameter: Self) -> Bool {
        return self == parameter
    }
}

extension Int: Matchable {}
extension Int8: Matchable {}
extension Int16: Matchable {}
extension Int32: Matchable {}
extension Int64: Matchable {}
extension UInt: Matchable {}
extension UInt8: Matchable {}
extension UInt16: Matchable {}
extension UInt32: Matchable {}
extension UInt64: Matchable {}
extension Float: Matchable {}
extension Double: Matchable {}
extension Character: Matchable {}
extension String: Matchable {}
extension Bool: Matchable {}
extension Range: Matchable {
    public func match(with parameter: Bound) -> Bool {
        return self.contains(parameter)
    }
}
