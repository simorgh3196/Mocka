protocol Variable {
    var accessibility: Accessibility { get }
    var name: String { get }
    var type: String { get }
    var isReadOnly: Bool { get }
}
