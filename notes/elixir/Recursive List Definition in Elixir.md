---
title: "Recursive List Definition in Elixir"
tags: ["elixir"]
created: "20220313225620728"
modified: "20220313231928635"
---

An alternative way of looking at lists is to think of them as recursive structures. A list can represented by a pair `(head, tail)`, where `head` is the first element of the list and `tail` points to the `(head, tail)` pair of the remaining elements. Similar to `cons cells` in Clojure.

In Elixir the syntax to support recursive list definition:

```elixir
a_list = [head | tail]
```

`head` can be any type of data, where `tail` is itself a list. If `tail` is an empty list, it indicates the end of the entire list:

```elixir
[1 | []]                    # [1]
[1 | [2 | []]]              # [1, 2]
[1 | [2, 3, 4]]             # [1, 2, 3, 4]
[1 | [2 | [3 | [4 | []]]]]  # [1, 2, 3, 4]
```

Use `hd` to get the head and `tl` to get the tail, both operations are `O(1)`:

```elixir
hd([1, 2, 3, 4])  # 1
tl([1, 2, 3, 4])  # [2, 3, 4]
```

The tail doesn't need to be a list, it can be of any type. When a tail is not a list, the list is improper and most standard list manipulations do not work.

Its simple and efficient to push new element to the top of the list:

```elixir
a_list = [5, :value, true]        # [5, :value, true]
new_list = [:new_list | a_list]   # [:new_element, 5, :value, true]
```
