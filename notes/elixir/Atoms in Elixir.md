---
title: "Atoms in Elixir"
tags: ["elixir"]
created: "20220312183206674"
modified: "20220312183215710"
---

Atoms are literal named constants, like symbols in Ruby. Start with a colon character, followed by a combination of alphanumerics or underscores:

```elixir
:an_atom
:another_atom
:"an atom with spaces"
```

An atom consists of two parts: text and value. The atom text is whatever you put after the colon character. At runtime, this text is kept in the atom table. The value is the data goes into the variable, a reference to the atom table.

Atoms are best for named constants, they are efficient for both memory and performance.

```elixir
variable = :some_atom
```

The variable doesn't contain the entire text, but only a reference to the atom table.


## Aliases

Another syntax for atom constants, omitting the beginning colon and starting with an uppercase character, at compile time it is transformed into an atom.

```elixir
AnAtom
AnAtom == :"Elixir.AnAtom" # true
AnAtom == Elixir.AnAtom    # true

alias IO, as: MyIO         # compiler transforms MyIO to IO
MyIO == Elixlir.IO
```


## Atoms as Booleans

Elixir does not have a dedicated Boolean type, instead the atoms `:true` and `:false` are used. As syntactic sugar, Elixir allows to reference these atoms without the starting colon:

```elixir
:true == true
:false == false
```

The term Boolean is used in Elixir to denote an atom that has the value of `:true` or `:false`.

```elixir
true and false  # false
false or true   # true
not false       # true
not :an_atom_other_than_true_or_false # (ArgumentError) argument error
```


## Nil and Truthy Values

Another special atom is `:nil`, which works similarly to `null` in other languages. Can reference `nil` without a colon. The atoms `nil` and `false` are treated as falsy values, everything else is truthy.

```elixir
nil == :nil                 # true
nil || false || 5 || true   # 5
true && 5                   # 5
false && 5                  # false
nil && 5                    # nil
```
