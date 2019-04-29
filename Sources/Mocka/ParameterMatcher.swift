public class ParameterMatcher<T>: Matchable {

    public typealias MatchedType = T
    public typealias Matcher = (T) -> Bool

    let matcher: Matcher

    init(matcher: @escaping Matcher) {
        self.matcher = matcher
    }

    init<M: Matchable>(matchable: M) where M.MatchedType == MatchedType {
        self.matcher = matchable.match(with:)
    }

    public func match(with parameter: T) -> Bool {
        return matcher(parameter)
    }

    public func combine<M: Matchable>(_ matcher: M, _ filter: @escaping ((T) -> M.MatchedType)) -> ParameterMatcher<T> {
        return ParameterMatcher { self.match(with: $0) && matcher.match(with: filter($0)) }
    }

    public static func combine<M: Matchable>(_ matcher: M, _ filter: @escaping ((T) -> M.MatchedType)) -> ParameterMatcher<T> {
        return ParameterMatcher { matcher.match(with: filter($0)) }
    }
}

public extension Matchable {

    func or<M: Matchable>(_ other: M) -> ParameterMatcher<MatchedType> where M.MatchedType == MatchedType {
        return ParameterMatcher { self.match(with: $0) || other.match(with: $0) }
    }

    func and<M: Matchable>(_ other: M) -> ParameterMatcher<MatchedType> where M.MatchedType == MatchedType {
        return ParameterMatcher { self.match(with: $0) && other.match(with: $0) }
    }
}
