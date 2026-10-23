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

## Additional notes migrated from Obi1

## Why Go?
- Efficient compilation
- Easy to code
- Efficient execution
## Characteristics
- Strong, static type system
- C-inspired syntax
- Compiled
- Multi-paradigm
- Garbage-collected
- Fast
- Single binary compilation
## Values and Philosophy
- Simplicity
- Language that knows the existence of network requests and concurrent execution
- Library-free experience for: strings, network, compression, file management, testing
- Cross-platform
- Backwards Compatibility
- Powerful command line interface

## Main Package
Every valid Go project needs an entry point, the `package main` is where a Go program starts running. A package is a collection of code tat all does a similar thing.

The `package` declaration gives the name of the package that this file’s code will become a part of.

The `main` package is a special package, it is required if the code is going to be run directly (usually from the terminal). When the Go program runs it looks for a function named `main` in the `main` package.
### Typical Go file layout
1. The package clause
2. Any `import` statements
3. The actual code
## Basic Syntax Rules
- We use `.go` files
- Code blocks in `{}`
- No styling freedom
- We do have semi-colon to separate sentences, but its optional
- Case-sensitive
- Strongly typed
- Not an object-oriented language
- No classes, no exceptions
- We have one file acting as the entry point with a main function
- A folder is a package
- Packages can have simple names (services) or URLs (github.com/fem/my-library)
- Within one go file, we can have:
	- Variables or constants
	- Function
	- Type declarations
	- Method declarations
## Modules and CLI
- A module is a group of packages that can define the project
- It contains a `go.mod` file with configuration and metadata
- CLI manipulates the module
	- `go mod init`
	- `go build`
	- `go run`
	- `go test`
	- `go get`
## Workspaces and CLI
- A workspace is anew kind of multi-module app concept from 1.18
- It contains a `go.work` file with configuration and metadata including which module to use
- CLI manipulates the workspace
	- `go work init`
## Variables
- Variables are initialized to their zero value
	- numeric types - `0`
	- boolean types - `false`
	- strings - `""`
	- pointers - `nil`
- Constants can be only bool, string or numbers
- Variable initialization shortcut
	- Only within a function, not module body
	- Only for variables, not constants
 - Package level variables can be declared in a block, akin to imports
var x int           // Data type goes after the identifier
var name string     // Zero value is used ""
const y = 2         // Can only bool, string or number

var z int = 2       // Create a variable with initialization

var text string     // String use double quotes
text = "Hello!"

otherText := "Bye!" // Variable initialization shortcut, only within func

var (
	w int
	s string
	f float32
)
## Built-in Data Types
- String values `string`
- Integer values: `int, int8, int32, int64, uint, uint8, uint16, uint32, uint64`
- Floating point values: `float32`, `float64`
- Booleans `bool`
- We can also work with pointers

bool

string

int  int8  int16  int32  int64
uint uint8 uint16 uint32 uint64 uintptr

byte // alias for uint8

rune // alias for int32
     // represents a Unicode code point

float32 float64

complex64 complex128

### Boolean Operators
- The usual `==, !=, <, >, <=, >=, &&, ||, !`
## Packages
- A package is a group of files in the same folder
- We can import other packages with `import`
- Multiple go files can reuse the same package namespace, this is akin to use the same file.
- Breaks apart packages over multiple files
- When using external packages, use the dot `.` notation
- Member visibility is governed by title-case
	- Uppercase will be exported
	- Lowercase is private
package main

import "fmt"

func main() {
	fmt.Println("Hello Go!")

### Import
- The import statement can also be a block to import multiple packages
- The package name is taken from the last part of the package path, for custom packages
- It is possible to alias the package name during import
import (
	"fmt"
	"os"
	fileutils "frontendmaster.com/go/files/fileio"
)
### Package Visibility
- What we write in a module:
	- If its camelCase, its private
	- If its TitleCase, its public and exported
- Variables and lambda functions can be:
	- module scoped
	- function scoped
	- block scoped
## Numbers
- Cannot have math operations of number of different types. Go does not have auto type conversion like JS.
- Number literals are simple, just type the number. Go treats floating point numbers and integers as different
- We convert between numbers using a global function with the type name
id := 4
price := 45.4

priceAsInt := int(price)
idAsFloat := float32(id)
## Strings
- Multiline strings are available by default
- Use double quotes to define a string literal `”hello world”`. Go has escape sequences to allow for special output:
	* `\n` - a newline character
	* `\t` - a tab character
	* `\”` - double quotation marks
	* `\\` - a backslash
str1 := "This is just text"

str2 := `Every text
is multine
by default`
## Collections
- Arrays - fixed length `[5]int`
- Slices - similar to a dynamic length array, but they are actually chunks of arrays `[]int`
- Maps - key / value dictionaries `map[keyType]valueType`
- Generics - from 1.18
- Collections are not objects, nothing in Go is an object, so we use global functions to work with them.
	- `len()` is used to get length of collections
	- `cap()` is used to get the capacity of a value, according to type
	- `append()` is used to append, by creating a new slice
	
// arrays
var countries [3]string
countries[0] = "Panama"
Prices := [2]int { 100, 150 }

// slices
names := []string { "Mary", "John"}
names := append(names, "Carol")

//maps
wellKnownPorts := map[string]int {"http": 80, "https": 443}
## Functions
- Similar to other languages
- It can receive arguments
- Arguments can have default values
- The last argument can be of variable length
- Functions can return more than one value at once
- Function can return labeled variables
- Functions receive arguments always by value, cloning the value
- Use `_` to name an unused variable
- No function overloading except `init`, even if they have different types
- Go supports lambda functions by defining  a function and not giving it a name
- Go supports closures, allowing to close over data from the parent scope
func save() {}
func save(text string) {}

// function definition with arugments and return types
func add(a int, b int) int {
	return a + b

// 2 return values
func addAndSubtract(a int, b int) (int, int) {
	return a + b, a - b

// named return values, creates local variables
func calculateTaxWithName(price float32) (stateTax flat32, cityTax float32) {
	stateTax = price * 0.09
	cityTax = price * 0.02
	return  // bare return because we named them in the type

func main() {
	first, _ := addAndSubtract(1, 2)
### Pointers
- Functions receive references
- We need to receive pointers instead of the value, to have a function that modifies the arguments
- Use the `*` operator to get a value of a pointer
- Use the `&` operator to get the pointer of a value
- The `.` operator works on pointers like it does on values
func increment(x *int) {
	*x++

func main() {
	i := 1
	increment(&i)
### The init function
- Each source file can define its own `init` function to set up state
- Can have multiple `init` functions
- A common use case is to verify or repair corrected of the program state before execution begins
### Printf
- The `fmt.Printf()` allows to print a formatted string, using placeholders for specific value types
	- `%v` value
	- `%s`string
	- `%d` integer
### Defer
- Defer some other function until the end of the function call is reached
- Can be stacked, first in last out
- Similar to finally in try / catch in other languages
### Panic
- Built in function that stop the normal execution of the current goroutine
- It goes up in the call stack with a message
- Not how to do error management
- `panic(v any)`
## Errors
- Go does not have exceptions
- A typical design pattern is to return the error when any action may trigger an error
- A common way to create errors is by using `fmt.Errorf` formatter
func readUser(id int) (user, err) {
	// .. we proceed with the reading and see a bool ok value
	if ok {
		return user, nil	
	} else {
		 return nill, errorDetails

func main() {
	user, err := readUser(2)
## Control Structures
### if - else
	- It can have multiple conditions
	- There is no ternary operator in Go
- There is no while or do while
- No parenthesis are needed for boolean conditions or values
- Only one type of equality operators `==`
- Other operators `!= < > <= >=`
if user != nil {
	// if body
} else {
	// else body

if message := "hello"; user != nil {
	// if body
    // message exists here
} else {
	// else body
    // message exists here
// message does not exists here
### Switch
- Switch, like a select
- No break is needed
- Can fall through to the next case
- Can use switch with any boolean condition
- Only the first one that is true is executed
switch day {
	case "Monday":
		fmt.Println("It's Monday")
	case "Saturday":
		fallthrough
	case "Sunday":
		fmt.Println("It's Weekend")
	default:
		fmt.Println("It's another work day")

// switch with conditions, repalces large ifs
switch {
	case user == nil:
		// something
	case user.ative == false:
		// something
	case user.deleted == true:
		// something
	default:
		// something
### for
- Its a multi purpose loop control structure
- The `range` keyword is useful for collections and maps
- We can emulate a while just by using a boolean expression
// classic for
for i := 0; i < len(collection); i++ {
	// do something for each i

// for range, similar to for in in JS
for index := range collection {
	// do something for each index of collection

// for range, similar to foreach
for key, value := range map {
	// do something for each key and value

endOfGame := false
for endOfGame {
	// process Game loop

for coung < 10 {
	count += 1;

	// infinite loop
## Runes
- Used to represent single characters.
- Rune literals are written with single quotation marks `’rune’`. 
- Go uses the Unicode standard for storing runes.
- Runes are kept as numeric codes and not the characters themselves.
- If its passed to `fmt.Println` it will output a numeric code.
## Type Definitions
- Go is statically typed, if you use the wrong type of value in the wrong place. Go will let you know.

To view the type of a value use the `TypeOf` function:
reflect.TypeOf(42)
### Type Aliases
- Can create new types based on other types as type aliases
- Can add methods to new types, not to aliases
// Type Alias
type distance = float32
type json = map[string]string

// New type based on
type distance float32

// types have a cunstructor and conversion functions
d := distance(32.5)
## Methods
- Functions can be added onto types to create methods
- Uses a prefix on the function definition to specify the receiver
type distance float64   // miles
type distanceKm float64 // km
type location string

// Method on the distance type
func (miles distance) ToKm() distanceKm {
	return distanceKm(1.60934 * miles)

// Method on the distanceKm type
func (km distanceKm) ToMiles() distance {
	return distance(km / 1.60834)

func (origin location) DistanceTo(destination location) distance {
	return 10

func test() {
	d := distance(4.5)
	km := d.ToKm()
	m := km.ToMiles()
	nyc := location("33.32132, 43.2232")
	nyc.DistanceTo(location("-23, -44"))
## Structs
- Complex types for definitions
- They replace the idea of the class in Go
- It's a data type with strongly typed properties
- They have a default constructor
- You can add methods to it
### Type - Structs
- If you want to export your struct to use TitleCase
- You will find two pre-built constructors, with and without a name
- Structs can have metadata attached to their fields, this is useful for typing a JSON API
	- Other packages can use the reflection API to read the metadata
	- There are tools to convert JSON to Go structs: https://mholt.github.io/json-to-go/
type User struct {
	id int
	name string

func main() {
	var u1 User
	u1 = User {id: 1, name: "Frontend Masters"}
	u2 := User {2, "Frontend Masters"}

type CEXResponse struct {
	Timestamp             string  `json:"timestamp"`
	Low                   string  `json:"low"`
	High                  string  `json:"high"`
	Last                  string  `json:"last"`
### Type - Structs with Methods
- Structs are functions attached to a type declared outside of the structure
func (u User) PrettyPrint() string {
	return string(u.id) + ": " + u.name

func main() {
	u2 := User {2, "Frontend Masters"}
	msg := u2.PrettyPrint()
## Factories
- A design pattern to create structs
- Uses a `New` function name by convention
func NewInstructor(name string, lastname string) Instructor {
	return Instructor{FirstName: name, LastName: lastname}
## Stringer
- String representation of a struct
- Similar to the toString method on a JavaScript object
type Duration float32 // in hours

type Course struct {
	Id         int
	Name       string
	Slug       string
	Legacy     bool
	Duration   Duration
	Instructor Instructor

func (c Course) String() string {
	return fmt.Sprintf("--- %v --- (%v)", c.Name, c.Instructor.FirstName)
## Embedding Types
- Like inheritance
- Its possible to extend types by embedding other types into a type definition struct
- If there is a conflict in the name of a filed the local one wins
- If extending multiple fields that have collisions in the field names, have to use the full subtype name to disambiguate
- When embedding types, also get the methods of the embedded type
type Workshop struct {
	Course        // embed the Course type into Workshop
	Name   string // overrides the Course.Name field
	Date   time.Time
## Interfaces
- A definition of methods
- You emulate polymorphism from OOP
- Implicit implementation
- We can embed interfaces in other interfaces
- Any type that implements the interface is assignable to that interface
type PrettyPrinted interface {
	PrettyPrint() string

func saveObject(object PrettyPrinted) {
	save(object.PrettyPrint())

func main() {
	u2 := User {2, "Frontend Masters"}
	saveObject(u2)
## Goroutines
- A goroutine is the Go way of using threads
- We open a goroutine just by invoking any function wit a `go` prefix
- `go functionCall()`
- The `main` function creates the main goroutine
- The program terminates when the main function reaches the end
- Nested functions will be executed in the parent function goroutine
- All Goroutines access the same variables and the same memory
func printMessage(text string) {
	for i := 0; i < 10; i++ {
		fmt.Println(text)
        time.Sleep(time.Millisecond * 800)

func main() { // main goroutine
    go printMessage("Go is great!")
    go printMessage("Frontend Masters Rocks!")
    printMessage("We miss classes!")
## Channels
- Goroutines can communicate through channels, as special type of variable
- A channel contains a value of any kind
- A routine can define a value for a channel and other routines can wait for that value
- Channels can be buffered or not
- To avoid deadlocks you need to close the channels before ending the program with `close(chan)`
var m1 chan string       // channel defintion
m2 :== make(chan string) // construct the channel with make

m2 <- "hello"        // send a message to a channel
message := <-m2     // waiting on a message
### Buffered Channels
- Adding and pulling from channels
logs := make(chan string, 2)
logs <- "hello"
logs <- "world"
fmt.Println(<-messages)
fmt.Println(<-messages)
## Wait Group
- A way to wait on a group of Goroutines
- A counter that is getting add to and subtracted from
- When it reaches 0 its done
func main() {
	currencies := []string{"BTC", "ETH", "BCH"}
	var wg sync.WaitGroup

	for _, currency := range currencies {
		wg.Add(1)
		go func(currentCurrency string) {
			getCurrencyData(currentCurrency)
			wg.Done()
		}(currency)

	wg.Wait()
## Testing
- Included with Go
- A test is a file with suffix `_test.go`
- Tests usually go in the same folder as the source, side by side
- You define functions with prefix `Test` and with a special signature receiving a `*testing.T` argument
- The function inside calls methods of `T`
- You can create subtests as goroutines
- Use the CLI with `go test`
- TableDrivenTest design pattern is commonly used
- Fuzzing from 1.19
	- Automated testing that manipulates input to find bugs. Go fuzzing uses coverage guidance to find failures and is valuable in detecting security exploits and vulnerabilities
- The `_test` package suffix in the package name allows you to write tests as an external user of the package. To test unexported functions you can use the package name
func TestAPICall(t *testing.T) {
	_, err := api.GetRate("")
	if err == nil {
		t.Errorf("Error was not found")
## Go Templates
- HTML templates in Go code
- Under the `html/package` package
- The template can include expressions in `{{ . }}`
- Trimming spaces available with `{{- . -}}`
- Can mix actions and pipelines
- If-else conditionals
- range for loops
- Can call functions
- Usually use the `.tmpl` extension
- First create a template and then execute it to replace the parameters
- Can only pass one value to the template with a `.`
import "html/template"

type Person struct {
	Name string

func main() {
	t := template.New("my-template").Parse(`
		 <!DOCTYPE html>
		 <title>My Website</title>
		 <h1>{{.Name}}</h1>
	`)

	person := Person{Name: "Jane Doe"}
	output, err := t.ExecuteToString(person)
## Compiling
- To compile the project `go build .`
- To compile in one specific output folder `go build . -o build/`
- To compile for other platforms and OS `env GOOS=target-OS GOARCH=target-arch go build .`
- Compile and install `go install .`
## Packaging
- Go just produces a binary
- It doesn't provide any packaging solution
- If we want to embed assets for an app we need to use third party OSs tools:
	- Embed [directive](https://gobyexample.com/embed-directive) `//go:embed`
	- Creating installers for Windows
	- Create a DMG package for MacOS
	- Create RPM or DEB packages for Linux
	-
