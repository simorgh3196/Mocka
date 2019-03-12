// MARK: - Stub

public func stub<Mocking: Mock>(_ mock: Mocking, _ stubbing: ((Mocking.Stubbing) -> Void)) {
    stubbing(mock.stub)
}

// MARK: - Verification

public func when<Mocking: Mock, Input, Output>(_ function: StubMethod<Mocking, Input, Output>) -> ThenStubAction<Mocking, Input, Output> {
    return ThenStubAction(function: function)
}

public func verify<Mocking: Mock, Verifying>(_ mock: Mocking, _ call: CallMatcher = .times(1), file: StaticString = #file, line: UInt = #line) -> Verifying where Verifying == Mocking.Verifying {
    return Verifying(mock: mock, call: call, file: file, line: line)
}

// MARK: - ParameterMatcher

public func any<T>() -> ParameterMatcher<T> {
    return ParameterMatcher { _ in true }
}

public func equal<T: Equatable>(to parameter: T) -> ParameterMatcher<T> {
    return ParameterMatcher { $0 == parameter }
}

public func notEqual<T: Equatable>(to parameter: T) -> ParameterMatcher<T> {
    return ParameterMatcher { $0 != parameter }
}

public func match<T>(with matcher: @escaping ParameterMatcher<T>.Matcher) -> ParameterMatcher<T> {
    return ParameterMatcher(matcher: matcher)
}

public func range<T: Comparable>(of range: Range<T>) -> ParameterMatcher<T> {
    return ParameterMatcher(matcher: range.contains)
}
