---
title: "Elixir Interactive Shell"
tags: ["elixir"]
created: "20220309175026489"
modified: "20220310174428858"
---

## Running the Shell

Start the Elixir interactive shell by running `iex`.

```bash
iex
```

Running `iex` start an instance of the BEAM and then starts an interactive Elixir shell inside it.

Everything in Elixir is an expression that has a return value.

The shell will not evaluates an expression until it is finished, a line break usually indicates an end of an expression.

To leave the shell, press `Ctrl+c` twice, to kill the shell in a graceful way run `System.halt`

To get documentation on anything in Elixir from the shell use the `h` function, getting help on IEx from the shell run `h IEx`.

## Evaluating a file in the shell

IEx can interpret an Elixir file:

```bash
iex geometry.ex
```
