public class ParameterMatcher<T>: Matchable {

    public typealias MatchedType = T
    public typealias Matcher = (T) -> Bool

    let matcher: Matcher

    init(matcher: @escaping Matcher) {
        self.matcher = matcher
    }

    public func match(with parameter: T) -> Bool {
        return matcher(parameter)
    }
}

public extension Matchable {

    public func or<M: Matchable>(_ other: M) -> ParameterMatcher<MatchedType> where M.MatchedType == MatchedType {
        return ParameterMatcher { self.match(with: $0) || other.match(with: $0) }
    }

    public func and<M: Matchable>(_ other: M) -> ParameterMatcher<MatchedType> where M.MatchedType == MatchedType {
        return ParameterMatcher { self.match(with: $0) && other.match(with: $0) }
    }
}
