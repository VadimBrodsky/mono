[[Elm]]'s most basic collections are lists, records and tuples. Elm's collections are always [[immutable]].

## Lists
Lists let us represent collections of varying sizes, whose elements share a consistent type. 

Elm lists are similar to JavaScript arrays:
- You can create one with a square bracket literal.
- You can ask for its first element.
- You can ask for its length.
- You can iterate over its elements in various ways.

Elm lists are different than JavaScript:
- It is immutable.
- It has no fields or methods. You work with it by using functions from the `List` module.
- Because it is a [[linked list]], you can ask for its first element, but not for other individual elements.
	- To ask for an element at a specific position, first convert an Elm `List` to an Elm `Array`.
- All elements in an Elm list must have a consistent type.

Elm supports both [[immutable]] lists and [[immutable]] arrays, Elm lists are much more commonly used in practice.
```elm
l = ["one fish", "two fish"] -- ["one fish","two fish"] : List String
List.length[1, 2, 3]         -- 3 : Int
List.head l                  -- Just ("one fish") : Maybe String
[1,2] ++ [3,4]               -- [1,2,3,4] : List number

List.filter Char.isDigit ['7', '-', '9']        -- ['7','9'] : List Char
List.filter (\num -> num > 0) [-2, -1, 0, 1, 2] -- [1,2] : List number
```
Requiring consistent element types means all lists in Elm guarantee a level of predictability.

## Records
Records let us represent collections of fixed fields, but the values may have varied types.

JavaScript mutable objects resemble [[Elm]]'s [[immutable]] records. A record is a collection of named fields, each with an associated value.

- [[Elm]] record literals use `=` to assign values.
- Field names can't start with uppercase letters.
- Fields can be accessed only directly, using the dot notation.
- Fields cannot be modified
- No prepackaged fields, only the ones you define..
- No listing of field names is available on demand, no `Object.keys`
- Records have no concept of inheritance, no `Object.prototype`

```elm
{ name = "Li", cats = 2}    -- { cats = 2, name = "Li" }
                              -- : { cats : number, name : String }
   
({name = "Li", cats = 2}).cats    -- 2 : number
```

### Record Updates
They let us obtain a new record by copying the old one and changing only the specified values. [[Elm]] will reuse values from existing records to save time and memory.

- To update a record use the `|` operator.
- The original record is never modified.

```elm
catLover = { name = "Li", cats = 2}
catLover -- { cats = 2, name = "Li" } : { cats : number, name : String }

withThirdCat = { catLover | cats = 3 }
withThirdCar -- { cats = 3, name = "Li" } : { cats : number, name : String }

{ catLover | cats = 88, name = "LORD OF CATS" }
```

### Tuples
A tuple is a record-like value whose fields are accessed by position rather than by name.
- [[Elm]] does not support tuples of more than 3 elements. For those situation use a record instead.
- When you need only 2 or 3 elements, choose tuples or records based on which would yield more readable code. Their performance characteristics are equivalent.

Tuples introduce no new capabilities, as there is nothing a tuple can do that a record can't. But compared to records tuples bring conciseness. Tuples are good for when you want a record but don't want to bother naming the fields.

They often used for key-value pairs, where adding the key names would add verbosity but no clarity.

```elm
( "Tech", 9 )              -- ("Tech",9) : ( String, number )
Tuple.first ( "Tech", 9 )  -- "Tech" : String
Tuple.second ( "Tech", 9)  -- 9 : number
```
You can use `Tuple.first` and `Tuple.second` functions only on tuples that contain two elements. If they have 3 elements use tuple destructuring to extract their values.

#### Tuple Destructuring
Tuple destructuring extract the values inside a tuple and assigns them to names in the current scope.

A simple mnemonic to remember the difference between a function call and a tuple is the `,` comma means tuple.

```elm
multiple3d ( x, y, z ) = x * y * z   -- <function> : ( number, number, number ) -> number
multiple3d (6, 7, 2)                 -- 84 : number

multiple3d someTuple = let ( x, y ) = someTuple in x * y -- <function> : ( number, number ) -> number
```
Once you have named the values inside the tuple, you can use them just as you would any other named value.

### Comparing lists, records and tuples
- List
	- Can add or remove elements at runtime
	- Can iterate over
	- No names
	- Immutable
- Record
	- Cannot add or remove fields at runtime
	- Cannot iterate over
	- Named fields
	- Immutable
- Tuple
	- Cannot add or remove fields at runtime
	- Cannot iterate over
	- No names
	- Immutable