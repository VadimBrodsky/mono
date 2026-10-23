---
title: "Module Attributes in Elixir"
tags: ["elixir"]
created: "20220312172721433"
modified: "20220312173905038"
---

Module attributes are useful as compile time constants, that can be queried in runtime. In addition registered attributes can be used to attach meta information to a module, which can be used by other Elixir or Erlang tools.

```elixir
defmodule Circle do
  @moduledoc "Implements basic circle functions"
  @pi 3.14159

  @doc "Computes the area of a circle"
  def area(r), do: r*r*@pi

  @doc "Computes the circumference of a circle"
  def circumference(r), do: 2*r*@pi
end
```

The constants only exists during the compilation of the module, when the references to it are inlined. An attribute is registered, which means it will be stored in the generated binary and can be accessed at runtime. Elixir registers [some module attributes by default](https://hexdocs.pm/elixir/Module.html).

For example the `@moduledoc` and @doc` can be used to provide documentation for module functions.

A [[./Compiling in Elixir|compiled]] file can be loaded in IEx and the `@doc` attributes read:

```elixir
Code.get_docs(Circle, :moduledocs)
```
