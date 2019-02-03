protocol Function {
    var accessibility: Accessibility { get }
    var name: String { get }
    var parameters: [FunctionParameter] { get }
    var returnSignature: String { get }
}
