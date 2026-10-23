---
title: "string data type in Lua"
created: "20221213191144903"
modified: "20221213192646300"
---

A string is an array of characters.

## String Literals

A string literal must be written between `"double quotation marks"` or `'single quotation marks'`.

```lua
print("Print a string literal, used in place")
message = "Print a string assigned to a variable"
print(message)
```

## String Length

There are 2 ways to get the length of a string:

1. The `string.len()` function
2. The `#` symbol in front of the string

```lua
hello = "hello, world"
count_hash = #hello;
count_func = string.len(hello)
```

## Concatenate Strings

Two strings can be concatenated by using the `..` operator. The concatenation results in a new string. Any combination of variables and literals can be concatenated.

```lua
name = "John"
colour = "Blue"
print(name .. " likes " .. colour)
```

## String Coercion

Strings can be coerced into other data types

```lua
pi = 3.14
message = "The rounded value of pi is: " .. pi
print(message)

eleven = "10" + 1
print(eleven)
```

## Escape Characters

To escape characters in string literals use the `\` in front of it.

```lua
message = "he said \"bye\" and left"
print(message)
```

Additional Escape Characters
- `\n` newline, moved the cursor down one line
- `\t` horizontal tab, tabs over on the current line
- `\\` backslash, when you have to escape the escape symbol
- `\"` double quote, needed to include a quote in a string

Full list if [escape characters in Lua](https://www.lua.org/pil/2.4.html).
