public enum CallMatcher {
    case never
    case times(UInt)
    case atLeast(UInt)
    case atMost(UInt)
}

extension CallMatcher: Matchable {

    public func match(with parameter: UInt) -> Bool {
        switch self {
        case .never:
            return parameter == 0
        case .times(let count):
            return parameter == count
        case .atLeast(let count):
            return parameter >= count
        case .atMost(let count):
            return parameter <= count
        }
    }
}
