---
title: "Arrays in Go"
tags: ["golang"]
created: "20230206230244389"
modified: "20230206231832529"
---

Arrays are rarely used directly in Go.

## Array Declarations

- All of the elements in the array must be of the type that is specified
- The size of an array must be defined at compile time
- The size of an array is part of its type signature 
- Cannot use type conversion to convert arrays of different sizes to identical types
- Can't define a function that works with arrays of any size
- Can't assign arrays of different sizes to the same variable

```golang
// 3 item array of int initialized to zero values
var x [3]int

// 3 item array with initial values
var x = [3]int{10, 20, 30}

// sparse array, specifying the elements with indexes
var x = [12]int{1, 5: 4, 6, 10: 100, 15}

// leaving out the size because we use an array literal
var x = [...]int{10, 20, 30}
```

## Comparing arrays:

```golang
var x = [...]int{1, 2, 3}
var y = [3]int{1, 2, 3}
fmt.Println(x == y)   // prints true
```

## Two dimensional arrays

Go only has one-dimensional arrays, but they can be nested to simulate multidimensional arrays:

```golang
var x [2][3]int
```

## Reading and Writing Values

- Arrays in Go are read and written using the bracket syntax
- Cannot read or write past the end of an array, or use a negative index
- An out-of-bounds read or write with a variable index compiles but fails at runtime with a _panic_
- The built-in `len` function takes in an array and returns its length

```golang
x[0] = 10
fmt.Println(len(x))
```
