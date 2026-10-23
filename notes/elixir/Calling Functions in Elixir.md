---
title: "Calling Functions in Elixir"
tags: ["elixir"]
created: "20220310181707999"
modified: "20220310181811754"
---

To call a function defined in another module, use the module name followed by the function name:

```elixir
Geometry.rectangle_area(3, 2)
```

The result of a function can be assigned to a variable:

```elixir
area = Geometry.rectangle_area(3, 2)
```

Parentheses are optional in Elixir:

```elixir
Geometry.rectangle_area 3, 2
```

If a function resides in the same module, the module name can be omitted:

```elixir
defmodule Geometry do
  def rectangle_area(a, b) do
    a * b
  end

  def square_area(a) do
    rectangle_area(a, a)
  end
end
```
