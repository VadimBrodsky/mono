---
title: "Functions in Lua"
tags: ["lua"]
created: "20230107201238792"
modified: "20230107203013068"
---

A function is named chunk of code. The contents of a function are not automatically executed when the file is loaded. Once a function is defined it can be executed by calling it. The same scope rules apply to functions as to `do/end` blocks.


## Function Definition

A function is defined with the `function` keyword:

```lua
function PrintSomething()
  text1 = "hello"
  text2 = "world"
  print (text1 .. ", " .. text2)
end
```

## Calling a function
To call a function, use the function name followed by parentheses.

```lua
PrintSomething()
```

## Function Arguments
Functions can take arguments, they have local scope to the function:

```lua
-- Declare the function, takes two arguments
function AddAndPrint(x, y)
  local result = x + y
  print (x .. "+" .. y .. "=" .. result)
end

-- Call the function a few times
AddAndPrint(2, 3)
AddAndPrint(4, 5)
AddAndPrint(6, 7)
```

## Optional Arguments
Lua does not enforce argument arity, additional arguments that are not part of the function definition would be ignored, while missing arguments get the value of `nil`.

## Returning a value
When a function returns a value, it can be called as part of an expression or as a standalone statement.

Code after the `return` statement would not execute. The `return` keyword is only valid when followed by the `end` keyword. Without `do/end` block around the `return` statement the code would not compile.

```lua
-- declare the function
function AddTwo(x)
  result = x + 2
  return result
end

AddTwo(3)             -- calls as statement
nine = 7 + AddTwo(5)  -- call as expression
print("adding two " .. AddTwo(3)) -- call as expression
```

## Returning Multiple Values
Lua has a unique feature of multiple return values, this allows one function to return multiple values, assign the result of the function to a list of variables separated by commas.

```lua
-- declare the function
function SquareAndCube(x)
  squared = x * x
  cubed = x * x * x
  return squared, cubed
end

-- call the function
s, c = SquareAndCube(2)
```

If the number of return values are not assigned to variables they would be assigned `nil`.
