public class ParameterMatcher<T>: ParameterMatchable {

    public typealias MatchedType = T
    public typealias Matcher = (T) -> Bool

    let matcher: Matcher

    init(matcher: @escaping Matcher) {
        self.matcher = matcher
    }

    init<M: ParameterMatchable>(matchable: M) where M.MatchedType == MatchedType {
        self.matcher = matchable.match(with:)
    }

    public func match(with parameter: T) -> Bool {
        return matcher(parameter)
    }

    public func combine<M: ParameterMatchable>(_ matcher: M, _ filter: @escaping ((T) -> M.MatchedType)) -> ParameterMatcher<T> {
        return ParameterMatcher { self.match(with: $0) && matcher.match(with: filter($0)) }
    }

    public static func combine<M: ParameterMatchable>(_ matcher: M, _ filter: @escaping ((T) -> M.MatchedType)) -> ParameterMatcher<T> {
        return ParameterMatcher { matcher.match(with: filter($0)) }
    }
}

public extension ParameterMatchable {

    public func or<M: ParameterMatchable>(_ other: M) -> ParameterMatcher<MatchedType> where M.MatchedType == MatchedType {
        return ParameterMatcher { self.match(with: $0) || other.match(with: $0) }
    }

    public func and<M: ParameterMatchable>(_ other: M) -> ParameterMatcher<MatchedType> where M.MatchedType == MatchedType {
        return ParameterMatcher { self.match(with: $0) && other.match(with: $0) }
    }
}
