# DeclarativeSwiftSyntax
Declarative API for Swift code static analyze. 


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
