import Foundation

// MARK: - Stub

//public func stub<Mocking: Mock>(_ mock: Mocking, _ stubbing: ((Mocking.Stubbing) -> Void)) {
//    stubbing(mock.stub)
//}

// MARK: - Verification

//public func when<Mocking: Mock, Input, Output>(_ function: StubMethod<Mocking, Input, Output>) -> ThenStubAction<Mocking, Input, Output> {
//    return ThenStubAction(function: function)
//}
//
//public func verify<Mocking: Mock>(_ mock: Mocking, _ mode: VerificationMode = .times(1), file: StaticString = #file, line: UInt = #line) -> Mocking.Verifying {
//    return mock.createVerification(mode: mode, file: file, line: line)
//}

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
