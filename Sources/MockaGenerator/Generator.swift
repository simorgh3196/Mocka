import Foundation
import SwiftSyntax

class MockaVisitor: SyntaxVisitor {

    var protocols = [Protocol]()
    var current: Protocol!

    override func visitPre(_ node: Syntax) {
        if let node = node as? ProtocolDeclSyntax {
            current = Protocol(name: node.identifier.text)
            print("\(current.name) {")
        }
    }

    override func visitPost(_ node: Syntax) {
        if node is ProtocolDeclSyntax {
            protocols.append(current)
            current = nil
            print("}")
        }
    }

    override func visit(_ node: VariableDeclSyntax) {
        super.visit(node)

        guard current != nil else { return }

        let accessibility = node.modifiers?.children
            .lazy
            .compactMap { $0 as? DeclModifierSyntax }
            .map { $0.name.text }
            .compactMap(Accessibility.init)
            .first
        let name = node.bindings
            .lazy
            .compactMap { $0.pattern as? IdentifierPatternSyntax }
            .first
            .map { $0.identifier.text }
        let type = node.bindings
            .lazy
            .compactMap { $0.typeAnnotation?.type }
            .first
            .map { "\($0)".trimmingCharacters(in: .whitespaces) }

        // for Protocol
        let isReadOnly = node.bindings
            .lazy
            .compactMap { $0.accessor?.accessorListOrStmtList as? AccessorListSyntax }
            .first?
            .count == 1

        let property = Property(
            accessibility: accessibility,
            name: name!,
            type: type!,
            isReadOnly: isReadOnly
        )
        print("  \(property)")

        current.members.append(property)
    }

    override func visit(_ node: InitializerDeclSyntax) {
        super.visit(node)

        guard current != nil else { return }

        let accessibility = node.modifiers?.children
            .lazy
            .compactMap { $0 as? DeclModifierSyntax }
            .map { $0.name.text }
            .compactMap(Accessibility.init)
            .first ?? .internal
        let params = node.parameters.children
            .lazy
            .compactMap { $0 as? FunctionParameterListSyntax }
            .first?
            .children
            .compactMap { $0 as? FunctionParameterSyntax }
            .compactMap {
                $0.secondName != nil
                    ? FunctionParameter(label: $0.firstName!.text, name: $0.secondName!.text, type: "\($0.type!)")
                    : FunctionParameter(label: nil, name: $0.firstName!.text, type: "\($0.type!)")
            } ?? []
        let isFailable = node.optionalMark != nil
        let isThrows = node.throwsOrRethrowsKeyword != nil

        let initializer = Initializer(
            attributes: [],
            accessibility: accessibility,
            parameters: params,
            isThrows: isThrows,
            isFailable: isFailable,
            isRequired: true
        )
        print("  \(initializer)")

        current.members.append(initializer)
    }

    override func visit(_ node: FunctionDeclSyntax) {
        super.visit(node)

        guard current != nil else { return }

        let accessibility = node.modifiers?.children
            .lazy
            .compactMap { $0 as? DeclModifierSyntax }
            .map { $0.name.text }
            .compactMap(Accessibility.init(rawValue:))
            .first ?? .internal
        let params = node.signature.input.parameterList
            .map {
                $0.secondName != nil
                    ? FunctionParameter(label: $0.firstName!.text, name: $0.secondName!.text, type: "\($0.type!)")
                    : FunctionParameter(label: nil, name: $0.firstName!.text, type: "\($0.type!)")
            }
        let returnType = node.signature.output.map { "\($0.returnType)" }
        let throwType = node.signature.throwsOrRethrowsKeyword
            .map { $0.text }
            .flatMap(ThrowClause.init) ?? .noThrows

        let method = InstanceMethod(
            accessibility: accessibility,
            name: node.identifier.text,
            parameters: params,
            returnType: returnType,
            throwType: throwType
        )
        print("  \(method)")

        current.members.append(method)
    }
}

class SwiftMockaGenerator {

    let visitor: MockaVisitor

    init(visitor: MockaVisitor = MockaVisitor()) {
        self.visitor = visitor
    }

    func printProtocols(filePath: URL) {
        let sourceFile = try! SyntaxTreeParser.parse(filePath)
        visitor.visit(sourceFile)
    }
}
