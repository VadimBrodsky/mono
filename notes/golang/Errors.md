Go programs express errors with `error` values. An Error is any type that implements the simple built-in [error interface](https://blog.golang.org/error-handling-and-go):

```go
type error interface {
    Error() string
}
```

When something can go wrong in a function, that function should return an `error` as its last return value. Any code that calls a function that can return an `error` should handle errors by testing whether the error is `nil`.

A `nil` error denotes success; a non-nil error denotes failure.

_When you return a non-nil error in Go, it's conventional to return the "zero" values of all other return values._

## Custom Errors
Because errors are just interfaces, you can build your own custom types that implement the `error` interface.
```go
type userError struct {
    name string
}

func (e userError) Error() string {
    return fmt.Sprintf("%v has a problem with their account", e.name)
}
```

## Errors Package
The Go standard library provides an "errors" package that makes it easy to deal with errors.
```go
var err error = errors.New("something went wrong")
```
