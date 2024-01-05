import SwiftSyntax

public struct ComputedVariableDeclaration: ClassDeclarationContaining, ComputedVariableDeclarationContaining {
    public let name: String
    public let accessModifier: AccessModifier
    
    private let declarationBodySyntax: Syntax
    
    internal init?(_ variableDec: VariableDeclSyntax) {
        if let patternBinding = Array(variableDec.bindings)
            .compactMap({ $0.as(PatternBindingSyntax.self) })
            .first,
           let pattern = patternBinding
            .pattern
            .as(IdentifierPatternSyntax.self),
           let accessorBlock = patternBinding.accessorBlock {
            self.name = pattern.identifier.text
            self.declarationBodySyntax = accessorBlock._syntaxNode
        } else {
            return nil
        }

        self.accessModifier = AccessModifier(variableDec.modifiers)
    }

    public func classDeclarations() -> [ClassDeclaration] {
        declarationBodySyntax.classDeclarations()
    }
    
    public func computedVariableDeclarations() -> [ComputedVariableDeclaration] {
        declarationBodySyntax.computedVariableDeclarations()
    }
}
