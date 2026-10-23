---
title: "Imports and Aliases in Elixir"
tags: ["elixir"]
created: "20220311213848465"
modified: "20220312141738174"
---

## Import

Importing a module allows you to call its public functions without prefixing them with the module name.

```elixir
defmodule MyModule do
  import IO

  def my_function do
    puts "Calling imported function."
  end
end
```

The standard library's [Kernel](https://hexdocs.pm/elixir/Kernel.html) module is automatically imported into every module.


## Alias

Another construct, `alias` makes it possible to reference a module under a different name. It is particularly useful when importing long or nested modules names.

```elixir
defmodule MyModule do
  alias IO, as: MyIO

  # alias Geometry.Rectangle, as: Rectangle
  alias Geometry.Rectangle 

  def my_function do
    MyIO.puts("Calling imported function.")
    Rectangle.area(2, 3)
  end
end
```
