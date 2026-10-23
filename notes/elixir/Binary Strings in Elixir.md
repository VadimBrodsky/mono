---
title: "Binary Strings in Elixir"
tags: ["elixir"]
created: "20220316001409045"
modified: "20220324013646895"
---

It is the most common way to specify a [[./Strings in Elixir|string]] in Elixir, with the double-quotes syntax. It is implemented using a binary, a consecutive sequence of bytes. 

```elixir
"This is a string"
"Embedded expression: #{3 + 0.14}"  # "Embedded expression: 3.14

"\r \n \" \\"

"
This is
a multiline string
"
```

Many [functions are available](https://hexdocs.pm/elixir/String.html) for help working with binary strings.

## Sigils

Sigils are an alternative way to define a string, using the `~s()` syntax:

```elixir
~s(This is also a string)
~s("Do... or not do. There is no try." - Master Yoda)
```

The uppercase version of `~S()` does not handle interpolation or escape characters:

```elixir
~S(Not interpolated #{3 + 0.14})
~S(Not escaped \n)
```


## Heredocs

Heredocs support better formatting for multiline strings:

```elixir
"""
Heredoc must end on its own line """
"""
```

## String Concatenation

Because strings are [[./Binaries and Bitstrings in Elixir|binaries]], they can be concatenated with the `<>` operator

```elixir
"String" <> " " <> "concatenation"
```
