---
title: "Variables in Elixir"
tags: ["elixir"]
created: "20220309212818633"
modified: "20220310174859697"
---


Variable types are determined by whatever data it contains, Elixir is a dynamic programming language.

## Variable Binding

When a variable is initialized with a value, the variable is bound to that value:


```elixir
monthly_salary = 1000
monthly_salary # 1000
monthly_salary * 12 # 12000
```

Variables can be rebound to a different value, rebinding does not mutate the existing memory location. It reserves new memory and reassignes the symbolic name to the new location.

Data in Elixir is immutable, once a memory location is occupied with data it cannot be modified until it is released. But variables can be rebound, which means they point to a different memory location.

## Variable Naming

Variable names always:
- Start with a lowercase alphabetic character or an underscore
- After that any combination of alphanumerics and underscores are allowed.

The prevalent conventions is to use only lowercase ASCII letters, digits and underscores.

```elixir
valid_variable_name
also_valid_1
validButNotRecommended
NotValid
```

Variable names can end with the question mark `?` or exclamation mark `!` characters.

```elixir
valid_name?
also_ok!
```
