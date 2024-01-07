import XCTest
@testable import DeclarativeSwiftSyntax


final class ComputedVariableDeclarationTests: XCTestCase {
    private static let stubVariableName: String = "stubComputedVariabel"
    
    func test_single_computed_variable_declaration_without_access_modifier() {
        let computedVariableDeclarations = declarationCode().asSyntax.computedVariableDeclarations()
        
        guard let declaration = computedVariableDeclarations.first else {
            XCTFail("No declarations found")
            return
        }
        
        XCTAssert(declaration.name == ComputedVariableDeclarationTests.stubVariableName)
        XCTAssert(declaration.accessModifier == .internal)
    }
    
    func test_single_computed_variable_declaration_with_access_modifier() {
        let declarations = AccessModifier
            .allCases
            .map { accessModifier in
                declarationCode(with: accessModifier)
                    .asSyntax
                    .computedVariableDeclarations()
            }
        
        guard !declarations.isEmpty else {
            XCTFail("No declarations found")
            return
        }
        
        var computedVariablesDeclarationIterator = declarations.makeIterator()
        var accessModifierIterator = AccessModifier.allCases.makeIterator()
        
        XCTAssert(declarations.count == AccessModifier.allCases.count)
        
        while let computedVariables = computedVariablesDeclarationIterator.next(),
              let accessModifier = accessModifierIterator.next() {
            
            XCTAssert(computedVariables.count == 1)
            
            guard let computedVariable = computedVariables.first else {
                XCTFail("No computed variable declaration found")
                return
            }
            
            XCTAssert(computedVariable.name == ComputedVariableDeclarationTests.stubVariableName)
            XCTAssert(computedVariable.accessModifier == accessModifier)
        }
    }
    
    func test_multiple_computed_variable_declarations() {
        let declarationNames = [ComputedVariableDeclarationTests.stubVariableName] + (1...5)
            .map(String.init)
            .map {
                ComputedVariableDeclarationTests.stubVariableName + $0
            }
        
        let declarationsCode = declarationNames.map { declarationName in
            declarationCode(name: declarationName)
        }
            .joined(separator: "\n")
        
        
        let computedVariableDeclarations = declarationsCode.asSyntax.computedVariableDeclarations()
        
        XCTAssert(computedVariableDeclarations.count == declarationNames.count)
        
        var declarationNameIterator = declarationNames.makeIterator()
        var computedVariableDeclarationIterator = computedVariableDeclarations.makeIterator()
        
        while let declarationName = declarationNameIterator.next(),
              let computedVariableDeclaration = computedVariableDeclarationIterator.next() {
            XCTAssert(computedVariableDeclaration.name == declarationName)
        }
        
    }
}

private extension ComputedVariableDeclarationTests {
    func declarationCode(with accessModifier: AccessModifier = .default, name: String = ComputedVariableDeclarationTests.stubVariableName) -> String {
        """
        \(accessModifier.rawValue) var \(name): TestReturnType {
        }
        """
    }
}
