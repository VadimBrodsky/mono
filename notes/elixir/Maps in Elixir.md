---
title: "Maps in Elixir"
tags: ["elixir"]
created: "20220313232713189"
modified: "20220313235405079"
---

A map is a key / value store, where keys and values can be any term. Maps have dual usage in elixir. They used to power dynamically sized key / value structures. As well as used to manage simple records.

## Dynamically Sized Maps

An empty map can be created with the `%{}` construct:

```elixir
empty_map = %{}
squares = %{1 => 1, 2 => 4, 3 => 9}
```

Can also populate a map with the `Map.new/1` function. It takes an enumerable where each element is a tuple of size two (a pair):

```elixir
squares = Map.new([{1, 1}, {2, 4}, {3, 9}])
```

To fetch a value for a given key:

```elixir
squares[2]  # 4
squares[4]  # nil, no value is associated with a given key
```

The `Map.get/3` function allows to specify the default value which is returned if the key is not found. If the default is not provided, `nil` will be returned:

```elixir
Map.get(squares, 2)             # 4
Map.get(squares, 4)             # nil
Map.get(squares, 4, :not_found) # :not_found
```

To know precisely if the value is missing use `Map.fetch/2`:

```elixir
Map.fetch(squares, 2)  # {:ok, 4}
Map.fetch(squares, 4)  # :error
```

If we need to proceed only if the key is in the map, and raise an exception otherwise, use `Map.fetch!/2`:

```elixir
Map.fetch!(squares, 4)  # (KeyError) key 4 not found in: %{1 => 1, 2 => 4, 3 => 9}
```

To store a new element to the map, use `Map.put/3`:

```elixir
squares = Map.put(squares, 4, 16)  # %{1 => 1, 2 => 4, 3 => 9, 4 => 16}
squares[4]                         # 16
```

Other helpful functions are [Map.update/4](https://hexdocs.pm/elixir/Map.html#update/4) and [Map.delete/2](https://hexdocs.pm/elixir/Map.html#delete/2).


## Structured Data

Maps are the go-to type for managing key/value data structures of an arbitrary size. They are used to combine a couple of fields into a single structure.

```elixir
bob = %{:name => "Bob", :age => 25, :works_at => "Google"}
```

If the keys are atoms, there is a shorter syntax:

```elixir
bob = %{name: "Bob", age: 25, works_at: "Google}
```

To retrieve values:

```elixir
bob[:works_at]           # "Google"
bob[:non_existent_field] # nil
bob.age                  # 25
bob.non_existent_field   # (KeyError) key :non_existent_field not found
```

To change a field, use the recursive list syntax. Only values that already exist in the map can be modified.

```elixir
next_years_bob = %{bob | age: 26}  # %{age: 26, name: "Bob", works_at: "Google"}
%{bob | works_in: "Meta"}          # (KeyError) key :works_in not found
```
