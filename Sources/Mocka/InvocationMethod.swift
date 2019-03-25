public class MethodSignature<Base> {

    public static func get(_ keypath: PartialKeyPath<Base>) -> MethodSignature<Base> {
        return .init()
    }

    public static func set<M: ParameterMatchable, T>(_ keypath: WritableKeyPath<Base, T>, value: M) -> MethodSignature<Base> where T == M.MatchedType {
        return .init()
    }
}
