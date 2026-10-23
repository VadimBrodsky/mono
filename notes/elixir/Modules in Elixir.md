---
title: "Modules in Elixir"
tags: ["elixir"]
created: "20220310172737956"
modified: "20220310174251210"
---

A module is a collection of functions, a namespace. Every Elixir function must be defined inside a module.

Elixir comes with a standard library that provides many useful modules.


## Calling a function from a module

To call a function of a module use the `ModuleName.function_name(args)` syntax.

```elixir
IO.puts("Hello World!")
```


## Module definition

To define a module use `defmodule` construct. Inside the module, can define functions using the `def` construct.

A module must be defined in a single source code file, while a single file can contain multiple module definitions.

```elixir
defmodule Geometry do
  def rectangle_area(a, b) do
    a * b
  end
end
```


## Module Naming

A module name must follow rules:
- It starts with an uppercase letter.
- Usually written in `CamelCase` style.
- Can consist of alphanumerics, underscores and dot `.` characters.

```elixir
defmodule Geometry.Rectangle do
  ...
end

defmodule Geometry.Circle do
  ...
end
```

The dot character is a convenience, once the code is compiled there are no special hierarchical relations between the modules, nor any ways to query the hierarchy. It is a syntactic sugar to help scope names.


## Nesting Modules

The child module can be referenced with `Geometry.Rectangle`, but this nesting is a convenience. After the compilation there is no special relation between the modules.

```elixir
defmodule Geometry do
  defmodule Rectangle do
    ...
  end
end
```
