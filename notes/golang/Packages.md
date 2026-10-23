Every Go program is made up of packages.

A package named "main" has an entrypoint at the `main()` function. A `main` package is compiled into an executable program.

Everything that sits in the root folder should be part of the main package.

A package by any other name is a "library package". Libraries have no entry point. Libraries simply export functionality that can be used by other packages. For example:

## Naming Conventions

By _convention_, a package's name is the same as the last element of its import path. For instance, the `math/rand` package comprises files that begin with:

```go
package rand
```

## One Package / Directory

A directory of Go code can have **at most** one package. All `.go` files in a single directory must all belong to the same package. If they don't an error will be thrown by the compiler. This is true for main and library packages alike.