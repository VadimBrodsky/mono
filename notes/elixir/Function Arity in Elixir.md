---
title: "Function Arity in Elixir"
tags: ["elixir"]
created: "20220311021656915"
modified: "20220311022647222"
---

A function is uniquely identified by its containing module, its name, and its arity.

Two functions with the same name but different arities are two different functions.

```elixir
defmodule Rectangle do
  # Rectangle.area/1
  def area(a), do: area(a, a)

  # Rectangle.area/2
  def area(a, b), do: a * b
end
```

Commonly a lower-arity function delegates to a higher-arity function, providing some default arguments.


## Default Values

Elixir allows to specify defaults for arguments by using the `\\` operator followed by the argument's default value. This definition generates two functions.


```elixir
defmodule Calculator do
  def sum(a, b \\ 0) do
    a + b  
  end
end
```

Defaults can be set for any combination of arguments:

```elixir
defmodule MyModule do
  def fun(a, b \\ 1, c, d \\ 2) do
    a + b + c + d
  end
end
```

Because arity distinguishes multiple functions of the same name, it is not possible to have a function accept a variable number of arguments.
