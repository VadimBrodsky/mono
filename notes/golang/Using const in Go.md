---
title: "Using const in Go"
tags: ["golang"]
created: "20230130002424498"
modified: "20230201025430014"
---

Constants in Go are a way to give names to literals. They can only hold values that the compiler can figure out at compile time. 

This means they can be assigned:
- Numeric literals
- `true` and `false`
- Strings
- Runes
- The built-in function `complex`, `real`, `imag`, `len`, `cap` and `iota`
- Expressions that consist of operators and the preceding values

Go doesn't provide a way to specify that a value calculated at runtime is immutable. There is no way to declare that a variable is immutable.

```golang
const x = 10
```

## Constant Naming
Go does not use screaming snake case for constant naming, but rather normal variable naming conventions apply. Using more descriptive names because of the package block usually makes sense.
