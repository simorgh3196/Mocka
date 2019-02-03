struct Protocol: Container {
    var name: String
    var accessibility: Accessibility
    var members: [ContainerMember]
}

extension Protocol {
    init(name: String) {
        self.name = name
        accessibility = .internal
        members = []
    }

    var initializers: [Initializer] {
        return members.compactMap { $0 as? Initializer }
    }

    var staticProperties: [StaticProperty] {
        return members.compactMap { $0 as? StaticProperty }
    }

    var staticMethods: [StaticMethod] {
        return members.compactMap { $0 as? StaticMethod }
    }

    var properties: [Property] {
        return members.compactMap { $0 as? Property }
    }

    var methods: [InstanceMethod] {
        return members.compactMap { $0 as? InstanceMethod }
    }
}

extension Protocol: Equatable {
    static func == (lhs: Protocol, rhs: Protocol) -> Bool {
        return lhs.name == rhs.name
    }
}
