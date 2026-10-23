---
title: "Slices in Go"
tags: ["golang"]
created: "20230206231845777"
modified: "20230206232922035"
---

Most of the time when you need a data structure that holds a sequences of values, a slice is should be used.

- The length of the slice is not part of its type
- A single function can be written that can process slices of any size
- Slices can grow as needed

## Declaring Slices
Just like [[./Arrays in Go|arrays]] but we don't specify the size

```golang
// a slice of 3 ints using a slice literal
var x = []int{10, 20, 30}

// only specifying the indices with values in the slice literal
var x = []int{1, 5: 4, 6, 10: 100, 15}

// multidimensional slices
var x [][]int

// without a literal, assigned a zero value of nil
var x []int
```

## Reading and Writing Values
- Read and write slice values using the bracket syntax
- Can't read or write past end or use negative indexes

```golang
x[0] = 10
fmt.Println(x[2])
```

## Comparing Slices
- Slices are not comparable
- It is a compile time error to use the `==` or `!=` to see if two slices are identical
- Only comparable with `nil`

```golang
fmt.Println(x == nil) // prints true
```
