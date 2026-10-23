---
title: "Literals in Go"
tags: ["golang"]
created: "20230123234257678"
modified: "20230129230816801"
---

A _literal_ in Go refers to writing out a number, character or string:

- Integer literals - sequences of numbers, normally in base ten.
- Floating point literals - have decimal points to indicate the fractional portion of the value, they can also have exponent specified with the letter `e`.
- Rune literals - characters surrounded by single quotes.
- String literals - uses double quotes to create an interpreted string that contains zero or more rune literals.
- Raw string literals - allow to include backslashes, double quotes or newlines. Delimited with (`), and contain any literal character except backquote.

Literals are untyped in Go. For example, Go allows to use an integer literal in a floating point expression. They can interact with any variable that's compatible with the literal.

There are size limitations, while you can write a numeric literals that are larger than any integer can hold, it is a compile time error to try to assign a literal whose value overflows the specific variable. For example; assigning the literal 1000 to a variable of type `byte`.


```golang
integer := 123
long_interger := 1_123
binary_integer := 0b1
octal_integer := 0o6
hexal_integer := 0x8

float := 3.14
long_float := 1_234.45
float_expo := 6.03e23
hexal_float := 0x2p22

rune_char := 'a'
rune_8_octal := '\141'
rune_8_hexal := '\x61'
rune_16_hexal := '\u0061'
rune_32_unicode := '\U00000061'
rune_newline := '\n'
rune_tab := '\t'
rune_quote := '\''
rune_backslash := '\\'

string_literal := "Greetings and Salutations"
string_escape := "Greetings and\n\"Salutations\""
raw_string := `Greetings and
"Salutations"`
```
