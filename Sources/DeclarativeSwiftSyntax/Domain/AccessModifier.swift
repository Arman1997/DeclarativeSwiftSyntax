import SwiftSyntax

@frozen public enum AccessModifier: String, CaseIterable {
    case `private` = "private"
    case `fileprivate` = "fileprivate"
    case `internal` = "internal"
    case `public` = "public"
    case `open` = "open"
    
    public static let `default`: AccessModifier = .internal
    
    internal init(_ declarationModifierList: DeclModifierListSyntax) {
        let allAccessModifiers = Set(AccessModifier.allCases.map(\.rawValue))
        let declarationModifiers = Set(declarationModifierList.map(\.name.text))
        
        if let accessModifierValue = allAccessModifiers.intersection(declarationModifiers).first {
            self = AccessModifier(rawValue: accessModifierValue) ?? .default
        } else {
            self = .default
        }
    }
}
