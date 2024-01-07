import SwiftSyntax
import SwiftParser

extension Syntax: ClassDeclarationContaining, ComputedVariableDeclarationContaining {
    public func classDeclarations() -> [ClassDeclaration] {
        ClassDeclarationVisitor(self).classDeclarations
    }
    
    public func computedVariableDeclarations() -> [ComputedVariableDeclaration] {
        ComputedVariableDeclarationVisitor(self).computedVariableDeclarations
    }
}
