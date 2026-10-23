---
title: "Scope in Lua"
tags: ["lua"]
created: "20221219234231073"
modified: "20230107201217241"
---

Every Lua file is executed in its own scope.

- [[./Global Scope in Lua|Global scope]]
- [[./File Scope in Lua|File scope]]
- [[./Local Scope in Lua|Local scope]]

A scope can access any variables declared in its parent scope, but none of the variables available in any child scopes.

## Shadowing

Variables in different scopes can have the same names

```lua
message = "global-scope"
do
  local message = "local-scope"
end
```
