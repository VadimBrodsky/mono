---
title: "Explicit Type Conversion in Go"
tags: ["golang"]
created: "20230129231305751"
modified: "20230129231730398"
---

Go doesn't allow for automatic type promotion between variables. You must use a _type conversion_ when variable types do not match. Even different sized integers and floats must be converted to the same type to interact.

```golang
var x int = 10
var y float64 = 30.2
var z float64 = float64(x) + y
var d int = x + int(y)
```

## No Boolean Type Promotion

You cannot treat another Go type as a boolean. No other type can be converted to a bool, implicitly or explicitly to a _bool_. If you want to convert from another type to a boolean you must use a comparison operator.

```golang
x == 0
x == ""
```
