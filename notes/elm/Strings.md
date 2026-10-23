- Double quotes in Elm represent string literals, just as in JavaScript.
- Single quotes in Elm represent character literals of UTF-8 format.
- Use [[Operators]] to create expressions with numbers.
- The `++` operator combines strings, where the `+` operator is for addition only.
```elm
"Hello, World!"                         -- "Hello, World!" : String
"Pi is " ++ String.fromFloat pi ++ "."  -- "Pi is 3.141592653589793. : String
'a'                                     -- 'a' : Char
```