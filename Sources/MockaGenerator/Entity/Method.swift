protocol Method {
    var accessibility: Accessibility { get }
    var name: String { get }
    var parameters: [FunctionParameter] { get }
    var returnType: String? { get }
    var throwType: ThrowClause { get }
}
