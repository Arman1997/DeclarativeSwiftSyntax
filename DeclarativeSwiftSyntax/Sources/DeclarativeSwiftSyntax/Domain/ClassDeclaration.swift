import SwiftSyntax

public struct ClassDeclaration: ClassDeclarationContaining, ComputedVariableDeclarationContaining {
    public let name: String
    public let accessModifier: AccessModifier
    public let inheritedTypes: [TypeIdentifier]
    
    private let declarationBodySyntax: Syntax
    
    internal init(
        _ classDecl: ClassDeclSyntax
    ) {
        self.name = classDecl.name.text
        self.accessModifier = AccessModifier(classDecl.modifiers)
        
        if let inheritanceClause = classDecl.inheritanceClause {
            inheritedTypes = Array(
                inheritanceClause.inheritedTypes
            )
            .map(\.type)
            .compactMap {
                $0.as(IdentifierTypeSyntax.self)
            }
            .map(\.name.text)
            .map(TypeIdentifier.init)
        } else {
            inheritedTypes = []
        }
        
        declarationBodySyntax = classDecl.memberBlock._syntaxNode
    }
    
    public func classDeclarations() -> [ClassDeclaration] {
        self.declarationBodySyntax.classDeclarations()
    }
    
    public func computedVariableDeclarations() -> [ComputedVariableDeclaration] {
        self.declarationBodySyntax.computedVariableDeclarations()
    }
}
