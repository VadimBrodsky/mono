# Intro to Go Training

- [Syntax](go/Syntax)
- [Declaring Variables](go/Declaring Variables)
- [Zero Values](go/Zero Values)
- [Nil](go/Nil)



### Naming Rules
- Variable names must only be one word (as in no spaces)
- Variable names must be made up of only letters, numbers, and underscore (_)
- Variable names cannot begin with a number
- While variables are case sensitive, the case of the first letter of a variable has special meaning in Go. 
- If a variable starts with an uppercase letter, then that variable is accessible outside the package it was declared in (or exported).
- If a variable starts with a lowercase letter, then it is only available within the package it is declared in.

### Naming Style
- It is common in Go to use very terse (or short) variable names.
- Given the choice between using `userName` and `user` for a variable, it would be idiomatic to choose `user`.
- Scope also plays a role in the terseness of the variable name. The rule is that the smaller the scope the variable exists in, the smaller the variable name.
- The style is to used `MixedCaps` or `mixedCaps` rather than underscores for multiword names.
- Acronyms should be capitalized, `serveHTTP` and `userID`

### Multiple Assignment
- Go also allows you to assign several values to several variables within the same line. Each of these values can be of a different data type:
- This approach to assigning multiple variables to multiple values in one line can keep your lines of code down, but make sure you are not compromising readability for fewer lines of code.

```golang
j, k, l := "gopher", 2.05, 15
```

### Numeric Types
- Go has two types of numeric types.
- The first type is an `architecture independent` type.This means that regardless of the architecture you compile for, the type will have the correct size (bytes).
- The second type is a `implementation specific` type, and the byte size of that numeric type can vary based on the architecture the program is built for.

Go has the following architecture-independent numeric types:

```
uint8       unsigned  8-bit integers (0 to 255)
uint16      unsigned 16-bit integers (0 to 65535)
uint32      unsigned 32-bit integers (0 to 4294967295)
uint64      unsigned 64-bit integers (0 to 18446744073709551615)
int8        signed  8-bit integers (-128 to 127)
int16       signed 16-bit integers (-32768 to 32767)
int32       signed 32-bit integers (-2147483648 to 2147483647)
int64       signed 64-bit integers (-9223372036854775808 to 9223372036854775807)
float32     IEEE-754 32-bit floating-point numbers (+- 1O-45 -> +- 3.4 * 1038 )
float64     IEEE-754 64-bit floating-point numbers (+- 5 * 10-324 -> 1.7 * 10308 )
complex64   complex numbers with float32 real and imaginary parts
complex128  complex numbers with float64 real and imaginary parts
byte        alias for uint8
rune        alias for int32
```

In addition, Go has the following implementation specific types:

```
uint     either 32 or 64 bits
int      same size as uint
uintptr  an unsigned integer large enough to store the uninterpreted bits of a pointer value
```

In Go, picking the correct type usually has more to do with performance for the target architecture you are programming for than the size of the data you are working with. However, without needing to know the specific ramifications of performance for your program, you can follow some of these basic guidelines when first starting out.

For integer data, it's common in Go to use the implementation types like `int` or `uint`. This will typically result in the fastest processing speed for your target architecture.

If you know you won't exceed a specific size range, then picking an architecture-independent type can both increase speed decrease memory usage. To understand integer ranges, we can look at the following examples:

```
int8 (-128 -> 127)
int16 (-32768 -> 32767)
int32 (− 2,147,483,648 -> 2,147,483,647)
int64 (− 9,223,372,036,854,775,808 -> 9,223,372,036,854,775,807)

uint8 (with alias byte, 0 -> 255)
uint16 (0 -> 65,535)
uint32 (0 -> 4,294,967,295)
uint64 (0 -> 18,446,744,073,709,551,615)

float32 (+- 1O-45 -> +- 3.4 * 1038 )
(IEEE-754) float64 (+- 5 * 10-324 -> 1.7 * 10308 )
```

### Number Conversions
- Because Go is a typed language, when working with different number types, conversions may need to be made when performing calculations.
- If two numbers of are the same type, no conversion is needed.
- If two numbers are of different types, the developer will need to decide which conversion to use. Failing to do so will result in a compilation error.
- To allow two different numeric types to be used in a calculation, you have to explicitly convert each value as necessary.

```golang
Cup := 8
Pint := Cup * 2

Quart := int32(Pint * 2)
Gallon := int32(Quart * 4)

fmt.Println("1 cup and 2 quart is", Cup+int(Quart)*2, "ounces")
fmt.Println("1 cup and 2 gallons is", Cup+int(Gallon)*2, "ounces")
```

### Overflow vs. Wraparound
- Go has the potential to both `overflow` a number as well as `wraparound` a number.
- An overflow happens when you try to store a value larger than the data type was designed to store.
- When one happens vs. the other  s dependent on if the value can be calculated at compile time or at runtime.
- At compile time, if the compiler can determine a value will be too large to hold in the data type specified, it will throw an `overflow` error.
- This means that the value you calculated to store is too large for the data type you specified.
- Understanding the boundaries of your data will help you avoid potential bugs in your program in the future.
- There is no saturation in Go.

```golang
var maxUint8 uint8 = 255      // Max Uint8 size
maxUint8 + 1                  // Wraparound would be 0
var maxUint8 uint8 = 255 + 1  // will be caught at compile time
```

### Booleans
- The Boolean data type (`bool`) can be one of two values, either true or false.
- We use Booleans in programming to make comparisons and to control the flow of the program.

### Strings
- Strings exist within either back quotes or double quotes in Go and have different characteristics depending on which quotes you use.
- If you use the back quotes, you are creating a raw string literal. 
- If you use the double quotes, you are creating an interpreted string literal.

```golang
a := "Say \"hello\" to Go!"
```

### Runes
- A rune is a special type in go that represents special characters.
- Wrapping UTF-8 characters.
- You can define a rune using the single quote (') character:
- A `rune` is an alias for `int32`. A rune can be made up of `1` to `3` int32 values.

```golang
a := 'A'
```

### Constants
- Constants are like variables, except they can't be modified once they have been declared.
- Constants can only be a character, string, boolean, or numeric value.
- Constants can be `untypted`.
- This can be useful when working with numbers such as integer type data.
- If the constant is `untyped`, it is explicitly converted, where typed constants are not.
- Remember that the `untyped const` or `var` will be converted to the type it is combined with for any mathematical operation.
- If you don't know if your constant has to be typed default to leave them untyped.

```golang
const gopher = "Genny"

const (
	year     = 365        // untyped
	leapYear = int32(366) // typed
)
```

### Iota
- Used for enum values, but not always a good feature.
- Go's iota identifier is used in `const` declarations to simplify definitions of incrementing numbers.
- Because it can be used in expressions, it provides a generality beyond that of simple enumerations.
- The value of `iota` starts from `0` in each discreet `const` block.

```golang
const (
	Apple int = iota
	Orange
	Banana
)

func main() {
	fmt.Printf("The value of Apple is %v\n", Apple)     // 0
	fmt.Printf("The value of Orange is %v\n", Orange)   // 1
	fmt.Printf("The value of Banana is %v\n", Banana)   // 2
}
```

- Changing the order of the defined constants in an iota block will change their values.
- Therefore it is very important that you understand how this will affect your code before you change the order.

```golang
const (
  January Month = 1 + iota
  February
  March
  April
  May
  June
  July
  August
  September
  October
  November
  December
)

const (
	_  = 1 << (iota * 10) // ignore the first value
	KB                    // decimal:       1024 -> binary 00000000000000000000010000000000
	MB                    // decimal:    1048576 -> binary 00000000000100000000000000000000
	GB                    // decimal: 1073741824 -> binary 01000000000000000000000000000000
)
```

- Best practice to avoid them due to the potential brittle nature that changing the order can create.
- Even with something as complex as the shifting multiplier example we saw, we could re-write it as just constants and ensure that the code is not brittle.

```golang
const (
	KB = 1024       // binary 00000000000000000000010000000000
	MB = 1048576    // binary 00000000000100000000000000000000
	GB = 1073741824 // binary 01000000000000000000000000000000
)
```

## Print
- Using print is very useful in debugging your
- `Println` will automatically add a line return, but will not use format verbs
- `Printf` will use format verbs to assemble a string with arguments you pass in Note: You have to use a \n newline symbol if you want to add a line return at the end
- You can send in as many arguments as you want to the `Println` function.
- `Println` will automatically put spaces between all arguments when it prints them out.


```golang
:w
import "fmt"

func main() {
	fmt.Println("Print a statement followed by a line return")
	fmt.Printf("Hello %s\n", "gopher")
	fmt.Println("So many arguments", "carrot", "onion", "potato", "tomato", "celery", "spinach")
}
```

- All `Printf` statements can use verbs.
- These verbs will create different styles of formatting. Verbs are usually proceeded by a `%` or `\` character.
- You can use the `+` operator when formatting structs and it will result in the print statement showing both the field and the value, instead of just the value.

```
Use %v to print the value
Use %s to print a string
Use %q to quote a string
Use %d to print a decimal (int, int32, etc)
Use %.2f to fomrmat floating point numbers with a decimal percision of 2
Use %T to print out the data type of the variable
Use \ to escape a character, like a quote:  \"
Use \n to print a new line (line return)
Use \t to insert a tab
Use %+v to print the name and value
```

### Can also pad numbers
- 06 means pad the number up to six places using a leading 0
- 6 means pad the number up to six places using spaces
- Using a - will right justify the number
- Using a * allows you to pass a variable for the amount of padding you desire.

```golang
fmt.Println("Left pad numbers")
fmt.Printf("|%06d|%6d|\n\n", 12, 345)

fmt.Println("Right pad numbers")
fmt.Printf("|%0-6d|%-6d|\n\n", 12, 345)

fmt.Println("Use a variable of value 6 to define the width")
width := 6
fmt.Printf("|%0*d|\n", width, 12)
fmt.Printf("|%*d|\n\n", width, 12)

fmt.Println("Use a variable of value 3 to define the width")
width = 3
fmt.Printf("|%0*d|\n", width, 12)
fmt.Printf("|%*d|", width, 12)
```

### Explicit Argument Indexes
- The default behavior for print format commands is for each formatting verb to format successive arguments passed into the call.

```golang
fmt.Printf("explicit: %[4]s %[3]s %[2]s %[1]s\n", "one", "two", "three", "four")
fmt.Printf("repeated: %[1]s %[1]s %[2]s %[2]s\n", "one", "two")
```

## Structs
- A `struct` is a collection of fields, often called members (or attributes).
- Structs are used to create custom complex types in Go.
- When trying to understand structs, it helps to think of them as a blueprint for what the new type will do.
- A struct definition, does NOT contain any data

### Defining a Struct

```golang
type User struct {
	Name  string
	Email string
}
```

### Initializing Structs

```golang
// without initial values
u := User{}

// with initial values
u := User{
	Name:  "Homer Simpson",
	Email: "homer@example.com",
}

// Fields can be referenced using a period and the field name
fmt.Println(u.Name)

// You can set as many of the field values on a struct at initialization time as you want
u := User{Email: "marge@example.com"}
u.Name = "Marge Simpso

// can also initialize without a field name, but its less advised
u := User{"Homer Simpson","homer@example.com"}
```

### Struct Tags
- Struct tags are small pieces of metadata attached to fields of a struct that provide instructions to other Go code that works with the struct.
- A struct tag looks like this, with the tag offset with backtick characters
- Other Go code is then capable of examining these structs and extracting the values assigned to specific keys it requests.
- Struct tags have no effect on the operation of your code without some other code that examines them.

```golang
type User struct {
    Name string `example:"name"`
}
```

#### Struct Tags for Encoding
- A common use for struct tags is for encoding the data of your struct to some type of other format.
- `JSON`, `XML`, `Protobuf`, etc are examples of these types of encoding.

```golang
type User struct {
	ID       int    `json:"id"`
	Name     string `json:"name"`
	Phone    string `json:"phone,omitempty"`
	Password string `json:"-"`
}
```

#### Printing Structs
- Using the %+v verb is helpful in showing the field names within a struct:

```golang
// using %+v shows the field names in the struct when it prints out
fmt.Printf("user: %+v\n", u)
```

## Arrays
- Useful when planning for a detailed layout of memory
- Using arrays can sometimes help avoid allocation
- Fixed length, fixed type, zero based
- The capacity of an array is defined at creation time.
- Once an array has allocated it's size, the size can no longer be changed
- The zero value of each element in an array is the zero value for the type of elements in the array.

```golang
names := [4]string{}
names[0] = "John"
names[1] = "Paul"
names[2] = "George"
names[3] = "Ringo"

// or assined at initialization time
names := [4]string{"John", "Paul", "George", "Ringo"}

// with zero values
names := [4]string{}
ints := [4]int{}
```

### Indexing Arrays
- You will receive an error (either compile time or a `panic`) when trying to access an index of the array beyond it's size.

```golang
names[4] = "Stu"
```

### Array Type Definition
- The length is actually part of the type that is defined for arrays.
- If you create two like arrays, and then set the value of one array to the other, they still continue to have their own memory space.

```golang
a1 := [2]string{"one", "two"}
a2 := [2]string{}

a2 = a1

fmt.Println(a2)
a3 := [3]string{}

// This can't be done, as it is not of the same type
//a3 = a2
```

### Two Dimensional Arrays
- Go's arrays are one-dimensional.
- To create an equivalent of a 2D array, it is necessary to define an array-of-arrays.

```golang
// A 3x3 array, really an array of arrays.
type Matrix [3][3]int

m := Matrix{
  {0, 0, 0},
  {1, 1, 1},
  {2, 2, 2},
}
```

## The for Loop
- In Go there is only one looping construct; the `for` loop.

```golang
for i := 0; i < N; i++ {
  // do work until i equals N
}
```

### Iterating Over Arrays
- Iterating over arrays is done using a `for` loop.
- The `len` function returns the length of the array (4).

```golang
names := [4]string{"John", "Paul", "George", "Ringo"}

for i := 0; i < len(names); i++ {
  fmt.Println(names[i])
}
```

### Continuing a Loop
- The `continue` keyword allows us to go back to the start of the loop and stop executing the rest of the code in the for block.
- This does not stop the loop from executing, but rather ends that particular run of the loop.

```golang
for {
  if i == 3 {
    // go to the start of the loop
    continue
  }
  // do work
}
```

### Breaking a Loop
- To stop execution of a loop we can use the `break` keyword.
- The for loop is now stopped and will no longer run.

```golang
for {
  if i == 3 {
    // stop looping
    break
  }
  // do work
}
```

### Do While Loop
- A `do while loop` is used in a situation where you want the loop to run at least `1` iteration, regardless of the `condition`.

```golang
var i int
for {
	fmt.Println(i)
	i += 2
	if i >= 3 {
		break
	}
}
```

## The range Keyword
- Using a `len` to get an array length for iteration is dubbed "classic"
- Looping over arrays, and other collection types, is so common that Go created the `range` tool to simplify this code.
- Range returns the index and the value of the array.

```golang
names := [4]string{"John", "Paul", "George", "Ringo"}

for i, n := range names {
  fmt.Printf("%d - %s\n", i, n)
}
```

## Slices
- Similar to Arrays
- Fixed type
- Dynamically sized
- Flexible

```golang
// create an array of names
namesArray := [4]string{"John", "Paul", "George", "Ringo"}
// create a slice of names
namesSlice := []string{"John", "Paul", "George", "Ringo"}
```

### Iterating Over Slices

```golang
names := []string{"John", "Paul", "George", "Ringo"}

for i, n := range names {
  fmt.Printf("%d - %s\n", i, n)
}
```

### Why Slices?
- Change a slice without an allocation
- Operate on subsections of slices easily
- Dynamically grow the size of a slice
- Slices don't have a length in the declaration

```golang
var array [5]string // array
var slice []string  // slice
```

### Slice Internals
- Slices wrap arrays and provide a more general, powerful, and convenient interface to data sequences
- Unless you know that your list will contain a finite and fixed set of elements, you'll almost always use a slice when dealing with data.
- Should the slice not have enough space, Go will automatically reallocate the slice to have more capacity.
- It will create a new underlying array, copy the original values into the new one, and add the new values as well.
- Think of a slice as having three members:

```golang
type slice struct {
	Length   int
	Capacity int
	Array    [10]array
}
```

### Appending to Slices
- The `append` keyword allows us to add elements to a slice.
- Always collect the reference back from `append`.


```golang
names := []string{}
names = append(names, "John")

// Append multiple items at once
names = append(names, "Sally", "George")

// Append an entire slice to another slice
moreNames := []string{"Bill", "Ginger", "Wilma"}
names = append(names, moreNames...)
```

### Growing a Slice
- Introspect a slice with `len` and `cap`
- The `len` keyword tells us how many elements the slice actually has.
- The `cap` keyword tells us the capacity of the slice, or how many elements it can have.

```golang
names := []string{}
fmt.Println("len:", len(names)) // 0
fmt.Println("cap:", cap(names)) // 0

names = append(names, "John")
fmt.Println("len:", len(names)) // 1
fmt.Println("cap:", cap(names)) // 1

names = append(names, "Paul")
fmt.Println("len:", len(names)) // 2
fmt.Println("cap:", cap(names)) // 2

names = append(names, "George")
fmt.Println("len:", len(names)) // 3
fmt.Println("cap:", cap(names)) // 4

names = append(names, "Ringo")
fmt.Println("len:", len(names)) // 4
fmt.Println("cap:", cap(names)) // 4

names = append(names, "Stu")
fmt.Println("len:", len(names)) // 5
fmt.Println("cap:", cap(names)) // 8
```

### Making a Slice
- Slices can also be created using the `make` keyword.
- The `make` keyword allows us to define the starting "length" of the slice, and optionally, the starting "capacity" of the slice.
- It's important to remember that even though you allocated extra capacity, you can't access that capacity until you assign a value to it.

```golang
a := []string{}         // this is the idiomatic way
b := make([]string, 0)
var c []string

// makes a slices of ints with length of 1 and capacity of 3
a := make([]int, 1, 3)
```

### Make and Append
- Be careful when using both `make` and `append`, as you may inadvertently create zero values in your slice.

```golang
a := make([]string, 2)        // length of 2 with zero values of ""
a = append(a, "foo", "bar")
```

### Two Dimensional Slices
- Go's slices are one-dimensional.
- To create an equivalent of a 2D slice, it is necessary to define an slice-of-slices.
- Because slices are variable-length, it is possible to have each inner slice be a different length.

```golang
type Modules [][]string

course := Modules{
	[]string{"Chapter One: Syntax"},
	[]string{"Chapter Two: Arrays and Slices"},
	[]string{"Chapter Three: Maps", "Chapter Four: Packages"},
}
```

### Slice Subsets
- Subsets of a slice (or a slice of a slice) allow us to work with just section of a slice.
- You can not use negative numbers in slices.
- Index [staring : starting + length]
- From the beginning [ : starting + length]
- Until the end [ starting : ]

```golang
// slice[starting_index : (starting_index + length)]

names := []string{"John", "Paul", "George", "Ringo"}

fmt.Println(names) // [John Paul George Ringo]

// Get 2 elements starting with the second element (index 1)
names[1:3] // [Paul George] - names[1:1+2]

// functionally equivalent
names[2:len(names)] // [George Ringo]
names[2:]           // [George Ringo]

// functionally equivalent
names[0:2] // [John Paul]
names[:2]  // [John Paul]
```

### Mutating Slice Subsets
- When grabbing a subset of a slice, you are just getting a "window" into that slice.
- If you mutate the subset, you mutate the original slice.
- Rule of thumb: don't mutate a sub slice unless you don't care about the original slice

### Copy
- Use the `copy` keyword to make a copy without sharing reference to the original underlying array.

```golang
original := []string{"carrot", "potato", "cucumber", "onion"}
// create a new reference to the existing slice
ref := original

// initialize a variable named 'dup' to the same size as the original slice
dup := make([]string, len(original))

// copy the values from original to dup
// NOTE: if the slices are not the same size, it will only copy what it has space for (length)
copy(dup, original)

// changing either `ref` or `original` will change either
// of them as they still share the reference to the same backing array
ref[0] = "zuchinni"
original[1] = "tomato"

fmt.Println("original: ", original)
fmt.Println("ref:      ", ref)
fmt.Println("dup:      ", dup)
```

## Maps
- Maps are a powerful built-in data structure that associates keys and values.
- A map is an unordered set of values indexed by a unique key.
- Sets the types for the keys and values.

```golang
beatles := map[string]string{}

beatles["John"] = "guitar"
beatles["Paul"] = "bass"
beatles["George"] = "guitar"
beatles["Ringo"] = "drums"
```

Maps can have their values assigned at creation time, just like arrays.

```golang
beatles := map[string]string{
  "John":   "guitar",
  "Paul":   "bass",
  "George": "guitar",
  "Ringo":  "drums",
}
```

### Uninitialized Maps
You can initialize maps two different ways:

```golang
emails := map[string]string{
	"cory@gopherguides.com": "Cory LaNou",
	"mark@gopherguides.com": "Mark Bates",
	"tim@gopherguides.com":  "Tim Raymond",
}

var emails map[string]string      // emails is nil here
emails = make(map[string]string)  // actually create the map
emails["cory@gopherguides.com"] = "Cory LaNou"
emails["mark@gopherguides.com"] = "Mark Bates"
emails["tim@gopherguides.com"] = "Tim Raymond"
```

If you don't initialize them, and try to access the values, you will receive a runtime error

### Length and Capacity
- The `len` function can be used to find the length (the number of keys) in the map.
- Maps don't have a capacity, since they can grow as needed, so the cap function would raise an error.


### Map Values
- Map values can be set and retrieved using the [] syntax.

```golang
	beatles := map[string]string{}
	beatles["Paul"] = "bass"
	paul := beatles["Paul"]
```

### Iterating Maps
- Maps can be iterated over in the same ways as arrays and slices.
- The `range` keyword, in the case of maps, returns the `key` and the `value` for each entry in the map.
- When iterating over a map with a range loop, the iteration order is not specified and is not guaranteed to be the same from one iteration to the next.

```golang
for key, value := range beatles {
	fmt.Printf("%s plays %s\n", key, value)
}
```

### Map Keys
- You can't use functions, maps, or slices as the keys in your maps.
- Some structs are ok, but again, can't contain complex types.

```golang
type simple struct {
	ID int
}

type complex struct {
	f func(id int) simple
}

m := map[simple]string{}

// invalid map key type complex
m1 := map[complex]string{}
```

### Deleting Keys From a Map
- The `delete` function can be used to remove a key, and its value, from a map.
- Deleting items that are not contained by the map would not error

```golang
beatles := map[string]string{
  "John":   "guitar",
  "Paul":   "bass",
  "George": "guitar",
  "Ringo":  "drums",
}

delete(beatles, "John")

fmt.Println(beatles)
// map[Paul:bass George:guitar Ringo:drums]
```

### Checking Map Values
- Maps in Go return an optional second argument that will tell you if the key exists in the map

```golang
key := "Paul"

value, ok := beatles[key]
if ok {
	fmt.Printf("Found key %q: %q", key, value) // Found Key "Paul": "bass"
} else {
	fmt.Printf("Key not found: %q", key)       // Key not found: "foo"
}
```

Which can, and will often be, simplified as the following:

```golang
key := "Paul"

if value, ok := beatles[key]; ok {
	fmt.Printf("Found key %q: %q", key, value) // Found Key "Paul": "bass"
} else {
	fmt.Printf("Key not found: %q", key) // Key not found: "foo"
}
```

### Testing Presence Only
- There may be times when you don't want the value and only want to test for presence.
- You can use the `_` (underscore) operator to ignore the value in these situations.

```golang
_, exists := words["foo"]
```

### Updating Complex Map Values
When updating complex map values, you have to retrieve the value, make your changes, and set it back into the map:

```golang
type Beatle struct {
	Name       string
	Instrument string
}

beatles := make(map[string]Beatle)

// Create Beatle dynamically
beatles["John"] = Beatle{Name: "John", Instrument: "guitar"}

// Create Beatle from an instance
b := Beatle{Name: "Paul", Instrument: "bass"}
beatles[b.Name] = b

b = Beatle{Name: "George"}
beatles[b.Name] = b

b = Beatle{Name: "Ringo", Instrument: "Drums"}
beatles[b.Name] = b

// Fix George:

// Lookup George
b, ok := beatles["George"]
if !ok {
	fmt.Println("couldn't find George...")
	return
}

// Update George
b.Instrument = "guitar"

// Update the map with the new value
beatles[b.Name] = b
```

### Copy on Update
- When you insert into a map, it takes a copy of what you are inserting, and you no longer have a reference to the value stored in the map.

```golang
type Beatle struct {
	Name       string
	Instrument string
}

beatles := make(map[string]Beatle)

b := Beatle{Name: "Paul", Instrument: "bass"}
beatles[b.Name] = b
// change the value after being inserted into the map
b.Instrument = "foo"

fmt.Println("variable:", b)         // variable: {Paul foo}

// retrieve the value from the map
lookup := beatles["Paul"            // lookup: {Paul bass}
fmt.Println("lookup:", lookup)
```

### Getting Map Keys
Go does not provide a way to get just a list of keys, or values, from a map. To do this you must build that list yourself.

```golang
m := map[string]string{
  "foo": "bar",
  "bin": "baz",
  "boo": "woo",
}

keys := make([]string, 0, len(m))

for k := range m {
  keys = append(keys, k)
}
```

### Maps and Concurrency
- Maps are NOT concurrent safe! This is important to know, as it can be the cause of many bugs.

```golang
numbers := map[int]int{}
for i := 0; true; i++ {
  go func(i int) {
    numbers[i] = i
  }(i)
}
```

## Pointers
A pointer is a type that holds the address to the value of a variable.

### Values
- By default, Go handles all variables as `values`.
- This means that any time we work with a variable, the scope plays a part as to whether we are modifying the original value, or a `copy` of the value.

### Passing The Value
- Go passes all data by value (copy), including pointers.

```golang
type Beatle struct {
	Name string
}

func main() {
	b := Beatle{Name: "Ringo"}
	changeBeatleName(b)
	fmt.Println(b.Name) // Ringo
}

func changeBeatleName(b Beatle) {
	b.Name = "George"
	fmt.Println(b.Name) // George
}
```

### Pointer Syntax
- Pointers allow us to point at the original memory space of a value.
- To indicate we are expecting a pointer, we use the `*` modifier:

```golang
func changeBeatleName(b *Beatle) {}
```

To get the address of a value we use the `&` modifier:

```golang
&Beatle{}
b := &Beatle{}
```

### Passing By Pointer
To allow to mutate/change the original variable that was passed in, as we now have a reference to it via the pointer that was passed into the function.

```golang
type Beatle struct {
	Name string
}

func main() {
	b := &Beatle{Name: "Ringo"}
	changeBeatleName(b)
	fmt.Println(b.Name) // George
}

func changeBeatleName(b *Beatle) {
	b.Name = "George"
	fmt.Println(b.Name) // George
}
```

or with a slightly different syntax

```golang
type Beatle struct {
	Name string
}

func main() {
	b := Beatle{Name: "Ringo"}
	changeBeatleName(&b)
	fmt.Println(b.Name) // George
}

func changeBeatleName(b *Beatle) {
	b.Name = "George"
	fmt.Println(b.Name) // George
}
```

### Dereferencing
We can dereference a pointer with the `*` as well.

```golang
// Create a new pointer to a string
ps := new(string)

// Set the value of ps by dereferencing the pointer
*ps = "hello"

// Capture a new "value" as a string
s := *ps

// ps type:                *string
// ps value:               0xc000092030
// dereferenced value:     "hello"
// s type:                 string
// s value:                hello
```

### New Function
- The built-in function `new` takes a type `T`
- Allocates storage for a variable of that type at run time
- And returns a value of type `*T` pointing to it
- The variable is initialized with it's zero value

```golang
s := new(string)
i := new(int)

type foo struct {
	id   int
	name string
}
f := new(foo)
// Functionally equivalent to this:
f1 := &foo{} // this is the idiomatic preferred style now

fmt.Printf("s: %v, *s: %q\n", s, *s)
fmt.Printf("i: %v, *i: %d\n", i, *i)
fmt.Printf("f: %v, *f: %+v\n", f, *f)
fmt.Printf("f1: %v, *f1: %+v\n", f1, *f1)

// s: 0xc000092030, *s: ""
// i: 0xc000094000, *i: 0
// f: &{0 }, *f: {id:0 name:}
```

### Pointers in Structs
- Care must be taken when passing structs by value that have pointers as fields.
- Even though everything is passed as a value (i.e. copy of the original), if it is a pointer, it still points to the original value, thus allowing for it to be modified.

```golang
type User struct {
	First string
	Last  string
	Email *string
}

func main() {
	u := User{}
	u.First = "Rob"
	u.Last = "Pike"
	u.Email = new(string)
	*(u.Email) = "commander@google.com"

	fmt.Println(u.First, u.Last, *u.Email)
	reset(u)
	fmt.Println(u.First, u.Last, *u.Email)
}

// even though we pass by value, it has an underlying pointer, which we have reference to a memory space and can mutate that variable.
func reset(u User) {
	u.First = ""
	u.Last = ""
	*(u.Email) = "nobody@google.com"
}
```

- Even though the `User` is passed by value, the `Email` is a pointer to a string.
- A copy of a pointer is still the original address of the value being pointed at.
- As such, you can expose fields unintentionally when they are a pointer in a struct.

### Panic
Accessing a pointer that has not been initialized will result in a runtime panic:

```golang
var s *string
*s = "boom"
```

### When to Use Pointers?
- You want others to be able to modify your values or
- You have a large (memory) value that you don't want to keep copying (This is typically done as a result of profiling and you have proven this is an actual performance issue)

## Functions
Functions in Go are a primitive type

```golang
func sayHello() {
	fmt.Println("Hello")
}

func main() {
	sayHello()
}
```

### Arguments
- Functions can take `N` number of arguments, including other functions.
- The type of the argument follows the name of the argument.
- Identical typed arguments can be declared once.
- Both examples are functionally identical. Although for clarity the more explicit (longer) version is preferred.

```golang
func sayHello(greeting string) {
	fmt.Println(greeting)
}


func sayHello(greeting, name string) {
	fmt.Printf("%s, %s", greeting, name)
}
```

### Return Arguments
- Functions can return `0` to `N` numbers of values
- Though it is considered best practice to not return more than two or three.
- When returning an `error` it is considered best practice to return that value as the last value.
- The type of the return value(s) is declared after the function definition.
- Multiple return arguments need to be placed inside of ().

```golang
func one() string
func two() (string, error)
func three() (int, string, error)

func sayHello() string {
	return "Hello"
}

func slicer(s []string) (int, int) {
	return len(s), cap(s)
}

// use it
l, c := slicer([]string{"John", "Paul", "George", "Ringo"})
```

### Named Returns
- The return of a go function can be given a name and used just like a variable declaration.
- Initialized with zero value in function scope
- Executing a return with no value will return the value of the named return.
- Names are not mandatory
- It is best practice to not use named returns, unless they are needed for documentation.
- Using named returns should only be used for documentation purposes. Even then, it could be argued to never use it.

```golang
func exists() (exist bool) {
    exist = true
    return
}

// named returns with types
func coordinates() (lat, lng int)
```

### Shadowing
- Go has the ability to `shadow` a variable.
- As such, care must be taken to ensure you are accessing the proper variable instance.
- It's very common to shadow errors as a result of calling functions and being inside another scope, such as a loop:

```golang
func main() {
	err := boom()
	fmt.Println(err)
	for i := 5; i >= -1; i-- {
		n, err := inc(i) // err get's shadowed here
		if err != nil {
			fmt.Println(err)
			continue
		}
		fmt.Println(n)
	}
	fmt.Println(err)
}
```

While shadowing isn't usually an issue, it's something to be aware of to ensure you don't use the wrong scope of a variable.


### Variadic Arguments
- Functions can take variadic arguments, meaning `0` to `N` arguments of the same type.
- This is done by prepending the type of the argument with `...`
- The variadic argument must be the last one

```golang
func sayHello(names ...string) {
	for _, n := range names {
		fmt.Printf("Hello %s\n", n)
	}
}

// use it
sayHello("John", "Paul", "George", "Ringo")
```

### Exploding Variadic Arguments
- Slices can be "exploded" using trailing `...` to send them as variadic arguments to a function.
- Cannot send a slice, need to explode it into separate types

```golang
beatles := []string{"John", "Paul", "George", "Ringo"}
sayHello(beatles...)
```

### When to Use a Variadic
- While using a variadic argument is not the common use case
- It certainly can make your code look nicer and easier to read and use
- The most common reason to use a variadic is when your function is commonly called with `zero`, `one`, or `many` arguments.


## Methods
- Methods are syntactic sugar for declaring functions on types.


```golang
type Beatle struct {
	Name       string
	Instrument string
}

func (b Beatle) String() string {
	return fmt.Sprintf("%s plays %s", b.Name, b.Instrument)
}

func main() {
	b := Beatle{Name: "Ringo", Instrument: "Drums"}
	fmt.Println(b.String()) // Ringo plays Drums
}
```

- Methods also allow us to namespace a function to a receiver.
- Both functions are equivalent, but the former namespaces the String function to the Beatle type, allowing us to have multiple String functions with different receivers.

```golang
func (b Beatle) String() string {
	return fmt.Sprintf("%s plays %s", b.Name, b.Instrument)
}

func String(b Beatle) string {
	return fmt.Sprintf("%s plays %s", b.Name, b.Instrument)
}

func main() {
	b := Beatle{Name: "Ringo", Instrument: "Drums"}
	fmt.Println(b.String()) // Ringo plays Drums
	fmt.Println(String(b))  // Ringo plays Drums
}
```

### Value vs. Pointer Receivers
- You can define a receiver for a method as either a value or a pointer receiver. They will behave differently.
- You can define a receiver for a method as either a value or a pointer receiver. They will behave differently.

```golang
type User struct {
	First string
	Last  string
}

// Pointer Receiver
func (u *User) Titleize() {
	u.First = strings.Title(u.First)
	u.Last = strings.Title(u.Last)
}

// Value Receiver
func (u User) Reset() {
	u.First = ""
	u.Last = ""
}

func main() {
	u := User{First: "cory", Last: "lanou"}
	u.Titleize()
	fmt.Println(u)

	// Reset can't mutate the data as it's defined with a value receiver
	u.Reset()
	fmt.Println(u)
}
```

### Nil Receivers
- Care must be taken when using pointer receivers. If the receiver itself is nil, you can still call methods that don't reference the receiver, but if you call a method that does reference a receiver, it will panic with a nil pointer dereference.
-

### Nil Receivers Checks
- You can check to see if the receiver is nil before referencing it. While this may work in some scenarios, it may inadvertently end up as a Nop in your code and therefore fail silently, creating a very difficult bug to find later on.
- You must decide is it better for the code to panic, or better for the code to fail silently. In most cases, you would prefer a panic and make sure you have test coverage to ensure this doesn't happen at runtime.

```golang
type User struct {
	First string
	Last  string
}

func (u *User) Reset() {
	if u == nil {
		return
	}
	u.First = ""
	u.Last = ""
}

func (u *User) IAmGroot() string {
	return "I am Groot"
}

func main() {
	var u *User

	fmt.Println(u.IAmGroot())

	u.Reset()
}
```

### Methods Expressions
- Methods are really just syntactic sugar for functions that are name-spaced to a concrete type.
- While we typically don't use them in the fashion shown below, this may help understand that the receiver is in fact just the first argument in the function call.

```golang
type User struct {
	First string
	Last  string
	Email string
}

func (u User) Notify(msg string) error {
	if err := sendEmail(u.Email, msg); err != nil {
		return err
	}
	return nil
}

func main() {
	// Define a user
	u := User{First: "Cory", Last: "LaNou", Email: "cory@gopherguides.com"}

	// call the "Notify" as a method on "User"
	if err := u.Notify("This is a message as a method"); err != nil {
		fmt.Printf("oh no, something went wrong! %v", err)
		return
	}

	// call the "Notify" method as a function from the concrete type "User"
	if err := User.Notify(u, "This is a message as a method expression"); err != nil {
		fmt.Printf("oh no, something went wrong! %v", err)
		return
	}

	// Notice that a method is just "syntactic sugar" by hanging a
	// function off of a concrete type

	fmt.Println("notification successfully sent")
}

// sendEmail simulates sending an email.
func sendEmail(em, msg string) error {
	fmt.Printf("sending message %q to %q\n", msg, em)
	return nil
}
```

### First Class Functions
- In Go functions are first class citizens. That means we can treat functions as we do any other types.
- Function signatures are a type
- Functions can be arguments and return values to/from other functions
- This function has no name, but is assigned to a variable that can be called later.

```golang
func main() {
	f := func() {
		fmt.Println("Hello")
	}

	f() // Hello
}
```

### Closures
- Functions close over their environment when they are defined. This means that a function has access to arguments declared before its declaration.

```golang
name := "Ringo"
f := func() {
  fmt.Printf("Hello %s", name)
}

f() // Hello Ringo
```

### Functions As Arguments
- Functions in Go can be passed as values to other functions.
- The signature of the function being passed in must match the function signature of the argument in the callee function.

```golang
func main() {
	f := func() string {
		return "Hello"
	}
	sayHello(f)
}

func sayHello(fn func() string) {
	fmt.Println(fn())
}
```

### Anonymous Functions
- Anonymous functions are functions that aren't assigned to a variable,
- or that don't have a "name" associated with them.
- This is a very common pattern in Go, and one you should get comfortable seeing and using in Go code.

```golang
sayHello(func() string {
  return "Hello"
})
```

### Functions As Types
- Function signatures act as a defacto "type", but explicit types can also be created for a function signature.
- Argument declaration is cleaner
- The new type can have other functions hung off it
- The new type can now easily be documented

```golang
type greeter func() string

func main() {
	sayHello(func() string {
		return "Hello"
	})
}

func sayHello(fn greeter) {
	fmt.Println(fn())
}
```

### Functions On Functions
- By creating a new type for a function, we can treat that type like all types in Go,
- and can hang other functions off of it.

```golang
type greeter func() string

func (greeter) Name() string {
	return "World"
}

func sayHello(fn greeter) {
	fmt.Println(fn(), fn.Name())
}
```

### Functions Accepting Arguments From Functions
- You can accept the return arguments of a function into a function, as long as the return types (and number of return arguments) lines up with the number of arguments expected to the calling function.

```golang
func main() {
	takeTwo(returnTwo())
}

func returnTwo() (string, string) {
	return "hello", "world"
}

func takeTwo(a, b string) {
	fmt.Println(a, b)
}
```

### Deferring Function Calls
The `defer` keyword in Go allows us to defer the execution of a function call until the return of the parent function.

```golang
func main() {
	defer goodbye()
	fmt.Println("hello")
}

func goodbye() {
	fmt.Println("goodbye")
}

// hello
// goodbye
```

#### Deferring With Multiple Returns
`defer` is useful for ensuring functions get called regardless of which path your code takes.

```golang
func loadPage() ([]byte, error) {
	resp, err := http.Get("https://www.gopherguides.com")
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close() // <<<
	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("bad status: %d", resp.StatusCode)
	}
	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}
	return b, nil
}
```

#### Defer Call Order
The order of execution for deferred function calls is LIFO (last in, first out).

```golang
func main() {
	defer fmt.Println("one")
	defer fmt.Println("two")
	defer fmt.Println("three")
}

// three
// two
// one
```

#### Deferred Calls And Panic
- Deferred calls will still get called even if another deferred call panics.

```golang
defer fmt.Println("one")
defer panic("two")
defer fmt.Println("three")

// three
// one
// panic: two

// goroutine 1 [running]:
// main.main()
//  main.go:9 +0x1ba
// exit status 2
// shell returned 1
```

#### Defers And Exit/Fatal
- Deferred calls will not fire if the code explicitly calls `os.Exit` or `log.Fatal`

```golang
// os.Exit
defer fmt.Println("one")
os.Exit(1)
defer fmt.Println("three")

// log.Fatal
defer fmt.Println("one")
log.Fatal("boom")
defer fmt.Println("three")
```

#### Defer And Anonymous Functions
- It is also common to combine cleanup tasks into a single defer using an anonymous function.

```golang
defer func() {
  fmt.Println("closing", sourceName)
  src.Close()
}()
```

#### Defer and Scope
- It is important to understand scope when using defer.
- If we take the following code, the output is a bit unexpected:
- The reason that we don't see the proper elapsed time, is because we didn't capture a scope to the now variable to use later in the defer function.
- Because of this, when the defer is added to the stack, it captures the value of now when the defer is scheduled, which in effect will have no elapsed time when it runs later.

```golang
func main() {
	now := time.Now()
	defer fmt.Printf("time since program started: %s\n", time.Since(now))

	fmt.Println("sleeping for 2 seconds...")
	time.Sleep(2 * time.Second)
}

// sleeping for 2 seconds...
// time since program started: 157ns
```

#### Fixing Defer And Scope
- To make sure your variables are evaluated when a `defer` executes, and not when they are scheduled, you need to scope them via an anonymous function.
- When the defer function runs, it will be passed the current value of `now`, instead of evaluating the value of `now` when the defer is scheduled.

```golang
func main() {
	now := time.Now()

	// use an anonymous function to scope variables to be used in the defer
	defer func(now time.Time) {
		fmt.Printf("time since program started: %s\n", time.Since(now))
	}(now)

	fmt.Println("sleeping for 2 seconds...")
	time.Sleep(2 * time.Second)
}

// sleeping for 2 seconds...
// time since program started: 2.004430822s
```

#### Properly Closing Files
- In Go, the rule is to never ignore an error.
- However, when you defer the Close on most types in Go, there is no easy way to handle the error.
- Explicitly call Close even if it's deferred.
- They reason for this is that the documents in Go specify that any call to a Close function should be idempotent, and calling it more than once will be ok.
- In the event that the code returns early, it's because you already encountered an error, and likely the Close is going to also encounter an error related to the same issue, and therefore is not important:

```golang
func closeit() error {
	f, err := os.Create("foo")
	if err != nil {
		return err
	}
	defer f.Close()

	if _, err := f.Write([]byte("bar")); err != nil {
		return err
	}

	if err := f.Close(); err != nil {
		return err
	}
	return nil
}
```

#### Named Returns, Defer, And Scope
- example of where named returns can be very difficult to determine behavior
- This code does not do what most people would expect

```golang
func main() {
	fmt.Println(MeaningOfLife())
}

func MeaningOfLife() (rc int) {
	defer func() { rc++ }()
	return 41
}
// 42
```

#### Init
- Any time you declare an `init()` function,
- Go will load and run it prior to anything else in that package.

```golang
var weekday string

func init() {
	weekday = time.Now().Weekday().String()
}

func main() {
	fmt.Printf("Today is %s", weekday)
}
```

#### Multiple Init Statements
- Unlike the main() function that can only be declared once, the init() function can be declared multiple times throughout a package.
- However, multiple init()s can make it difficult to know which one has priority over the others.
- In this section, we will show how to maintain control over multiple init() statements.

```golang
package main

import "fmt"

func init() {
	fmt.Println("First init")
}

func init() {
	fmt.Println("Second init")
}

func init() {
	fmt.Println("Third init")
}

func init() {
	fmt.Println("Fourth init")
}

func main() {}

// First init
// Second init
// Third init
// Fourth init
```

#### Init Order
- If you have multiple `init()` declarations in a package in different files, the compiler will run them based on the order in which it loads files.
- Given the following directory structure, if you had an `init()` declaration in a.go and b.go, the first `init()` to run would be from a.go. However, if you renamed a.go to c.go, the `init()` from b.go would now run first.
- Care must be taken if any `init()` declarations have an order of precedence when running and exist in different files.

```
└── cmd
    ├── a.go
    ├── b.go
    └── main.go
```

#### Using Init() For Side Effects
- In Go, it is sometimes desirable to import a package not for its content, but for the side effects that occur upon importing the package. 
- This often means that there is an `init()` statement in the imported code that executes before any of the other code, allowing for the developer to manipulate the state in which their program is starting.
- This technique is called importing for a side effect.

```golang
package main

import (
	"fmt"
	"image"
	_ "image/png"
	"io"
	"log"
)

func main() {
	fmt.Println("vim-go")
}

func decode(reader io.Reader) image.Rectangle {
	m, _, err := image.Decode(reader)
	if err != nil {
		log.Fatal(err)
	}
	return m.Bounds()
}
```

This will set the state and register that we require the png version of image.Decode(). This registration will happen as a side effect of importing image/png.

## Interfaces
- Interfaces in Go provide a way to specify the behavior of an object:
- If something can do this, then it can be used here
- The larger the interface, the weaker the abstraction. -- Rob Pike
- Interfaces allow us to specify behavior. They are about doing, not being.
- implicitly not explicitly defined
- Interfaces are found all around the standard library.

### Why Interfaces?
- Interfaces allow us to abstract code to make it more reusable, extensible and more testable.
- For example, imagine a function that takes Beatles, but only calls the Play method on it.
- In order for someone to play at our venue they must be a Beatle.

```golang
func entertain(b Beatle) {
	b.Play()
}
```

Using an interface allows us to open that function up to a larger group of potential types that can implement the interface.

```golang
type Entertainer interface {
	Play()
}

func entertain(e Entertainer) {
	e.Play()
}
```

```golang
type Beatle struct {
	Name       string
	Instrument string
}

type Entertainer interface {
	Play()
}

func (b Beatle) Play() {
	fmt.Printf("%s plays %s", b.Name, b.Instrument)
}

func main() {
	b := Beatle{Name: "Ringo", Instrument: "Drums"}
	entertain(b)
}

func entertain(e Entertainer) {
	e.Play()
}
```

### Duck Typing Or Structural Typing In Go
- In most OO (object oriented) languages you have to explicitly declare that you are implementing an interface.
- However, in Go this is implicit.
- Provided a type implements the all behaviors specified in the interface, it can be said to implement that interface.
- The compiler will check to make sure a type is acceptable and will report an error if it does not.
- Sometimes this is called Duck Typing, but since it happens at compile-time in Go, it is called Structural typing
- The concrete type does not need to know about your interface
- You are able to write interfaces for concrete types that already exist
- You can write interfaces for other people's types, or types that appear in other packages

### Defining an Interface
- You can create an interface with the interface keyword.
- Interfaces define behavior, therefore they are only a collection of methods.
- Interfaces can have zero, one, or many methods.

```golang
type MyInterface interface {
    Method1()
    Method2() error
    Method3() (string, error)
}

// valid
type Writer interface {
	Write(p []byte) (int, error)
}

// invalid
type Emailer interface {
	Email string
}
```

#### Writer Interface
- One of the most well known interfaces in Go is the io.Writer interface.
- The io.Writer interface in the standard library requires the implementation of a Write method that matches the signature of Write(p []byte) (n int, err error).

```golang
type Writer interface {
	Write(p []byte) (int, error)
}
```

#### Using Interfaces

```golang
func main() {
	writeSomething(os.Stdout)
	// Hello
}

func writeSomething(w io.Writer) {
	w.Write([]byte("Hello"))
}
```

#### Multiple Interfaces
Because interfaces are implemented implicitly, it means that types can implement many interfaces without even realizing it.

```golang
type scribe struct {
	data []byte
}

// implements the io.Writer interface
func (s *scribe) Write(p []byte) (int, error) {
	s.data = p
	return len(p), nil
}

// implements the fmt.Stringer interface
func (s scribe) String() string {
	return string(s.data)
}
```

#### Assignability
- Remember that when determining assignability, Go is only concerned with the method set of an interface--not the name of the interface.
- In the eyes of the Go type system, these two interfaces are equivalent, so anything satisfying one interface will also satisfy the other.

```golang
type Greeter interface {
	Greet(string)
}

type Welcomer interface {
	Greet(string)
}
```

```golang
p := &Person{}
var g Greeter = p
var w Welcomer = g

g.Greet("world")
w.Greet("tim")
```

### Inheritance Vs. Composition Walthrough
- Polymorphism is a key piece of OOP design.
- It allows for objects of different types to be accessed through a common interface.
- Other languages might use inheritance to accomplish this.

#### Shapes Example
- If we take common shapes such as a Circle and a Rectangle, they share common behaviors.
- These behaviors are: area and string
- Area is how large is the object on a two dimensional plane, and String is how do we describe that shape in a humanized way.

```golang
type Circle struct {
	Radius float64
}

func (c Circle) Area() float64 {
	return math.Pi * c.Radius * c.Radius
}

// String method to each type, we have now satisfied the fmt.Stringer interface
func (c Circle) String() string {
	return fmt.Sprintf("Circle{Radius: %.2f}", c.Radius)
}

type Rectangle struct {
	Height float64
	Width  float64
}

func (r Rectangle) Area() float64 {
	return r.Height * r.Width
}

// String method to each type, we have now satisfied the fmt.Stringer interface
func (r Rectangle) String() string {
	return fmt.Sprintf("Rectangle{Height: %.2f, Width: %.2f}", r.Height, r.Width)
}

type Sizer interface {
	Area() float64
}

type Shaper interface {
	Sizer        // Area() float64
	fmt.Stringer // String() string
}

func main() {
	c := Circle{Radius: 15}
  fmt.Println(c)             // Circle{Radius: 15.00}
	fmt.Println(c.Area())      // 706.8583470577034
  fmt.Println(paint(c))      // you need 353.43 gallons of paint

  r := Rectangle{Height: 20, Width: 30}
  fmt.Println(r)             // Rectangle{Height: 20.00, Width: 30.00}
	fmt.Println(r.Area())      // 600
  fmt.Println(paint(r))      // you need 300.00 gallons of paint

  compare(c, r)
}

// calculate and print out how much paint we need for a given shape
// func paint(c Circle) string {
func paint(c Sizer) string {
	paint := .5 * c.Area()
	return fmt.Sprintf("you need %.2f gallons of paint", paint)
}

// We can now use the shaper interface as arguments to our compare function:
func compare(v1 Shaper, v2 Shaper) {
	if v1.Area() > v2.Area() {
		fmt.Println(v1.String(), "is the largest with an area of", v1.Area())
		return
	}
	fmt.Println(v2.String(), "is the largest with an area of", v2.Area())
}
```

#### The Empty Interface
- All the interfaces we've seen so far have declared one or more methods.
- If you declare an interface with zero methods, then every type will satisfy that interface. 
- In Go we use the empty interface to represent "anything".

```golang
// generic empty interface:
interface{}

// a named empty interface:
type foo interface{}
```

#### Using the Empty Interface

```golang
func main() {
	print(42)
	print("Ringo Rules")
	print(3.14159)
	// int: 42
	// string: Ringo Rules
	// float64: 3.14159
}

func print(i interface{}) {
	// %T - prints the type of the value
	// %v - prints the value in a default format
	fmt.Printf("%T: %v\n", i, i)
}
```

#### The Problem with Empty Interfaces
- interface{} says nothing. -- Rob Pike
- It is considered bad practice in Go to overuse the empty interface.
- You should always try to accept either a concrete type or a non-empty interface.
- While there are valid reasons to use an empty interface, the downsides should be considered first:
  - No type information
  - Runtime panics are very possible
  - Difficult code (to test, understand, document, etc...)

### Type Assertions
- Type assertions can be used to check, and possibly convert to another type or interface like this:
- type assertion returns an optional second boolean value that can be used to confirm whether the assertion was successful or not

```golang
// object.(type)

func print(s interface{}) {
	stringer, ok := s.(fmt.Stringer)
	if ok {
		fmt.Println(stringer.String())
		return
	}
	fmt.Println("not a stringer")
}

// This can be condensed into:
func printInline(s interface{}) {
	if stringer, ok := s.(fmt.Stringer); ok {
		fmt.Println(stringer.String())
		return
	}
	fmt.Println("not a stringer")
}
```

#### Watch out for Panics
- If you do not check the second, optional boolean value from the type check you risk your application panicking.
- NOTE: A panic can crash your entire application.

```golang
func main() {
	print(1)
}

func print(s interface{}) {
	st := s.(fmt.Stringer)
	fmt.Println(st.String())
}

// panic: interface conversion: int is not fmt.Stringer: missing method String
```

#### Switching Type
Using a switch statement and the type keyword, we can handle values differently depending on their type.

```golang
type Beatle struct {
	Name       string
	Instrument string
}

func (b Beatle) String() string {
	s, _ := json.Marshal(b)
	return string(s)
}

func main() {
	print(42)
	print("Ringo Rules")
	print(3.141592)
	print(Beatle{Name: "John", Instrument: "Guitar"})
	// INT: 42
	// Ringo Rules
	// FLOAT: 3.141592
}

func print(i interface{}) {
	switch t := i.(type) {
	case int:
		t = t + 3
		fmt.Printf("INT: %d\n", t)
	case float64:
		fmt.Printf("FLOAT: %f\n", t)
	case fmt.Stringer:
		fmt.Printf("%T\n", t)
		fmt.Println(t.String())
	default:
		fmt.Println(t)
	}
}

// You can optionally assign the result of the type assertion to a variable, which will become the asserted type:
// switch typedObject := anInterface.(type)
```

#### Avoiding Empty Interface
- While it can be tempting to just use an empty interface for your arguments, you are defeating the type safety that comes built in to the language.

#### Interface Zero Value
- Because interfaces aren't backed by any actual implementation the zero value of an interface is `nil`.
- While that code compiles, it will panic because the interface doesn't have an implementation backing it.

```golang
type Foo interface {
	Greet() string
}

func main() {
	var f Foo
	fmt.Println(f.Greet())
}

// panic: runtime error: invalid memory address or nil pointer dereference
// [signal SIGSEGV: segmentation violation code=0x1 addr=0x0 pc=0x108d663]
```

#### Backing Interfaces
- More commonly, you will be backing an interface with your concrete type.

```golang
// Given the following type definition:
type Stream struct {
	io.Writer
}

// You will need to back the interface with a concrete type to work:
s := Stream{
	Writer: os.Stdout,
}
fmt.Fprintf(s, "Hello Gophers!")

// However, sometimes in your code, you will forget to do this:
s := Stream{}
fmt.Fprintf(s, "Hello Gophers!")
// The code will compile, but result in a run-time panic
```

#### Pointer Receivers
- Methods defined on pointer receivers can only be accessed when using a pointer.
- However, methods defined on a value type can be access by both pointers and values.

```golang
type User struct {
	First string
	Last  string
}

func (u *User) String() string {
	return fmt.Sprintf("%s %s", u.First, u.Last)
}

func pretty(v fmt.Stringer) {
	fmt.Println(v.String())
}

func main() {
	u := User{First: "Rob", Last: "Pike"}
	pretty(u)
}

// cannot use u (type User) as type fmt.Stringer in argument to pretty:
//   User does not implement fmt.Stringer (String method has pointer receiver)
```

#### Value Receivers
Value receivers can satisfy both value and pointer methods.

```golang
type User struct {
	First string
	Last  string
}

func (u User) String() string {
	return fmt.Sprintf("%s %s", u.First, u.Last)
}

func pretty(v fmt.Stringer) {
	fmt.Println(v.String())
}

func main() {
	u := &User{First: "Rob", Last: "Pike"}
	pretty(u)
}
```

## Embedding And Composition
- Go does not provide the typical type-driven notion of subclassing. However, it does have the ability to “borrow” pieces of an implementation by embedding types within a struct or interface.
- Go does not have inheritance.
- It does, however, offer other tools that allow the assembling of multiple components into smaller, more manageable ones.

This is an example of composition. We are creating a new type, User, out of two other types, string and int.

```golang
// When discussing the struct type we saw that a struct contains n numbers of members, of various types.
type User struct {
	Name string
	Age  int
}
```

### Composing Complex Types
In Go, we are not limited to just using "primitive" types when composing a new type. We can use "complex" types as well.

```golang
type Admin struct {
	User        User
	Permissions map[string]bool
}

func main() {
	a := Admin{
		User: User{
			Name: "Homer",
			Age:  40,
		},
		Permissions: map[string]bool{},
	}

	fmt.Println(a.User.Name)
}
```

### Embedding
- In Go we can embed a type by just declaring its type, with no name.
- Notice that when creating a new value of type Admin we still had to specify the key User.

```golang
type Admin struct {
	User
	Permissions map[string]bool
}

func main() {
	a := Admin{
		User: User{
			Name: "Homer",
			Age:  40,
		},
		Permissions: map[string]bool{},
	}

	fmt.Println(a.Name)
}
```

#### Method Promotion
When we embed a type inside of another, the inner type's methods get promoted and can be accessed as if they were part of the outer type.

```golang
func (u User) Greet() {
	fmt.Printf("Hello, %s\n", u.Name)
}

func main() {
	a := Admin{
		User: User{
			Name: "Homer",
		},
	}

	a.Greet() // Hello, Homer
}
```

#### Method Collision
When there is a method collision (the inner type and the outer type both implement the same method) the outer type always wins.

```golang
func (u User) Greet() {
	fmt.Printf("Hello, %s\n", u.Name)
}

func (a Admin) Greet() {
	fmt.Printf("Admin: %s\n", a.Name)
}

func main() {
	a := Admin{
		User: User{
			Name: "Homer",
		},
	}

	a.Greet() // Admin: Homer
}
```

#### Ambiguous Methods
- If two inner types provide the same method, neither is promoted.
- neither method would get promoted, and you would receive the following error:


```golang
type User struct {
	Name string
}

func (u User) Greet() {
	fmt.Println("hello: ", u.Name)
}

type Guest struct{}

func (g Guest) Greet() {
	fmt.Println("hello guest")
}

type Admin struct {
	User
	Guest
}

func main() {
	a := Admin{
		User: User{Name: "Cory"},
	}
	a.Greet() // ./ambiguous/main.go:30:3: ambiguous selector a.Greet
}
```

#### Method Overriding
- When embedding another type we can override their methods with new methods
- while still being able to call the original method

```golang
func (u User) String() string {
	return u.Name
}

type Admin struct {
	User
	Permissions map[string]bool
}

func (a Admin) String() string {
	return fmt.Sprintf("Admin: %s", a.User.String())
}

main() {
	fmt.Println(a.String()) // Admin: Homer
}
```

#### Fixing Ambiguous Methods
To fix it, you would need to defined the Greet method on the Admin type as follows:

```golang
type User struct {
	Name string
}

func (u User) Greet() {
	fmt.Println("hello: ", u.Name)
}

type Guest struct{}

func (g Guest) Greet() {
	fmt.Println("hello guest")
}

type Admin struct {
	User
	Guest
}

func (a Admin) Greet() {
	if a.User.Name != "" {
		a.User.Greet()
		return
	}
	a.Guest.Greet()
}

func main() {
	a := Admin{
		User: User{Name: "Cory"},
	}
	a.Greet()
}
```

#### Overriding Via Type Conversion
- You can also do method overriding via Type Conversion.
- Type conversion happens when we assign the value of one data type to another

```golang
func main() {
	var i uint64 = 10
	var j int = 20

	// We must type convert i from a uint64 to an int in order to add i and j
	k := (int(i) + j)

	fmt.Println(k)
}
```

You can also create a type just for method overriding, and via type conversion change the behavior in your program:

```golang
type prettyString string

func (p prettyString) String() string {
	return fmt.Sprintf("I'm a pretty string: %q", string(p))
}

func main() {
	s := "Hi"
	fmt.Println(s) .               // Hi
	fmt.Println(prettyString(s))   // I'm a pretty string: "Hi"
}
```

Another more complex example with `authUser` to provide sensitivie information for only when a user is authenticated

```golang
package main

import (
	"fmt"
	"log"
	"net/http"
)

type User struct {
	ID    int
	First string
	Last  string
	Email string
}

func (u User) String() string {
	return fmt.Sprintf(`{"id":%d","first":"%s","last":"%s"}`, u.ID, u.First, u.Last)
}

type authUser User

func (u authUser) String() string {
	return fmt.Sprintf(`{"id":%d","first":"%s","last":"%s","email":"%s"}`, u.ID, u.First, u.Last, u.Email)
}

func handler(w http.ResponseWriter, r *http.Request) {
	u := User{
		ID:    1,
		First: "Cory",
		Last:  "LaNou",
		Email: "cory@gopherguides.com",
	}
	w.Header().Set("Content-Type", "application/text")

	data := u.String()

	username, password, ok := r.BasicAuth()
	if ok && username == "admin" && password == "password" {
		// Type convert user to an authUser to send all protected information to be serialized in the response.
		data = authUser(u).String()
	}

	w.Write([]byte(data))
}

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

/*
$ curl localhost:8080
{"id":1","first":"Cory","last":"LaNou"}

$ curl --user admin:password localhost:8080
{"id":1","first":"Cory","last":"LaNou","email":"cory@gopherguides.com"}
*/
```

#### Embedding Unexported Types
Even though a type is unexported, if you embed it promotion still occurs:

```golang
// user is unexported
type user struct {
	Name string
	Age  int
}

func (u user) Greet() {
	fmt.Printf("Hello, %s\n", u.Name)
}

type Admin struct {
	user        // embedding the unexported type
	Permissions map[string]bool
}

func DefaultAdmin() Admin {
	return Admin{
		user: user{
			Name: "Homer",
		},
	}
}

func main() {
	a := models.DefaultAdmin()
	a.Greet()           // Call the `Greet` method that was promoted from the unexported user type
	fmt.Println(a.Name) // All exported/promoted fields are also accessible.
	// a.user.Greet() // this will not compile as `user` is not an exported field
}
```

#### Embedding Pointers
You can also embed pointers within structs:

```golang
type Admin struct {
	*User
	Perms map[string]bool
}

// if that pointer is nil and you try to call a promoted method, you could open yourself up to panics:
func main() {
	a := &Admin{}
	// panic: runtime error: invalid memory address or nil pointer dereference
	fmt.Println(a.String())
}
```

#### Embedding != Interface
- Embedding User into Admin makes Admin appear to behave like User
- but it does not mean that an Admin can be used where the User type is requested.

```golang
func greetUser(u User) {
	fmt.Println(u.Name)
}

greetUser(a)
// admin-bad/main.go:25: cannot use a (type Admin) as type User in argument to greetUser
```
#### Embedding To Satisfy An Interface
Because of method promotion when embedding, the outer type can satisfy any interfaces that the inner type satisfies.

```golang
func (u User) Greet() {
	fmt.Printf("Hello, %s\n", u.Name)
}

type greeter interface {
	Greet()
}

func greet(g greeter) {
	g.Greet()
}

greet(admin)
```

#### Embedding Interfaces
- Embedding doesn't end with just concrete types
- we can also embedded interfaces, making some very powerful types.
- From the io package in the standard library creates a new interface, ReadWriter, by composing, and embedding, two other interfaces, Reader and Writer.

```golang
type ReadWriter interface {
  Reader
  Writer
}
```

#### Embedding Interfaces Within Structs
- Interface types can also be embedded into structs as well, and similarly promote their methods onto the struct type.
- This can be useful for slightly modifying the behavior of an interface or adding methods to a smaller interface to satisfy a wider one.
- In tests, you'll typically have a reader built from strings.NewReader: `r := strings.NewReader("foo")`

```golang
type ReadCloser interface {
  Reader
  Closer
}
```

##### Adding A Close Method
- By embedding the `io.Reader` interface, we can decorate it with a `Close()` method that does nothing:
- In fact, this is the definition of `ioutil.NopCloser`, which is more common to use in practice than implementing it yourself as we've done here.

```golang
type Closer struct {
	io.Reader
}

func (c Closer) Close() error {
	return nil
}
```

```golang
func main() {
	c := Closer{
		Reader: strings.NewReader("Hello, World!"),
	}
	if err := read(c); err != nil {
		fmt.Println(err)
	}

}

func read(r io.ReadCloser) error {
	if _, err := io.Copy(os.Stdout, r); err != nil {
		return err
	}
	return r.Close()
}
```

or 

```golang
func main() {

	r := strings.NewReader("Hello, World!")

	if err := read(ioutil.NopCloser(r)); err != nil {
		fmt.Println(err)
	}
}

func read(r io.ReadCloser) error {
	if _, err := io.Copy(os.Stdout, r); err != nil {
		return err
	}
	return r.Close()
}
```

#### Overriding Type For Interface
- You can also use type assertion to override a method that satisfies an interface.
- This is often done to change the behavior of that interface.

```golang
type User struct {
	ID    int    `json:"id"`
	First string `json:"first,omitempty"`
	Last  string `json:"last,omitempty"`
	Email string `json:"-"`
}

type authUser User

func (a authUser) MarshalJSON() ([]byte, error) {
	// declare a private type to write our data to
	type usr struct {
		ID    int    `json:"id"`
		First string `json:"first,omitempty"`
		Last  string `json:"last,omitempty"`
		Email string `json:"email,omitempty"`
	}

	// Populate our new instance with just the data we need
	us := usr{
		ID:    a.ID,
		First: a.First,
		Last:  a.Last,
		Email: a.Email,
	}

	return json.Marshal(us)
}

func handler(w http.ResponseWriter, r *http.Request) {
	u := User{
		ID:    1,
		First: "Cory",
		Last:  "LaNou",
		Email: "cory@gopherguides.com",
	}
	w.Header().Set("Content-Type", "application/json")

	username, password, ok := r.BasicAuth()
	if ok && username == "admin" && password == "password" {
		// Type convert user to an authUser to send all protected information to be serialized in the response.
		json.NewEncoder(w).Encode(authUser(u))
		return
	}

	json.NewEncoder(w).Encode(u)
}
```

### Embedding Vs. Fields
- There should be a design decision when composing structures in regards to using embedding vs. field.
- Embedding
  - Promotes all fields and methods to newly composed type
  - New type can automatically satisfy any interface the embedded type satisfies
  - Requires method overriding to protect any methods you wish to guard (if any)
	- A common example of embedding is with the use if the io interfaces, such as io.Reader, io.Writer, etc.
- Field
  - No promotion of any fields or methods
  - Type can be protected by not exporting it
  - Can create your own methods and call underlying types fields or methods as needed
	- A common example of using a field to compose is the use of sync.Mutex.
	- This allows for the new type to have a built in locking mechanism without exposing it outside the new type.


## Errors
- In Go there is no `try/catch` paradigm.
- Errors are return values that need to be handled like any other value returned from a function call.
- If the err is nil, then you know the call succeeded, otherwise something went wrong.

```golang
_, err := os.Open("/path/to/some/content.file")
if err != nil {
	// open /path/to/some/content.file: no such file or directory
	log.Fatal(err)
}
```

### Gracefully Handle Errors
Because errors are values, we can handle them gracefully in our programs.

```golang
type config struct {
	Backup bool `json:"backup"`
	Debug  bool `json:"debug"`
}

var f io.Reader
var err error

// try to read a file
f, err = os.Open("./config.json")
if err != nil {
	// Fall back to a default config. Stream it as a reader.
	f = strings.NewReader(`{"backup":false,"debug":true}`)
}

c := config{}

if err := json.NewDecoder(f).Decode(&c); err != nil {
	log.Fatal(err)
}

fmt.Printf("%+v\n", c)  // {Backup:false Debug:true}
```

### Creating Errors
There are two "built-in" ways to create errors in the standard libary.

```golang
// in the `errors` package
errors.New("a message")

// in the `fmt` package
fmt.Errorf("a %s message", "formatted")
```

### Returning Errors
Errors are returned from functions just like any other type.

```golang
func boom() error {
	return errors.New("boom!")
}

func greetOrBoom() (string, error) {
	return "hello", errors.New("boom!")
}
```

### Sentinel Errors
- Sentinel errors use a specific value to signify that no further processing is possible.
- Examples in the standard library include `io.EOF` and `sql.ErrNoRows`.
- Errors we expect to get
- `io.EOF` indicates that you have reached the end of a file, which isn't really an error; we expect it to happen when we want to read the entire file.

```golang
// EOF is returned when the end of the file has been reached
var EOF = errors.New("EOF")
```

```golang
i, err := f.Read(buff)
if err != nil {
	// Check for the sentinel error of `io.EOF`
	if err == io.EOF {
		return
	}
	log.Fatal(err)
}
```

### Custom Sentinel Errors
You can also create your own sentinel errors.

```golang
var errConfigNotFound = errors.New("config not found")

func main() {
	c, err := openConfig("./config.json")
	if err != nil {
		if err == errConfigNotFound {
			fmt.Println("using default config")
			// ... load default config, etc.
			return
		}
		log.Fatal(err)
	}
	fmt.Printf("%+v\n", c)
}

type config struct {
	Backup bool `json:"backup"`
	Debug  bool `json:"debug"`
}

func openConfig(path string) (*config, error) {
	f, err := os.Open(path)
	if err != nil {
		// Return our own sentinel error
		return nil, errConfigNotFound
	}

	c := config{}

	if err := json.NewDecoder(f).Decode(&c); err != nil {
		return nil, err
	}
	return &c, nil
}
```

### Errors Are Interfaces
- Errors in Go are defined as an interface in the standard library.
- Anything that defines this method can now satisfy that interface, and as such, be an error.

```golang
type error interface {
	Error() string
}
```

### Defining Your Error
- You can create even a simple custom error as long as you satisfy the error interface:

```golang
type strError string

func (s strError) Error() string {
	return string(s)
}

func main() {
	err := boom()
	if err != nil {
		log.Fatal(err)  // 2020/04/18 13:55:40 something went wrong, exit status 1
	}
}

func boom() error {
	return strError("something went wrong")
}
```

### Complex Custom Error

```golang
type ComplexError struct {
	File   string
	Server string
}

func (c ComplexError) Error() string {
	return fmt.Sprintf("%s: %s", c.File, c.Server)
}

func boom() error {
	return ComplexError{
		File:   "main.go",
		Server: "myhost",
	}
}
```

### Using Type Assertion On Errors
Using type assertion, you can get access to the concrete type and therefore access the fields and methods of the concrete type.

```golang
func main() {
	err := boom()
	if err != nil {
		log.Println(err)
	}
	// assert on the error type
	if ce, ok := err.(ComplexError); ok {
		log.Println(ce.Server)
	}
}
```

### Constant Sentinel Errors
- Constants in Go are fungible.
- "Go's constants are powerful. If you only think of them as immutable numbers, you are missing out." - Dave Cheney
- If you create sentinel errors, it may be desirable to declare them as a constant.
- This also prevents another package from changing the value of your variable at runtime.

```golang
// Given a simple example of two constants of the same value, they will be equal
const str1 = "EOF"
const str2 = "EOF"
fmt.Printf("str1 == str2: %v\n", str1 == str2) // true

// We can create a type that satisfies the error interface by defining the Error method
type Error string

func (e Error) Error() string {
	return string(e)
}

// And we can see that if the underlying value is the same, these new errors are also equal
const err1 = Error("EOF")
const err2 = Error("EOF")

fmt.Printf("err1 == err2: %v\n", err1 == err2) // true

// However, two errors as variables with the same underlying value are NOT equal
var err3 = errors.New("EOF")
var err4 = errors.New("EOF")

fmt.Printf("err3 == err4: %v\n", err3 == err4) // false
```

### Avoid Sentinel Errors
- Despite a few use cases in the standard library, it is generally considered to be "bad practice" to use sentinel errors.
  - Sentinel errors become part of your public API
  - Sentinel errors create a dependency between two packages
- An emerging approach to creating an API with errors is not to define sentinel errors, but to provide a function from your package that will determine if you have that specific error. 
- A great example of this is the os.IsExist method in the standard library. 
- This will allow you better control over how this API is used vs. declaring a sentinel error.

```golang
func IsExist(err error) bool
```

### Wrapping Errors
- It is very common when writing code to wrap your error with more context.
- You can wrap them with the %w verb when using the fmt.Errorf function.
- This will allow for the use of several helpers later which we will cover.

```golang
func openConfig(path string) (*config, error) {
	f, err := os.Open(path)
	if err != nil {
		// Wrap the error in our own message for the future
		return nil, fmt.Errorf("couldn't open config file: %w", err)
	}

	c := config{}

	if err := json.NewDecoder(f).Decode(&c); err != nil {
		return nil, err
	}
	return &c, nil
}

// 2020/04/18 13:00:39 couldn't open config file: open ./config.json: no such file or directory
```

### When To Wrap?
- When returning errors, you need to decide if you want to wrap them or not.
- While normally you do, there may be scenarios that you do not.
  - Wrap errors when you want to expose it to callers
  - Don't wrap when doing so may expose implementation details

### Unwrapping Errors
- There are several ways as of Go 1.13 to unwrap an error to check for a specific error.
  - errors.As
	- errors.Is
	- errors.Unwrap

#### Errors.Id
You can use errors.Is to check for a sentinel error.

```golang
func openConfig(path string) (*config, error) {
	var f io.Reader
	var err error
	f, err = os.Open(path)
	if err != nil {
		if errors.Is(err, os.ErrNotExist) {
			// use default config
			f = bytes.NewBufferString(`{"backup":false,"debug":true}`)
		} else {
			return nil, fmt.Errorf("something went terribly wrong...: %w", err)
		}
	}

	c := config{}

	if err := json.NewDecoder(f).Decode(&c); err != nil {
		return nil, err
	}
	return &c, nil
}
```

#### Errors.As
With the release of Go 1.13, you should no longer type assert, but use the built in errors.As function:

```golang
func main() {
	err := boom()
	if err != nil {
		log.Println("error: ", err)
	}
	var ce ComplexError
	if errors.As(err, &ce) {
		log.Println("server:", ce.Server)
	}
}
```

#### Stacked Errors
Even if there are several errors stacked in a set of wrapped errors:

```golang
func boom() error {
	ce := ComplexError{
		File:   "main.go",
		Server: "myhost",
	}
	err := fmt.Errorf("original error: %w", ce)
	err = fmt.Errorf("wrap again: %w", err)
	return err
}

// The errors.As will traverse the stack until it finds the first instance of the error that satisfies the interface:

func main() {
	err := boom()
	if err != nil {
		log.Println("error: ", err)
	}
	var ce ComplexError
	if errors.As(err, &ce) {
		log.Println("server:", ce.Server)
	}
}

// 2020/04/18 12:47:25 error:  wrap again: original error: main.go: myhost
// 2020/04/18 12:47:25 server: myhost
```

#### Declaring Custom Unwrap Behavior
You can also implement Unwrap in your own errors as well.

```golang
type ComplexError struct {
	File   string
	Server string
	err    error
}

func (c ComplexError) Error() string {
	return fmt.Sprintf("%s: %s - %s", c.File, c.Server, c.err)
}

func (c ComplexError) Unwrap() error {
	return c.err
}

func boom() error {
	return ComplexError{
		File:   "main.go",
		Server: "myhost",
		err:    io.EOF,
	}
}

func main() {
	err := boom()
	if e := errors.Unwrap(err); err != nil {
		fmt.Printf("original error was: %s", e)   // original error was: EOF
	}
}
```

#### Errors.Unwrap
- Any time you wrap an error by using the %w verb in fmt.Errorf you are able to Unwrap it later.
- You can unwrap until you get to nil which means you are likely at the beginning of where the errors started.

```golang
type ComplexError struct {
	File   string
	Server string
}

func (c ComplexError) Error() string {
	return fmt.Sprintf("%s: %s", c.File, c.Server)
}

func boom() error {
	ce := ComplexError{
		File:   "main.go",
		Server: "myhost",
	}
	err := fmt.Errorf("original error: %w", ce)
	err = fmt.Errorf("wrap again: %w", err)
	return err
}

func main() {
	err := boom()

	// Unwrap and print all errors
	for {
		if err == nil {
			return
		}
		fmt.Println(err)
		err = errors.Unwrap(err)
	}
}

// wrap again: original error: main.go: myhost
// original error: main.go: myhost
// main.go: myhost
```

#### Unwrapping Multiple Errors
Because errors.Is and errors.As will walk the stack of errors, it is safe to use either of those functions on the same error:

```golang
var errUnknown = errors.New("unknown error")

type ComplexError struct {
	File   string
	Server string
	err    error
}

func (c ComplexError) Error() string {
	return fmt.Sprintf("%s: %s", c.File, c.Server)
}

func (c ComplexError) Unwrap() error {
	return c.err
}

func main() {
	err := boom()

	if errors.Is(err, errUnknown) {
		fmt.Println("found simple error")
	}

	var ce ComplexError
	if errors.As(err, &ce) {
		fmt.Println("found complex error")
	}
}

func boom() error {
	ce := ComplexError{
		File:   "README.md",
		Server: "localhost:9090",
		err:    errUnknown,
	}
	return fmt.Errorf("wrapping a complex error: %w", ce)
}

// found simple error
// found complex error
```

#### Nil Typed Errors
- Be wary of comparing nil `types`.
- Even though you return `nil` from a function, if it has a `type`, it will not be nil in the same way that an `error` is nil.
- The reason for this is that Go stores the information of an interface as both the `type` and the `value`.
- An interface value is only truly `nil` if both the type and the `value` are not set.
- In this case, the interface is `{Type: *errFound, Value: nil}` and not `{Type: nil, Value: nil}`

```golang
type errFound string

func (e *errFound) Error() string {
	return "found"
}

func main() {
	err := exists("README.md")
	if err != nil {
		fmt.Println("error was NOT nil")
		var ef *errFound
		if errors.As(err, &ef) {
			fmt.Println("this was a errFound...")
		}
	}
}

func exists(path string) error {
	if path == "README.md" {
		// return a `typed` nil value...
		var e *errFound
		if e == nil {
			fmt.Println("yup, it's nil here..")
		}
		return e
	}
	return nil
}

// yup, it's nil here..
// error was NOT nil
// this was a errFound...
```

### Panics
- Occasionally in your code you will do something that the Go runtime does not like.

```golang
a := []string{}
a[42] = "Bring a towel"

// panic: runtime error: index out of range
// goroutine 1 [running]:
// main.main()
// 	panic.go:5 +0x11
```

#### Recover From A Panic
- With a combination of the defer keyword and the the recover function we can recover from panics in our applications and gracefully handle them.
- In general, it is good practice not to panic.
- It is better to return an error and let others figure out how to handle it in their applications.

```golang
func main() {
	defer func() {
		if err := recover(); err != nil {
			fmt.Println("oh no, a panic occurred:", err)
		}
	}()
	a := []string{}
	a[42] = "Bring a towel"
}
```

### Stack Traces
- There may be times that you want to output a stack trace to a log, file, etc.
- You can do this by using the runtime/debug package.

```golang
package main

import "runtime/debug"

func main() {
	First("Hello")
}

func First(s string) {
	Second(s)
}

func Second(s string) {
	Third(s)
}

func Third(s string) {
	debug.PrintStack()
}
```

## Packages
- Package management is essential in creating repeatable builds in your software.
- Go code is organized in packages.
- A package represents all the files in a single directory on disk.
- One directory can contain only files from the same package.
- Go does not allow circular package imports

### Package Names
- While a package can only have one name,
- it is not required that the name be the same as the folder it is in
- it is strongly encouraged to match the folder
- For example, code in folder "foobar" should declare `package foobar`
- Source files in a package must declare the package name at the top of the file as the first code statement
- All source files (.go) must declare the package name at the top of the file. No exceptions!

```golang
package foobar

// code goes here
```

### Executable Packages
- Executable programs must have a `main` package that declares a `main()` function
- The main function can only be declared once and receives no arguments, nor does it return any values.

```golang
package main

func main() {
	// do work here
}
```

### $GOPATH Package Resolution
- Package resolution is only of concern when working with the $GOPATH.
- The reason for this is that Modules store read-only versions of modules for a package in a cache.
- The location of the cache, as of 1.13 is $GOPATH/pkg/mod
- Packages that live in source code repositories, like GitHub and BitBucket, have the full location of the repository as part of their import path.
- For example, the source code at https://github.com/gobuffalo/buffalo would be imported using the following import path:

```golang
// The source code would be in the following location on disk:
// $GOPATH/src/github.com/gobuffalo/buffalo
import "github.com/gobuffalo/buffalo"
```

### Scope And Visibility
- External visibility is controlled by capitalization.
  - Types, Variables, Functions, etc that start with a capital letter are available, publicly, outside the current package.
	- A symbol that is visible outside its package is "exported".
- Types, Variables, Functions, etc that start with a lower case letter are unexported and are not available outside of the current package.
- All variables and types declared inside a package are visible to everything else in the same package.

- While it is possible to return a non-exported type from an exported function, it is considered bad practice.

```golang
// "legal", but not encouraged
func BadPacker() *pack {
	return &pack{}
}

// Consider returning a publicly exported type or an interface instead:
type Packer interface {
	Add(string)
	Packed() string
}

func GoodPacker() Packer {
	return &pack{}
}
```


```golang
// visible outside of the package:
func Foo() {}

// available only inside the package:
var bar string
```

### Security
- It is important to understand that although you can't directly access or change unexported fields in a struct, you can still get access to view the contents of them.
- This is because the fmt package makes use of the reflect package.

### File Names
- Inside packages there are no requirements as to what the names of the files inside that package are to be named.
- common practice to name the "entry point" file after the name of the package

#### Package Organization
- Projects require additional planning when grouping code into packages to ensure that dependencies do not import each other
- [Hexagonal Architecture in Go](https://github.com/katzien/go-structure-examples)
- [Standard Package Layout)(https://medium.com/@benbjohnson/standard-package-layout-7cdbc8391fc1)

#### Sample Package Layout

```
├── cachely
│   ├── app.go
│   ├── app.pb.go
│   └── app.proto
└── cmd
    ├── client
    │   └── main.go
    └── server
        └── main.go
```

## Modules
- Modules are the dependency management system for Go Apps.
- A module is a collection of related Go packages that are versioned together as a single unit.
- A repository contains one or more Modules.
- Each module contains one or more Go packages.
- Each package consists of one or more Go source files in a single directory.

### Module Fundamentals
- as of go 1.13, modules are on by default
- go mod init
- go get 
- go mod tidy

### Init
- To enable modules for your project, you need to initialize your project. You can do this with the go mod init command.
- Any go mod init command will create a file called go.mod.
- This file will keep track of all the modules you import in your application.

```bash
# From the root of your project, run the following command
go mod init YourModuleName

# If you were hosting your project on github.com, we could give it the full canonical address instead:
go mod init github.com/gopherguides/gophers
```

### Adding Modules
To add a new module, you can still use go get as you have before modules existed.

```bash
go get github.com/kr/pretty

# To add a dependency at a specific version, you can specify a branch or a tag like so:
go get github.com/kr/pretty@v0.2.0
```

### Deleting Modules
- To delete a module, you can run go get with @none at the end of the import:

```golang
go get github.com/kr/pretty@none
```

### go.mod
- Your app name (called module in the file)
- The version of Go you’re using
- The list of modules that you import (the Go tool might put other // indirect ones in there too)
- This file SHOULD be checked in.

```golang
module training     // defines the name of the module to be training

go 1.12            // is the minimum version of Go required to build this application.

// tells Modules that the github.com/gobuffalo/here package, version v0.1.2, is required by this application.
require github.com/gobuffalo/here v0.1.2
```

### go.sum
- A list of all the modules your app uses, including the transitive ones
- dependency’s dependency, their dependency
- Every module’s checksum
- This file SHOULD be checked in.

```
github.com/gobuffalo/here v0.1.2 h1:tEHMKtSLsXfmx4+KmRpkV+Yj4mzldBVUmHdQqr/nJbU=
github.com/gobuffalo/here v0.1.2/go.mod h1:2a6G14FaAKOGJMK/5UNa4Og/+iyFS5cq3MnlvFR7YDk=
```

### Global Cache
- Go stores all the module code in a read-only central directory on your disk,
- so one version of a module isn’t tied to just your project.

```bash
go clean --modcache
```

### Tidying Up
- will retrieve whatever the latest version of a module is.
- will remove any unused modules your project is no longer referencing
- To clean up your dependencies, you can run

```bash
go mod tidy
```

### New Go Get Behavior

```bash
# Download any/all package dependencies defined in go.mod and go.sum:
go get

# Update all package dependencies to their latest versions:
go get -u

# In Go 1.13 this will no longer update all dependencies, but rather just those directly used by the project.
# To update all package dependencies to their latest versions in Go 1.13:
go get -u all

# Get the latest version of the package and adds it to go.mod:
go get github.com/gobuffalo/buffalo

# Update the version of the package in go.mod to the latest version:
go get -u github.com/gobuffalo/buffalo

# Get the latest commit of a VCS branch of the package and adds it to go.mod:
go get github.com/gobuffalo/buffalo@development

# Get the VCS tag of the package and adds it to go.mod:
go get github.com/gobuffalo/buffalo@v0.14.6
```

### Why This Package?
- The go mod why command will tell us which Modules require the specified package.
- This output tells us that our module, training/v2, requires it as does the github.com/gobuffalo/here module.

```bash
go mod why github.com/gobuffalo/here

# github.com/gobuffalo/here
training/v2
github.com/gobuffalo/here
```

### Using the Graph
- To find more detailed information about dependencies, as well as their dependencies,
- the go mod graph command, along with a liberal use of grep, can help navigate the details.

```bash
go mod graph | grep logrus

training/v2 github.com/sirupsen/logrus@v1.4.2
github.com/sirupsen/logrus@v1.4.2 github.com/davecgh/go-spew@v1.1.1
github.com/sirupsen/logrus@v1.4.2 github.com/konsorten/go-windows-terminal-sequences@v1.0.1
github.com/sirupsen/logrus@v1.4.2 github.com/pmezard/go-difflib@v1.0.0
github.com/sirupsen/logrus@v1.4.2 github.com/stretchr/objx@v0.1.1
github.com/sirupsen/logrus@v1.4.2 github.com/stretchr/testify@v1.2.2
github.com/sirupsen/logrus@v1.4.2 golang.org/x/sys@v0.0.0-20190422165155-953cdadca894
....
```

### Listing The Dependencies
- The go list command has several flags that allow you to see exactly which packages,
- and which versions of those packages, are being using by Go to build your application.

```shell
go list -m all

training/v2
github.com/davecgh/go-spew v1.1.1
github.com/gobuffalo/here v0.1.2
github.com/konsorten/go-windows-terminal-sequences v1.0.1
github.com/pmezard/go-difflib v1.0.0
github.com/sirupsen/logrus v1.4.2
github.com/stretchr/objx v0.1.1
github.com/stretchr/testify v1.2.2
golang.org/x/sys v0.0.0-20190422165155-953cdadca894
```

### Developing Locally
- Often during development it is necessary to work with a local copy of a package.
- When using the $GOPATH this was easy, as all of the packages were laid out logically.
- With Modules the problem is a bit more difficult.
- To help with this problem go.mod files support a replace directive.
- This will replace the import github.com/gobuffalo/helpers with the relative path specified.
- This replacement, however, only applies to this module and does not allow for replacement of other Modules dependencies.
- It is important to remember to remove any replace directives before checking in your code, as it's likely to break your ci process as those local files won't be available from your checked in repo.

```
replace github.com/gobuffalo/helpers => ../../../gobuffalo/helpers
```
