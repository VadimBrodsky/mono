---
title: "Function Visibility in Elixir"
tags: ["elixir"]
created: "20220311023146554"
modified: "20220311143115506"
---

When a function is defined using the `def` macro, the function is made public; it can be called by anyone else. The function is *exported*.

When a function is defined with the `defp` macto, the function is private. It can only be used inside the module it is defined in.

```elixir
defmodule TestPrivate do
  def double(a) do # exported function
    sum(a, a)
  end

  defp sum(a, b) do # private function
    a + b
  end
end
```
