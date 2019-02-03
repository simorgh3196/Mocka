struct Initializer: ContainerMember {
    let attributes: [String]
    let accessibility: Accessibility
    let parameters: [FunctionParameter]
    let isThrows: Bool
    let isFailable: Bool
    let isRequired: Bool
}
