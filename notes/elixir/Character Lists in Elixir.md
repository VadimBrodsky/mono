---
title: "Character Lists in Elixir"
tags: ["elixir"]
created: "20220324013823709"
modified: "20220324014628383"
---

Alternative way to specify a [[./Strings in Elixir|string]] in Elixir. Creating a character list  which is a list of integers in which each element represents a single character.

```elixir
'ABC'
[65, 66, 67]  # same as 'ABC'
```

The runtime does not distinguish between a list of characters and a character list. When a list consists of integers that represent printable characters, it's printed to the screen in the string form.

```elixir
'Interpolation: #{3 + 0.14}'     # 'Interpolation: 3.14'
~c(Character list sigil)         # 'Character list sigil'
~C(Unescaped sigil #{3 + 0.13})  # 'Unescaped sigil \#{3 + 0.13}'
'''
Heredoc
'''                              # 'Heredoc\n'
```

Character lists are not compatible with binary strings. Most operations from the `String` module would not work with character lists. In general binary strings are preferred over character lists. They are mostly used in pure Erlang libraries.

To convert a binary string to a character list version use `String.to_charlist/1` function:

```elixir
String.to_charlist("ABC")        # 'ABC'
```

To convert a character list to a binary string, use the `List.to_string/1` function.
