import SwiftSyntax

final class ClassDeclarationVisitor: SyntaxVisitor {
    var classDeclarations: [ClassDeclaration] = []
    
    init(_ syntax: Syntax, viewMode: SyntaxTreeViewMode = .all) {
        super.init(viewMode: viewMode)
        self.walk(syntax)
    }
    
    override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        classDeclarations.append(.init(node))
        return .skipChildren
    }
}
