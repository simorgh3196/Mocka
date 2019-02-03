enum ThrowClause: String {
    case noThrows = ""
    case `throws` = "throws"
    case `rethrows` = "rethrows"
}

extension ThrowClause: CustomStringConvertible {
    var description: String {
        switch self {
        case .noThrows:
            return ".noThrows"
        case .throws, .rethrows:
            return "." + rawValue
        }
    }
}
