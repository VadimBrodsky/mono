## Core Language

### Strings
```elm
"hello"                         -- "hello" : String
"hello" ++ "world"              -- "helloworld" : String
"hello " ++ "world"             -- "hello world" : String
```

### Numbers

```elm
2 + 3 * 4                       -- 14 : number
(2 + 3) * 4                     -- 20 : number
9 / 2                           -- 4.5 : Float
9 // 2                          -- 4 : Int
```

### Functions

```elm
isNegative n = n < 0                  -- <function: number -Bool
isNegative 4                          -- False : Bool
isNegative -7                         --  True : Bool
isNegative (-3 * -4)                  --  False : Bool
\n -n < 0                             --  <function: number -Bool
(\n -n < 0) 4                         --  False : Bool
if True then "hello" else "world"     --  "hello" : String
if False then "hello" else "world"    -- "world" : String

over9000 powerLevel = \
|   if powerLevel 9000 then "It's over 9000!!!" else "meh"
-- <function: number -String

over9000 42                           -- "meh" : String
over9000 10000                        --  "It's over 9000!!!" : String
```

### Lists

```elm
names = [ "Alice", "Jonathan", "Vadim" ]   -- ["Alice","Jonathan","Vadim"] : List String
List.isEmpty names                         -- False : Bool
List.length names                          -- 3 : Int
List.reverse names                         --  ["Vadim","Jonathan","Alice"] : List String

numbers = [ 1,2,3,4]                       -- [1,2,3,4] : List number
double n = n * 2                           -- <function: number -number
List.map double numbers                    -- [2,4,6,8] : List number


```

### Conditionals

```elm
import String
goodName name = \
   if String.length name <= 20 then \
     (True, "name accepted!") \
   else \
     (False, "name was too long; please limit it to 20 characters")
-- <function: String.String -( Bool, String.String )

goodName "Alice"                --  (True,"name accepted!") : ( Bool, String.String )
```

### Records

```elm
point = { x = 3, y = 4 }            -- { x = 3, y = 4 } : { x : number, y : number1 }
point.x                             -- 3 : number

bill = { name = "Gates", age = 62 }   -- { age = 62, name = "Gates" } : { age : number, name : String.String }
bill.name                             -- "Gates" : String.String
.name bill                            -- "Gates" : String.String
.age bill                             -- 62 : number
List.map .name [bill,bill,bill]       -- ["Gates","Gates","Gates"] : List String.String

under70 {age} = age < 70                             -- <function: { a | age : number } -Bool
under70 bill                                         -- True : Bool
under70 { species = "Triceratops", age = 68000000 }  -- False : Bool

{ bill | name = "Nye" }              -- { age = 62, name = "Nye" } : { age : number, name : String.String }
{ bill | age = 22 }                  -- { age = 22, name = "Gates" } : { age : number, name : String.String }
bill                                 -- { age = 62, name = "Gates" } : { age : number, name : String.String `
```

### Let Expression

```elm
pluralize singular plural quantity =
  let
    quantityStr = String.fromInt quantity
    prefix = quantityStr ++ " "
  in
  if quantity == 1 then
    preifx ++ singular
  else
    prefix ++ plural
```
