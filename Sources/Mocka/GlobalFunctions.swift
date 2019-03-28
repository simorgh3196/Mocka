import Foundation

// MARK: - Stub

//@discardableResult
//public func when<Mocking: Mock>(_ mock: Mocking, invoke signature: Mocking._MethodSignature) -> StubAction<Mocking, {
//}

// MARK: - Verification

public func verify<Mocking: Mock>(_ mock: Mocking, invoked signature: Mocking._MethodSignature, _ mode: VerificationMode = .once, file: StaticString = #file, line: UInt = #line) {
}

public func verifyNoMoreInteractions<Mocking: Mock>(_ mock: Mocking, file: StaticString = #file, line: UInt = #line) {
}

public func verifyZeroInteractions<Mocking: Mock>(_ mock: Mocking, file: StaticString = #file, line: UInt = #line) {
}

// MARK: - ParameterMatcher

public func any<T>() -> ParameterMatcher<T> {
    return ParameterMatcher { _ in true }
}

public func equal<T: Equatable>(to value: T) -> ParameterMatcher<T> {
    return ParameterMatcher { parameter in
        parameter == value
    }
}

public func notEqual<T: Equatable>(to value: T) -> ParameterMatcher<T> {
    return ParameterMatcher { parameter in
        parameter != value
    }
}

public func equalNil<T>() -> ParameterMatcher<T?> {
    return ParameterMatcher<T?> { parameter in
        parameter == nil
    }
}

public func notEqualNil<T>() -> ParameterMatcher<T?> {
    return ParameterMatcher<T?> { parameter in
        parameter != nil
    }
}

public func match<T>(with matcher: @escaping ParameterMatcher<T>.Matcher) -> ParameterMatcher<T> {
    return ParameterMatcher(matcher: matcher)
}

public func range<T: Comparable>(of range: Range<T>) -> ParameterMatcher<T> {
    return ParameterMatcher(matcher: range.contains)
}

public func match(withRegexp pattern: String, options: NSRegularExpression.Options = []) -> ParameterMatcher<String> {
    return ParameterMatcher { parameter in
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return false
        }
        let matches = regex.matches(in: parameter, options: [], range: NSMakeRange(0, (parameter as NSString).length))
        return !matches.isEmpty
    }
}
