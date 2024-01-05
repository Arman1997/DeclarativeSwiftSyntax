import XCTest
@testable import DeclarativeSwiftSyntax

final class DeclarativeSwiftSyntaxTests: XCTestCase {
    func testExample() throws {
        let drivenViewBody = """
        class Greetings: DrivenView {
            var drivenBody: View {
                return Text("Hello world")
            }
        }
        """
            .asSyntax
            .classDeclarations()
            .filter {
                $0.inheritedTypes.contains(.init("DrivenView"))
            }
            .compactMap {
                $0
                    .computedVariableDeclarations()
                    .filter {
                        $0.name == "drivenBody"
                    }
                    .first
            }
            .first
        
        XCTAssertNotNil(drivenViewBody)
    }
}
