---
title: "Built-in Functions in Go"
tags: ["golang"]
created: "20230206232958687"
modified: "20230206235136633"
---

Go provides several built-in functions to work with its built-in types. Usually these functions can do things that normal functions cannot.

## len
- Returns the length of an array or a slice
- When used on a `nil` returns `0`

```golang
var x = []int{10, 20, 30}
fmt.Println(len(x)) // 3
```

## append
- Grows a slice, takes a slice of any type and a value of that type
- It returns a slice of the same type
- One slice and be appended into another using the `...` operator
- It's a compile time error to forget to assign the value returned from `append`

```golang
var x []int
x = append(x, 10)
x = append(x, 5, 6, 7) // appending multiple values

// appending a slice with a slice
y := []int{20, 30, 40}
x = append(x, y...)
```

## capacity
- Every slice has a _capacity_ which is the number of consecutive memory locations reserved
- This can be larger than the length
- Each time you append to a slice, one or more values is added to the end of the slice
- When the length reaches the capacity, there is no more room to put values
- When additional items is `append`ed the [[./The Go Runtime|Go runtime]] allocates a new slice with a larger capacity, the values of the original slice are copied into the new slice while the new values added to the end of the slice and the new slice is returned
- As of Go 1.14, the capacity of a slice doubles when capacity is less than 1,024 and the grow by at least 25% afterwards
- Most of the time `cap` is used to check if a slice is large enough to hold new data, or if a call to `make` is needed to create a new slice
- While its nice to know that slices grow automatically, it's more efficient to size them once you know how many things you plan to put into a slice. To create the slice with the correct initial capacity.

```golang
var x []int
x = append(x, 10)
fmt.Println(x, len(x), cap(x))
x = append(x, 20)
fmt.Println(x, len(x), cap(x))
x = append(x, 30)
fmt.Println(x, len(x), cap(x))
```
