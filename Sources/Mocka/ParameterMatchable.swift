public protocol ParameterMatchable {
    associatedtype MatchedType
    func match(with parameter: MatchedType) -> Bool
}

public extension ParameterMatchable where Self: Equatable {

    public func match(with parameter: Self) -> Bool {
        return self == parameter
    }
}

extension Int: ParameterMatchable {}
extension Int8: ParameterMatchable {}
extension Int16: ParameterMatchable {}
extension Int32: ParameterMatchable {}
extension Int64: ParameterMatchable {}
extension UInt: ParameterMatchable {}
extension UInt8: ParameterMatchable {}
extension UInt16: ParameterMatchable {}
extension UInt32: ParameterMatchable {}
extension UInt64: ParameterMatchable {}
extension Float: ParameterMatchable {}
extension Double: ParameterMatchable {}
extension Character: ParameterMatchable {}
extension String: ParameterMatchable {}
extension Bool: ParameterMatchable {}
extension Range: ParameterMatchable {
    public func match(with parameter: Bound) -> Bool {
        return self.contains(parameter)
    }
}
