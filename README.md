# DeclarativeSwiftSyntax
Declarative API for Swift code static analyze. 

![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/Arman1997/DeclarativeSwiftSyntax/swift.yml?logo=github)
[![Swift Version](https://img.shields.io/badge/swift--tools--version-5.7.1-orange.svg?logo=swift)](5.7.1)
[![Min iOS Version](https://img.shields.io/badge/min--iOS--version-16.0-blue.svg?logo=apple)](16.0)
[![Min macOS Version](https://img.shields.io/badge/min--macOS--version-10.15-blue.svg?logo=macos)](10.15)



This aim of this library is to provide a user-friendly API for analyzing Swift code. Primarily employed in conjunction with my other repositories, [DrivenCLI](https://github.com/Arman1997/DrivenCLI) and [Driven](https://github.com/Arman1997/Driven), its functionality is tailored to meet their specific requirements.

### Example of usage

#### Extracting class declarations.

```swift
class ParentClass {
    
}

"""
public final class ChildClass: ParentClass {
    var computedProperty: String {
        "Hello world!"
    }
}
"""
    .asSyntax
    .classDeclarations()
```

#### Filtering with access modifier.

```swift
.asSyntax
.classDeclarations()
.map(\.accessModifier)
.filter { $0 == .private }
```

#### Extracting computed variable declarations.

```swift
.asSyntax
.computedVariableDeclarations()
```

#### Extracting computed variables declared in each class.

```swift
.asSyntax
.classDeclarations()
.map {
    $0.computedVariableDeclarations()
}
```
