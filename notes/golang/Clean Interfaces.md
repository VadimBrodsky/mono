## Keep Interfaces Small

Interfaces are meant to define the minimal behaviour necessary to accurately represent an idea or concept.

```go
type File interface {
    io.Closer
    io.Reader
    io.Seeker
    Readdir(count int) ([]os.FileInfo, error)
    Stat() (os.FileInfo, error)
}
```

## Interfaces Should Have No Knowledge Of Satisfying Types

An interface should define what is necessary for other types to classify as a member of that interface. They shouldn’t be aware of any types that happen to satisfy the interface at design time.

```go
type firetruck interface {
	car
	HoseLength() int
}
```

## Interfaces Are Not Classes
- Interfaces are not classes, they are slimmer.
- Interfaces don’t have constructors or deconstructors that require that data is created or destroyed.
- Interfaces aren’t hierarchical by nature, though there is syntactic sugar to create interfaces that happen to be supersets of other interfaces.
- Interfaces define function signatures, but not underlying behavior. Making an interface often won’t DRY up your code in regards to struct methods.

For example, if five types satisfy the `fmt.Stringer` interface, they all need their own version of the `String()` function.