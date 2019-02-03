struct InstanceMethod: Method, ContainerMember {
    var accessibility: Accessibility
    var name: String
    var parameters: [FunctionParameter]
    var returnType: String?
    var throwType: ThrowClause
}
