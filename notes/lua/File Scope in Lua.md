---
title: "File Scope in Lua"
tags: ["lua"]
created: "20221219235322828"
modified: "20230103195921337"
---

To create a file in the file scope use the `local` keyword outside of any `do` / `end` blocks:

```lua
foo = 7 -- global, can be access from any loaded lua file
local x = 9 -- local to the .lua file being executed
do
  local bar = 8 -- local to the current do/end chunk
end
```
