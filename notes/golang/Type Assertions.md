To check for a type of a Go Struct

Single type check:
```go
c, ok := s.(circle)
if !ok {
	// log an error if s isn't a circle
	log.Fatal("s is not a circle")
}
```

Check against multiple types: 
```go
switch v := num.(type) {
case int:
	fmt.Printf("%T\n", v)
case string:
	fmt.Printf("%T\n", v)
default:
	fmt.Printf("%T\n", v)
}
```

To print the type of a variable

```go
fmt.Printf("%T\n", v)
```
