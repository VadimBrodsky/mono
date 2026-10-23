Interfaces in Go are often names with the "er" suffix

```go
// io.Reader
// io.Writer

//   Storage
type Storer interface {
	GetAll() ([]in, error)
	Put(int) error
}
```