---
title: "Functions in Elixir"
tags: ["elixir"]
created: "20220310174446377"
modified: "20220310181705402"
---

A function must always be part of a module. 


## Function Names

Functions names follow the same conventions as [[./Variables in Elixir|variables]].

As with [[./Variables in Elixir|variables]], function names can end with `?` and `!` characters. These are community conventions and are not enforced by the compiler.

- The `?` character is often used to indicate a function that returns either `true` or `false.
- The `!` character often indicates that a function may raise a runtime error.

## Function Definition

Functions can be defined using the `def` macro. 

The definition starts with a `def` construct followed by the function name, the argument list, and the body enclosed in a `do...end` block. There is no type specification for arguments.

```elixir
defmodule Geometry do
  def rectangle_area(a, b) do
    ...
  end
end
```

If a function has no arguments, the parentheses can be omitted:

```elixir
defmodule Program do
  def run do
    ...
  end
end
```

## Return Value

Everything in Elixir is an expression and has a return value. The return value of a function is the return value of the last expression. There is no explicit return in Elixir.


## Condensed Function Definition

If a function is short, a condensed form can be used:

```elixir
defmodule Geometry do
  def rectangle_area(a, b), do: a * b
end
```
