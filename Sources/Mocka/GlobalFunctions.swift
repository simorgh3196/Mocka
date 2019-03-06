// MARK: - Stub

public func stub<Mocking: Mock>(_ mock: Mocking, _ stubbing: ((Mocking.Stubbing) -> Void)) {
    stubbing(mock.stub)
}

// MARK: - Verification

public func when<Mocking: Mock, Input, Output>(_ function: StubFunction<Mocking, Input, Output>) -> ThenStubAction<Mocking, Input, Output> {
    return ThenStubAction(function: function)
}

public func verify<Mocking: Mock>(_ mock: Mocking, times: UInt = 1, file: StaticString = #file, line: UInt = #line) -> Mocking.Verifying {
    return mock.verification
}

// MARK: - ParameterMatcher

public func any<T>() -> ParameterMatcher<T> {
    return ParameterMatcher { _ in true }
}

public func equal<T: Equatable>(to parameter: T) -> ParameterMatcher<T> {
    return ParameterMatcher { $0 == parameter }
}

public func equal<T>(in matcher: @escaping ParameterMatcher<T>.Matcher) -> ParameterMatcher<T> {
    return ParameterMatcher(matcher: matcher)
}

public func range<T: Comparable>(of range: Range<T>) -> ParameterMatcher<T> {
    return ParameterMatcher(matcher: range.contains)
}
