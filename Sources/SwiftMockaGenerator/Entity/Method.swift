struct Method: Function, ContainerMember {
    let name: String
    let accessibility: Accessibility
    let parameters: [FunctionParameter]
    let returnSignature: String
}
