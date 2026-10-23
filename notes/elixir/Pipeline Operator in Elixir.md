---
title: "Pipeline Operator in Elixir"
tags: ["elixir"]
created: "20220310181752053"
modified: "20220310182545955"
---

To pass the result of one function as the first argument of the next one.

```elixir
-5 |> abs() |> Integer.to_string() |> IO.puts()
prev(arg1, arg2) |> next(arg3, arg4)
```

This is transformed at compile time into:

```elixir
IO.puts(Integer.to_string(abs(-5)))
next(prev(arg1, arg2), arg3, arg4)
```

The pipeline operator can lay over multiple lines:

```elixir
-5
|> abs()
|> Integer.to_string()
|> IO.puts()
```

Multiline pipelines don't work in the IEx shell.
