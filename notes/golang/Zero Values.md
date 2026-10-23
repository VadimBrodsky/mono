# Zero Values
- All built-in types have zero values, even if they were never user or assigned.
- You can't have an `undefined` value like in other languages

```golang
var s string          // defaults to ""
var r rune            // defaults to 0
var bt byte           // defaults to 0
var i int             // defaults to 0
var ui uint           // defaults to 0
var f float32         // defaults to 0
var c complex64       // defaults to 0
var b bool            // defaults to false
var arr [2]int        // defaults to [0 0]
var obj struct {
	b   bool
	arr [2]int
}                     // defaults to {false [0 0]}
var si []int          // defaults to empty slice of int
var ch chan string    // defaults to nil
var mp map[int]string // defaults to nil
var fn func()         // defaults to nil
var ptr *string       // defaults to nil
```

