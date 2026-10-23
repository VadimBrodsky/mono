---
title: "Basic Data Types in Lua"
tags: ["lua"]
created: "20221213011749293"
modified: "20221213191140237"
---

Every value in Lua has a data type, it describes what kind of data the value holds. Lua supports 8 basic value types:

- [[./nil data type in Lua|nil]]
- [[./Boolean data type in Lua|Boolean]]
- [[./number data type in Lua|number]]
- [[./string data type in Lua|string]]
- `function` - a function is some code that is referred to by a name and ca be executed any time.
- `table` - contains information using key-value pairs.
- `userdata` - complex data structured defined in the C programming language
- `thread` - threads can be used to execute code in parallel

To check the type of a variable use the `type` function:

```lua
var1 = true
var2 = 3.145
var3 = nil
var4 = type(var1)

type(var1) -- boolean
type(var2) -- number
type(var3) -- nil
type(var4) -- string
```
