---
title: "Global Scope in Lua"
tags: ["lua"]
created: "20221219235108612"
modified: "20221219235232414"
---

To declare a global variable, need to omit the `local` keyword, it will be considered global, no matter what scope it is in.

```lua
foo = 7 -- local
do
  bar = 8 -- global
end
```
