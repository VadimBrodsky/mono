---
title: "Typed and Untyped Constants in Go"
tags: ["golang"]
created: "20230130003417445"
modified: "20230130003901132"
---

Constants can be typed or untyped. 

An untyped constant works exactly like a literal; it has no type of its own, but does have a default type that is used when no other type can be inferred. 

```golang
const x = 10

// all of these assignments are legal:
var y int = x
var z float64 = x
var d byte = x
```

A typed constant can only be directly assigned to a variable of that type.

```golang
const typedX int = 10
// assigning it to any other type produces a compile-time error
```

Whether or not to make a constant typed depends on why the constant was declared. If you are giving a name to a mathematical constant that could be used with multiple numeric types, then keep the constant untyped.

In general leaving a constant untyped gives more flexibility.
