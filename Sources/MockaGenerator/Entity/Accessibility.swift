enum Accessibility: String {
    case `open` = "open"
    case `public` = "public"
    case `internal` = "internal"
    case `fileprivate` = "fileprivate"
    case `private` = "private"

    var isAccessible: Bool {
        return self != .private && self != .fileprivate
    }
}

extension Accessibility: CustomStringConvertible {
    var description: String {
        return "." + rawValue
    }
}
