---
title: "Numbers in Elixir"
tags: ["elixir"]
created: "20220312182901568"
modified: "20220312182937257"
---

Numbers can be integers or floats:

```elixir
3         # integer
0xFF      # integer written in hex
3.14      # float
1.0e-2    # float, exponential notation
1_000_000 # underscore character as visual delimiter
```

There is no upper limit on integer size, An integer takes [as much space](https://www.erlang.org/doc/efficiency_guide/advanced.html) as needed to accomodate the number. Floats occupy either 32 or 64 bits, depending on the build architecture of the virtual machine.

Standard arithmetic operators:

```elixir
1 + 2 * 3  # as expected
4 / 2      # returns a float value 2.0
3 / 2      # 1.5
div(5, 2)  # integer division, auto imported from the Kernel module
rem(5, 2)  # remainder, auto imported from the Kernel module
```
