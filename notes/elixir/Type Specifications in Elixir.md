---
title: "Type Specifications in Elixir"
tags: ["elixir"]
created: "20220312174558812"
modified: "20220312175144407"
---

Type specifications, [typespecs](https://hexdocs.pm/elixir/typespecs.html), are a feature based on [[./Module Attributes in Elixir|attributes]]. Allows to provide type information for functions, which can be later analyzed with static analysis tool [dialyzer](https://erlang.org/doc/man/dialyzer.html).

```elixir
defmodule Circle do
  @pi 3.14159

  @spec area(number) :: number
  def area(r), do: r*r*@pi

  @spec circumference(number) :: number
  def circumference(r), do: 2*r*@pi 
end
```

The use of `@spec` attribute indicates that both functions accept and return a number.
