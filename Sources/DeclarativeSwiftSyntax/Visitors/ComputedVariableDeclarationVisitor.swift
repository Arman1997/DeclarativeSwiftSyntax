import SwiftSyntax

final class ComputedVariableDeclarationVisitor: SyntaxVisitor {
    var computedVariableDeclarations: [ComputedVariableDeclaration] = []
    
    init(_ syntax: Syntax, viewMode: SyntaxTreeViewMode = .all) {
        super.init(viewMode: viewMode)
        self.walk(syntax)
    }
    
    public override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {

        if let declaration = ComputedVariableDeclaration.init(node) {
            self.computedVariableDeclarations.append(declaration)
        }

        return .skipChildren
    }
}
