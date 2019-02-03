import SwiftSyntax

protocol Translator {
    associatedtype Syntax
    associatedtype Entity

    func translate(syntax: Syntax) -> Entity
}

protocol ProtocolTranslator: Translator {
    func translate(syntax: ProtocolDeclSyntax) -> Protocol
}

protocol InitializerTranslator: Translator {
    func translate(syntax: InitializerDeclSyntax) -> Initializer
}

protocol VariableTranslator: Translator {
    func translate(syntax: VariableDeclSyntax) -> Variable
}
