func test() {
    let mock = MockHoge()

    when(invoke(mock).fuga(arg: "fuga"))
        .then(return: 13)
        .then(return: 25)

    verify(invoke(mock).fuga(arg: "hoge"), .times(2))
}

class Hoge {
    var variable: String = ""
    func hoge() {}
    func fuga(arg: String) -> Int { return arg.count }
    func fuga(arg: Bool) -> Int { return 1 }
    func piyo<T: Equatable>(arg: T) -> String { return "" }
    func eat(name: String, count: Int) {}
    func function(a1: String, a2: Int, a3: Bool) {}
}

final class MockHoge: Hoge, Mock {
    typealias Mocking = MockHoge

    static var identifier = "Hoge"
    let stubMethodHolder = StubMethodHolder<MockHoge>()
    lazy var methodSignature = MockHoge._MethodSignature(mock: self)

    class _MethodSignature {

        weak var mock: MockHoge!

        init(mock: MockHoge) {
            self.mock = mock
        }

        func get<T>(_ keypath: KeyPath<Mocking, T>) -> MethodSignature<Mocking, Void, T>
        {
            return MethodSignature(mock: mock, identifier: keypath, matcher: any())
        }

        func set<M, T>(_ keypath: WritableKeyPath<Mocking, T>, value: M) -> MethodSignature<Mocking, T, Void>
            where
            M: Matchable, T == M.MatchedType
        {
            return MethodSignature(mock: mock, identifier: keypath, matcher: ParameterMatcher(matchable: value))
        }

        func hoge() ->  MethodSignature<Mocking, Void, Void>
        {
            return MethodSignature(mock: mock, identifier: "hoge() -> Void", matcher: any())
        }

        func fuga<M1>(arg m1: M1) -> MethodSignature<Mocking, String, Int>
            where
            M1: Matchable, M1.MatchedType == String
        {
                let matcher = ParameterMatcher(matchable: m1)
                return MethodSignature(mock: mock, identifier: "fuga(arg: String) -> Int", matcher: matcher)
        }

        func fuga<M1>(arg m1: M1) -> MethodSignature<Mocking, Bool, Int>
            where
            M1: Matchable, M1.MatchedType == Bool
        {
            let matcher = ParameterMatcher(matchable: m1)
            return MethodSignature(mock: mock, identifier: "fuga(arg: Bool) -> Int", matcher: matcher)
        }

        func piyo<M1, T>(arg m1: M1) -> MethodSignature<Mocking, T, String>
            where
            M1: Matchable, M1.MatchedType == T,
            T: Equatable
        {
            let matcher = ParameterMatcher(matchable: m1)
            return MethodSignature(mock: mock, identifier: "piyo<T: Equatable>(arg: T) -> Int", matcher: matcher)
        }

        func eat<M1, M2>(name m1: M1, count m2: M2) -> MethodSignature<Mocking, (String, Int), Void>
            where
            M1: Matchable, M1.MatchedType == String,
            M2: Matchable, M2.MatchedType == Int
        {
            let combinedMatcher = ParameterMatcher<(String, Int)>
                .combine(m1) { $0.0 }
                .combine(m2) { $0.1 }
            return MethodSignature(mock: mock, identifier: "eat(name: String, count: Int) -> Void", matcher: combinedMatcher)
        }

        func function<M1, M2, M3>(a1 m1: M1, a2 m2: M2, a3 m3: M3) -> MethodSignature<Mocking, (String, Int, Bool), Void>
            where
            M1: Matchable, M1.MatchedType == String,
            M2: Matchable, M2.MatchedType == Int,
            M3: Matchable, M3.MatchedType == Bool
        {
            let combinedMatcher = ParameterMatcher<(String, Int, Bool)>
                .combine(m1) { $0.0 }
                .combine(m2) { $0.1 }
                .combine(m3) { $0.2 }
            return MethodSignature(mock: mock, identifier: "eat(name: String, count: Int) -> Void", matcher: combinedMatcher)
        }
    }

    class _ThrowableMethodSignature {
    }
}
