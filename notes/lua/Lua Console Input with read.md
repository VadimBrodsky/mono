---
title: "Lua Console Input with read"
tags: ["lua"]
created: "20221213192730963"
modified: "20221213192903498"
---

Input form the console can be obtained with the `io.read()` function. The function will read one line of input from the user when the user presses _Enter_.

```lua
print("Please enter your name:")
name = io.read()
print("Hello " .. name) 
```
