[[Elm]] functions represent reusable logic. They are not objects, they have no fields, no prototypes and no ability to store state. All they do is accept values as arguments and then return a value.

#### Defining Functions
- In [[Elm]] we put the function parameter before the `=`  sign.
- We don't surround the function body with `{` and `}`.
- The `return` keyword is not used either. In Elm a function body is a single expression. Since an expression evaluates to a single value, Elm sues that as the function's return value.
- All Elm functions return values.
- In Elm functions there is no concept of an early return, as there is no `return` keyword.
  ```elm
  isPositive num = num > 0   -- <function> : number -> Bool
  isPositive 2               -- True : Bool
  (isPositive 2)             -- True : Bool
  isPositive (2 - 10)        -- False : Bool
  ```
  
  Functions can be defined over multiple lines, using spaces for indentation. Tab characters are syntax errors in [[Elm]].
  
  ```elm
  pluralize singular plural count =
  if count == 1 then singular else plural
  -- <function> : a -> a -> number -> a
  
  pluralize "elf" "elves" 3            -- "elves" : String
  pluralize "elf" "elves" (round 0.9)  -- "elf" : String
  ```
  
  When passing multiple arguments to an [[Elm]] function, separate the arguments with whitespace and not commas. 
  
  To pass a result of another function call into an argument of another function (`round` for example), use parenthesis.
#### Importing Functions

A module is a named collection of Elm functions and other values. An example of an Elm core module is `String`.

```elm
String.toLower "LOUD NOISES"   -- "loud noises" : String
String.toUpper "i love lamp"   -- "I LOVE LAMP" : String
String.fromFloat 44.1          -- "44.1" : String
String.fromInt 642             -- "642" : String
String.fromChar 'x'            -- "x" : String
String.length "five"           --- 4 : Int
```

The Elm strings have no fields nor methods. The `String` module houses the standard set of string-related features and exposes them in the form of plain old functions, like `toLower` and `toUpper`.
#### Functions as Values
Elm functions are first-class values that can be passes around just like any other value.

The `String.filter` is one of the higher-order functions that Elm uses to implement customizable logic.

```elm
isKeepable character = character /= '-'   -- <function> : Char -> Bool
isKeepable 'z'                            -- True : Bool
isKeepable '-'                            -- False  : Bool
String.filter isKeepable "800-555-1234"   -- "8005551234" : String
```
#### Local scope with let-expression
- A let-expression adds locally scoped named values to an expression.
- All names values between `let` and `in` are intermediate values that are no longer in scope once the expression `in` gets evaluated.
- The indentation of a let-expression is important, the `let` and `in` keywords must be at the same indentation level, and all other lines in the let-expression must be indented further than they are.
- Anywhere where you can write a normal expression, you can swap in a let-expression instead.
- Whenever you want some local scope, let-expressions are the solution.
  
  ```elm
  withoutDashes str =
  let
  	dash =
  '-'
  
  	isKeepable character = character /= dash
  in
  String.filter isKeepable str
  ```
#### Anonymous Functions
Anonymous functions work like named functions, except they don't have a name. Once defined they work the same way as named functions. Can always use one in place of the other.
  
Anonymous functions are often used with higher-order functions like `String.filter`
  
  ```elm
  area w h = w * h    -- named function
  \w h -> w * h       -- anonymous function
  
  -- these are equivalent
  isKeepable char = char /= '-'
  isKeepable = \char -> char /= '-'
  ```
  
Elm's anonymous functions differ from named functions in 3 ways:
1. They have no names.
2. They begin with a `\` symbol.
3. Their parameters are followed by a `->` symbol instead of an `=` symbol.
  
  ```elm
  String.filter (\char -> char /= '-') "(800) 555-1234"
  String.filter (\char -> Char.isDigit chat) "(800) 555-1234"
  String.finlter Char.isDigit "(800) 555-1234"
  ```
#### Partial Application
  
Partially applying a function means passing it some of its arguments - but not all of them. And getting back a new function that will accept the remaining arguments and finish the job.
  
Functions that can be partially applied are called [[curried functions]]. In [[Elm]] all functions are curried.
  
Functions that are not curried by default are [[tupled functions]], they expect a complete tuple of arguments. A fixed-length sequence of elements.
  
Planning the order of function's arguments is important for partial application to work well.