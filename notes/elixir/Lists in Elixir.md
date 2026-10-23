---
title: "Lists in Elixir"
tags: ["elixir"]
created: "20220313223904784"
modified: "20220313232903138"
---

List in Erlang are used to manager dynamic, variable-sized collections of data. The syntax resembles arrays from other languages. Lists work like singly linked lists, to do something with the list you have to traverse it. Most operations on lists have an `O(n)` complexity, including the `Kernel.length` function.

Lists are never a good fit when a direct access is needed. Use [[./Tuples in Elixir|Tuples]], [[./Maps in Elixir|Maps]] or higher level data structures instead.

List are a [[./Recursive List Definition in Elixir|recursive data structure]] in Elixir

```elixir
prime_numbers = [2, 3, 5, 7]
length(prime_numbers)         # 4
```

To get an element from a list, `Enum.at/2`, check for an element with `in`:

```elixir
Enum.at(prime_numbers, 3)  # 7
5 in prime_numbers         # true
```

To manipulate lists use the `List` module, `List.replace_at/3` modifies the element at certain position, `List.insert_at` inserts a new item in the list, while index `-1` appends to the end of the list:

```elixir
new_primes = List.replace_at(prime_numbers, 0, 11)  # [11, 3, 5, 7]
new_primes = List.insert_at(prime_numbers, 3, 13)   # [11, 3, 13, 7]
new_primes = List.insert_at(prime_numbers, -1, 13)  # [11, 3, 13 ,7, 13]
```

To concatenate two lists use `++` operator, the complexity of is `O(n)`, `n` being the length of the left list. In general avoid adding elements to the end of a list. Lists are most efficient when new elements are pushed to the top, or popped from it.

```elixir
[1, 2, 3] ++ [4, 5]  # [1, 2, 3, 4, 5]
```

## Useful docs for Lists

- [List](https://hexdocs.pm/elixir/List.html)
- [Enum](https://hexdocs.pm/elixir/Enum.html)
