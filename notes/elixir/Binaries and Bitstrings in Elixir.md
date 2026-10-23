---
title: "Binaries and Bitstrings in Elixir"
tags: ["elixir"]
created: "20220313235543773"
modified: "20220316001214075"
---

A binary is chunk of bytes. Binaries are created by enclosing the byte sequence between `<<` and `>>` operators.

Each number represents the value of the corresponding byte. If a byte value is bigger than 255, it will truncated to the byte size.

```elixir
<<1, 2, 3>>  # 3 byte binary <<1, 2, 3>> 
<<256>>      # <<0>>
<<257>>      # <<1>>
<<512>>      # <<0>>
```

The size of each value can be specified, telling the compiler how many bits to use for that value:

```elixir
<<257::16>>           # <<1, 1>>
<<1::4, 15::4>>       # <<31>>
<<1::1, 0::1, 1::1>>  # <<5::size(3>>
```

Use `<>` to concatenate two binaries or bitstrings:

```elixir
<<1, 2>> <> <<3, 4>>  # <<1, 2, 3, 4>>
```
