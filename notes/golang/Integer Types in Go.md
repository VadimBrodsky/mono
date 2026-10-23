---
title: "Integer Types in Go"
tags: ["golang"]
created: "20230123234522519"
modified: "20230123234540047"
---

The zero value for all integer types is`0`.

1. `int8` is `-128` to `127`
2. `int16` is `-32768` to `32767`
3. `int32` is `–2147483648` to `2147483647`
4. `int64` is `–9223372036854775808` to `9223372036854775807`
5. `uint8` is `0` to `255`
6. `uint16` is `0` to `65536`
7. `uint32` is `0` to `4294967295`
8. `uint64` is `0` to `18446744073709551615`
9. `byte` an alias to `uint8`, can perform math operations between them
10. `int` on a 32-bit CPU is a signed integer `int32`, on most 64-bit CPUs is a 64-bit signed integer `int64`
11. `uint` follows the same rules as `int` only unsigned
12. `rune`
13. `uintptr`

## Choosing which type to use
- if you are working with a binary file format or network protocol that has an integer of a specific size or sign, use the corresponding type
- if you are writing a library function that should work with any integer type write a pair of functions, one with `int64` for the parameters and variables and one with `uint64`
- in all other cases, just use `int`

## Integer Operators
- Go integers support the usual arithmetic operators: `+`, `-`, `*`, `/`, with `%` for modulus. 
- The result of an integer division is an integer. 
- To get a floating point result, need to use a type conversion.
- Dividing an integer by `0` causes a panic.
- Integer division in Go follows truncation towards zero
- Can combine any arithmetic operators with `=`: `+=`, `-=`, `*=`, `/=` and `%=`.
- Can compare integers with `==`, `!=`, `>`, `>=`, `<` and `<=`
- Go has bit-manipulation operators for intergers:
  - Shift left and right with `<<` and `>>`
  - Bit masks with `&` (local AND), `|` (locical OR), `^` (logical XOR), and `&^` (logical AND NOT)
  - These can be combined with `=` to modify a variable: `&=`, `|=`, `^=`, `&^=`, `<<=`, and `>>=`
  

```golang
var x int = 10
x *= 2
```
