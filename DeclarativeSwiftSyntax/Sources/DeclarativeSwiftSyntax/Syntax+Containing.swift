import SwiftSyntax
import SwiftParser

extension Syntax: ClassDeclarationContaining, ComputedVariableDeclarationContaining {
    public func classDeclarations() -> [ClassDeclaration] {
        let visitor = ClassDeclarationVisitor(viewMode: .all)
        visitor.walk(self)
        return visitor.classDeclarations
    }
    
    public func computedVariableDeclarations() -> [ComputedVariableDeclaration] {
        let visitor = ComputedVariableDeclarationVisitor(viewMode: .all)
        visitor.walk(self)
        return visitor.computedVariableDeclarations
    }
}
