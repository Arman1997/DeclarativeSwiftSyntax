import SwiftParser
import SwiftSyntax

public extension String {
    var asSyntax: Syntax {
        Parser.parse(source: self)._syntaxNode
    }
}
