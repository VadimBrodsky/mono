---
title: "Tuples in Elixir"
tags: ["elixir"]
created: "20220312183329559"
modified: "20220313223835811"
---

Tuples are like untyped structures, or records. They are often used to group a fixed number of elements together. Tuples are most appropriate for grouping a small, fixed number of elements together.

```elixir
person = {"Bob", 25}
```

To get an element from a tuple use `Kernel.elem/2`, to modify an element use `Kernel.put_elem/3`

```elixir
age = elem(person, 1)                   # 25
older_person = put_elem(person, 1 ,26)
person                                  # {"Bob", 25}
older_person                            # {"Bob", 26}
```
