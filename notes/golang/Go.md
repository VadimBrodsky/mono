## Go Commands

- `go run` compile and run
- `go build` compiles the binary
- `go get <URL>` gets a package from the Internet
- `gofmt` format the source file according
- `goimports` manages the insertion and removal of import declarations

```go
go get golang.org/x/tools/cmd/goimports
```

## Main and Import

Package `main` defined a standard execution program, not a library. Within the `main` package the function `func main()` is also special its where execution of the program begins.

The `import` declaration must follow the `package` declaration. Must import only the package that are needed, missing or unnecessary packages will cause the program to not compile.


## Basic Syntax


### Comments
Comments begin with `//`, ignored by the compiler until the end of the line. By convention each package is described in a comment immediately preceding its package declaration, for a main package this comment is one or more complete sentences that describe the program as a whole

### Variable Declaration
A variable can be initialized as part of its declaration, if its not initialized it has an implicit zero value. Zero for numeric types, `""` for strings. The `:=` symbol is short variable declaration, a statement that declares one or more variables and gives them the inappropriate type based on the initializer values.

```go
s := ""           // short declaration, used only within a function
var s string      // uses the default initiazation of the zero value ""
var s = ""        // rarely used, except for declaring multiples
var s string = "" // redundant type declaration
```

### Increment / Decrement
The increment statement `i++`, adds 1 to `i`. Corresponding decrement is `i--`. These are postfix statements and not expressions. `j = i++` is illegal in Go.

### Loops
Never use parentheses around the three components of a `for` loop. The braces must be placed as such or it will not compile. Any part of the `for` loop can be omitted.

```go
for initializer; condition; post {
  // zero or more statments
}

// while loop
for condition {
  // ...
}

// inifinite loop
for {
  // ...
}

// range loop, ignore the initializer with a blank identifier
for _, := range os.Args[1:] {
  // ...
}
```
