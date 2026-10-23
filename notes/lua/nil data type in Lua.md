---
title: "nil data type in Lua"
tags: ["lua"]
created: "20221213021143675"
modified: "20221213021636095"
---

The absence of data, represents literal nothingness. If a certain piece of data is invalid or unknown, `nil` is the best way to represent that it is invalid or unknown.

If you try to access a variable that has not been created yet its value will be `nil`.

```lua
print(foo)   -- nil
foo = "bar"
print(foo)   -- bar
foo = nil
print(foo)   -- nil
```
