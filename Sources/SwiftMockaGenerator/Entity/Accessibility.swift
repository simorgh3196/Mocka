enum Accessibility {
    case `open`, `public`, `internal`, `fileprivate`, `private`

    public var isAccessible: Bool {
        return self != .private && self != .fileprivate
    }
}
