struct Property: Variable, ContainerMember {
    var accessibility: Accessibility
    var name: String
    var type: String
    var isReadOnly: Bool
}

extension Property {
    init(accessibility: Accessibility?, name: String, type: String, isReadOnly: Bool) {
        self.accessibility = accessibility ?? .internal
        self.name = name
        self.type = type
        self.isReadOnly = isReadOnly
    }
}
