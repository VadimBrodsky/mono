---
title: "Floating Point Types in Go"
tags: ["golang"]
created: "20230123234714340"
modified: "20230129224257295"
---

There are 2 floating point types in Go. Like the integer types, the zero value is `0`.

1. `float32` is from `1.401298464324817070923729583289916131280e-45` to `3.40282346638528859811704183484516925440e+38`
2. `float64` is from `4.940656458412465441765687928682213723651e-324` to `1.797693134862315708145274237317043567981e+308`

Go uses the IEEE 754 specification giving a large range and limited precision.

## Choosing with type to use
- Unless you have to be compatible with an existing format, use `float64`
- Floating point literals have a default type of `float64`
- The bigger question is whether you should be using a floating point number at all, in most cases the answer is no

## Floating point operators
- You can use all the [[./Integer Types in Go|standard mathematical and comparison operators]] with floats except `%`
- Floating point division has a couple of interesting properties
  - Dividing a nonzero floating point variable by `0` returns `+Inft` or `-Inf` depending on the sign of the number
  - Dividing a floating point variable set to `0` by `0` returns `NaN`
- While you can use `==` and `!=` to compare floats, don't do it, instead define a minimum allowed variance and see if the difference is between them.
  - Minimum value (epsilon)
  - Maximum value
