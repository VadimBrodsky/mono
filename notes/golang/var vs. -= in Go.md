---
title: "var vs. := in Go"
tags: ["golang"]
created: "20230130000112728"
modified: "20230201030032394"
---

The most verbose way to declare a variable in Go, using the `var` keyword, an explicit type, and an assignment:

```golang
var x int = 10
```

If the type on the righthand side of the `=` is the expected type of your variable, you can omit it. Since the default type of an integer literal is `int`.

```golang
var x = 10
```

If you want to declare and assign it the zero value, keep the type and drop the righthand side:

```golang
var x int
```

You can declare multiple variables at once with `var`::

```golang
var x, y int = 10, 20  // of the same type
var x, y int           // all zero values of the same type
var x, y = 10, "hello" // of different types
```

Declaring multiple variables at once, using a declaration list:

```golang
Var (
	x int
	y	    = 20
	z int	= 30
	d, e	= 40, "hello"
	f, g string
)
```

Go also supports a short declaration format, when you are within a function you can use the `:=` operator to replace a `var` declaration that use type inference, these do exactly the same thing:

```golang
var x = 10
x := 10
```

Like `var` you can declare multiple variables at once:

```golang
var x, y = 10, "hello"
x, y := 10, "hello"
```

The `:=` can do one trick that `var` cannot, it allows to assign values to existing variables. As long as there is one new variable on the lefthand side of the `:=` then any of the other variables can already exist:

```golang
x := 10
x, y := 30, "hello"
```

The one limitation of `:=`, I you are declaring a variable at a package level, you must use `var`, `;=` is not legal outside of functions.

## When to avoid `:=`

- When initializing a variable to its zero value, use `var x int`, it makes it clear that the zero value is intended
- When assigning an untyped constant or a literal to a variable and the default type for the constant or literal isn't the type you want for the variable, while its legal to write `x := byte(20)` use `var x byte = 20` as it's idiomatic.
- Because `:=` allows you to assign to both new and existing variables, it sometimes creates new variables when you thing you are reusing existing ones. In those situations explicitly declare all you new variables with `var` to make it clear which variables are new.

You should rarely declare variables outside of a functions, these are in the _package block_. Declare variables in the package block that are effectively immutable.

## Variable Naming

Within a function favour short names. The smaller the scope for a variable the shorter the name that used for it. It is very common in Go to see a single-letter variable names.

Go uses camel case, names like `indexCounter` or `numberTries`, when an identified or name uses multiple words.
