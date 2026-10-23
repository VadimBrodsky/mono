## Comments
```swift
// single line comment

// Swift comments support landmarks
// MARK: This is viewable in the jump bar
// TODO: Do this
// FIXME: Fix this
// MARK: - Add a separator above this

//: Single-line delimiter
```

```swift
/* A multi line
   comment, 
   supports **Markup**
 */
 
/*: Text on this line is not displayed in rendered markup
    This does
 */
```

```swift
/// A Quick Help comment
/// - warning: this function breaks sometimes
/// - parameter integer: Integer to square
/// - returns: `integer` squared
```

```swift
// declaration attributes
@available(iOS 10.0, macOS 10.12, *)
@available(*, introduced: 1.2, deprecated: 3.0, message: "User other")
```


## Logging to Console

```swift
print("hello, world")
print(hello, playground, seperator: "_", terminator: "")
// can still use NSLog(str)
```

## Simple Values

- `let` to make a constant
- `var` to make a variable

```swift
var myVar = "Hello"
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
```

Values are never implicitly converted to another type, need to explicitly cast them:

```swift
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
```

String interpolation with `\()`
- `\(#fuction)` - name of the function
- `\(#file)` - source file
- `\(#line)` - line of code
- `\(#column)` - the columns of code

```swift
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
```

Multi-line strings with `"""`, indentation before each line is removed.

```swift
"""
Hello
  Multiline
  Strings
"""
```

Arrays using `[]`, access elements by index  or key in brackets, comma is allowed after the last element

```swift
var shoppingList = ["water", "milk", "bread",]
shoppingList[1] = "juice"
```


## Data Types

- Value types
  - Passed by copy
  - Implemented as structures: Integers, Floating-Points, Booleans, Characters, Strings, Arrays, Dictionaries, Tuples
  - Implemented as Enumerations: Optionals
- Reference types
  - Passed by reference
  - Classes, Functions & Closures
