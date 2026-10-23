---
title: "Mix - Elixir Code Formatter"
tags: ["elixir"]
created: "20220310180742706"
modified: "20220310181246377"
---

Starting with Elixir version 1.6, it ships with a code formatter, which can be used to format the code in a consistent style.

Formats the given files and patterns. If any of the files is `-`, then the output is read from `stdin` and written to `stdout`.

```bash
mix format mix.exs "lib/**/*.{ex,exs}" "test/**/*.{ex,exs}"
```

Reference:
- [mix format](https://hexdocs.pm/mix/Mix.Tasks.Format.html)
