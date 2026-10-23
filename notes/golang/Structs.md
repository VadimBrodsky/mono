Structure of data together, like JavaScript objects

```go
// declare the 'car' struct type
type car struct {
    make    string
    model   string
    mileage int
}

// create an instance of a car
newCar := car{
    make:    "Ford",
    model:   "taurus",

}
```

Or an anonymous struct

```go
newCar := struct {
    make    string
    model   string
    mileage int
}{
    make:    "Ford",
    model:   "Taurus",
    mileage: 200000,
}
```

## Logging Structs
Can use `fmt` package to log out structs for inspection

```go
fmt.Printf("The value of this struct is: %v", newCar)

// to print out the keys as well use %+v
fmt.Printf("The value of this struct is: %+v", newCar)
```