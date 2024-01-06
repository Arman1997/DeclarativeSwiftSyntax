import XCTest
@testable import DeclarativeSwiftSyntax


final class ClassDeclarationTests: XCTestCase {
    
    private static let stubClassName: String = "TestClass"

    func test_single_class_declaration_without_inheritance_and_access_modifier() {
        expectOneElement(in: declarationCode()) { onlyElement in
            XCTAssertTrue(onlyElement.accessModifier == .internal)
            XCTAssertEqual(onlyElement.name, ClassDeclarationTests.stubClassName)
        }
    }
    
    func test_single_class_declaration_with_access_modifier_without_inheritance() {

        func executeTest(for accessModifier: AccessModifier) {
            expectOneElement(in: declarationCode(with: accessModifier)) { onlyElement in
                XCTAssertTrue(onlyElement.accessModifier == accessModifier)
            }
        }
        
        AccessModifier
            .allCases
            .forEach(executeTest)
        
    }
    
    func  test_single_class_declaration_without_parent_type() {
        expectOneElement(in: declarationCode()) { onlyElement in
            XCTAssertTrue(onlyElement.inheritedTypes.isEmpty)
        }
    }
    
    func test_single_class_declaration_with_single_parentType() {
        struct TestParentType {}
        let stubTestParentTypeName: String = String(describing: TestParentType.self)
        expectOneElement(in: declarationCode(parentTypes: [stubTestParentTypeName])) { singleElement in
            XCTAssertEqual(singleElement.inheritedTypes, [TypeIdentifier(stubTestParentTypeName)])
            XCTAssertTrue(singleElement.inheritedTypes.count == 1)
            // Testing isSubtype as well in this test
            XCTAssertTrue(singleElement.isSubtype(of: TestParentType.self))
        }
    }
    
    func test_single_class_declaration_with_multiple_parentTypes() {
        struct TestParentType {}
        struct TestParentType1 {}

        let parentTypes: [String] = [String(describing: TestParentType.self)] + (1...5)
            .map(String.init)
            .map {
                String(describing: TestParentType.self) + $0
            }

        expectOneElement(in: declarationCode(parentTypes: parentTypes)) { singleElement in
            XCTAssertEqual(singleElement.inheritedTypes, parentTypes.map(TypeIdentifier.init))
            XCTAssertTrue(singleElement.inheritedTypes.count == parentTypes.count)
            // Two real types enough to make sure that isSubtype working fine for multiple parent types
            XCTAssertTrue(singleElement.isSubtype(of: TestParentType.self))
            XCTAssertTrue(singleElement.isSubtype(of: TestParentType1.self))
        }
    }
    
    func test_multiple_class_declarations() {
        let classNames: [String] = [ClassDeclarationTests.stubClassName] + (0...5)
            .map(String.init)
            .map { ClassDeclarationTests.stubClassName + $0 }
        
        let extractedClassDeclarations = classNames
            .map {
                declarationCode(className: $0)
            }
            .joined(separator: "\n")
            .asSyntax
            .classDeclarations()
        
        XCTAssertEqual(extractedClassDeclarations.count, classNames.count)
        
        var classNameIterator = classNames.makeIterator()
        var extractedClassDeclarationsIterator = extractedClassDeclarations.makeIterator()
        
        while let className = classNameIterator.next(),
              let extractedClassDeclaration = extractedClassDeclarationsIterator.next() {
            XCTAssertEqual(extractedClassDeclaration.name, className)
        }
    }
}

private extension ClassDeclarationTests {
    func declarationCode(with accessModifier: AccessModifier = .default, className: String = stubClassName, parentTypes: [String] = []) -> String {
        """
        \(accessModifier.rawValue) class \(className) \(parentTypes.isEmpty ? "" : ": \(parentTypes.joined(separator: ", "))") {
        }
        """
    }
    
    func expectOneElement(in declarationCode: String, with className: String = stubClassName, extractedElement: (ClassDeclaration) -> Void)  {
        let extractedClassDeclarations = declarationCode
            .asSyntax
            .classDeclarations()
        
        guard let onlyClass = extractedClassDeclarations.first else {
            XCTFail("No class declarations found")
            return
        }
        
        XCTAssertTrue(extractedClassDeclarations.count == 1)
        XCTAssertEqual(onlyClass.name, className)
        extractedElement(onlyClass)
    }
}
