import SwiftSyntax

final class ClassDeclarationVisitor: SyntaxVisitor {
    var classDeclarations: [ClassDeclaration] = []
    
    override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        classDeclarations.append(.init(node))
        return .skipChildren
    }
}
