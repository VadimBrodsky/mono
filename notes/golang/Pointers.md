A pointer is a variable that stores the _memory address_ of another variable. This means that a pointer "points to" the _location_ of where the data is stored _NOT_ the actual data itself.

- 8 byte integer
- Pointers hold the memory address of a value.
- A pointer's zero value is `nil`
- The `&` operator generates a pointer to its operand.
- The `*` dereferences a pointer to gain access to the value
- Unlike C, Go has no [pointer arithmetic](https://www.tutorialspoint.com/cprogramming/c_pointer_arithmetic.htm)

The `*` syntax defines a pointer:
```go
var p *int
```

The `&` operator generates a pointer to its operand.
```go
myString := "hello"
myStringPtr := &myString
```

 It's generally a better idea to have your functions accept non-pointers and return new values rather than mutating pointer inputs.

## Nil Pointers

If a pointer points to nothing (the zero value of the pointer type) then dereferencing it will cause a runtime error (a [panic](https://gobyexample.com/panic)) that crashes the program. 

Generally speaking, whenever you're dealing with pointers you should check if it's `nil` before trying to dereference it.

## Pointer Receivers

A receiver type on a method can be a pointer.

Methods with pointer receivers can modify the value to which the receiver points. Since methods often need to modify their receiver, pointer receivers are _more common_ than value receivers. However, methods with pointer receivers don't require that a pointer is used to call the method. The pointer will automatically be derived from the value.

Methods with pointer receivers don't require that a pointer is used to call the method. The pointer will automatically be derived from the value.

```go
type car struct {
	color string
}

func (c *car) setColor(color string) {
	c.color = color
}

func main() {
	c := car{
		color: "white",
	}
	// notice c is not a pointer in the calling function
    // but the method still gains access to a pointer to c
	c.setColor("blue")
	fmt.Println(c.color) // prints "blue"
}
```