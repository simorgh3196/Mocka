public protocol MethodSignature {
    var identifier: MethodIdentifier { get }
}

public class ConcreateMethodSignature<Base, Input, Output>: MethodSignature {
    public let identifier: MethodIdentifier
    public let parameterMathcers: [ParameterMatchable]

    init(identifier: MethodIdentifier, parameterMatchers: [ParameterMatchable]) {
        self.identifier = identifier
        self.parameterMatchers = parameterMatchers
    }
}

extension MethodSignature {

    public static func get(_ keypath: PartialKeyPath<Base>) -> MethodSignature<Base> {
        return .init()
    }

    public static func set<M: ParameterMatchable, T>(_ keypath: WritableKeyPath<Base, T>, value: M) -> MethodSignature<Base> where T == M.MatchedType {
        return .init()
    }
}
