How do operators and functions relate in [[Elm]]? [[Elm]] operators are functions.

- [[Numbers]] operators
- [[Strings]] operators
- [[Conditionals]] operators
  
  Differences between operators and functions:
- Operators must always accept exactly two arguments - no more, no fewer.
- Normal functions have names that begin with a letter. You call them in [[prefix-style]].
- Operators have names that contain neither letters not numbers. You call them in [[infix-style]].
- Wrapping an operator in parentheses treats it as a normal function, [[prefix-style]] calling and all.
  
  ```elm
  (/)              -- <function> : Float -> Float -> Float
  divideBy = (/)   -- <function> : Float -> Float -> Float
  7 / 2            -- 3.5 : Float
  (/) 7 2          -- 3.5 : Float
  divideBy 7 2     -- 3.5 : Float
  ```
##### Operator Precedence
- In any expression containing multiple operators, the operators with the higher precedence gets evaluated before those with lower precedence.
- This applies only to [[infix-style]] calls, as all [[prefix-style]] calls implicitly have the same precedence.
  ```elm
  3 + 4 == 8 - 1            -- True : Bool
  (==) ((+) 3 4) ((-) 8 1)  -- True : Bool
  ```
  
Plain function calls have top precedence, higher than any operator, these 2 calls do the same thing:
  ```elm
  negate 1 + negate 5       -- -6 : number
  (negate 1) + (negate 5)   -- -6 : number
  ```
This means that when a result of two plain function calls passed to an operator, there is no need to add parentheses.

##### Operator Associativity
Evaluation order for operators called in [[infix-style]] is also determined by whether the operators are [[left-associative]], [[right-associative]] or [[non-associative]]. Every operator is one of these.

Think of operator associativity in terms of where the implied parentheses go:
- Infix expressions involving left-associative operators, such as arithmetic operators, have implied parenthesis that cluster on the left.
- Non-associative operators cannot be chained together.
  
  ```elm
  10 - 6 - 3       -- 1 : number
  
  -- Assuming left-associative
  ((10 - 6) - 3)   -- 1 : number
  
  -- Assuming right-associative
  (10 - (6 - 3))   -- 1 : number
  ```
  
This results in an error
  ```elm
  foo == bar == baz -- INFIX PROBLEM
  ```