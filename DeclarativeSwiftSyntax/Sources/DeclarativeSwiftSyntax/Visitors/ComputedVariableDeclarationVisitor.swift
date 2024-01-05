import SwiftSyntax

final class ComputedVariableDeclarationVisitor: SyntaxVisitor {
    var computedVariableDeclarations: [ComputedVariableDeclaration] = []
    
    public override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {

        if let declaration = ComputedVariableDeclaration.init(node) {
            self.computedVariableDeclarations.append(declaration)
        }

        return .skipChildren
    }
}
