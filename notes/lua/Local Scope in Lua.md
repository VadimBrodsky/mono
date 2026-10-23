---
title: "Local Scope in Lua"
tags: ["lua"]
created: "20230107200651868"
modified: "20230107200701827"
---

To create a local scope chunk by using the `do` keyword:

```lua
-- main file scope is anywhere in the file
foo = 7 -- global

do
  -- local scope
  local bar = 8 -- local
  do
    local x = 9 -- nested local
    -- can access foo, bar and x
  end
end
-- can only access foo
```
