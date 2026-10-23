---
title: "love.resize"
tags: ["LÖVE"]
created: "20230720022212886"
modified: "20230720022428034"
---

The [love.resize](https://love2d.org/wiki/love.resize) function called by Love every time we resize the application, logic should go in here if anything in the game like the UI is sized dynamically based on the window size `size.push:resize()` needs to be called to dynamically resale the internal canvas to fit the new window dimensions.

```lua
function love.resize(w, h)
  print(("Window resized to width: %d and height: %d."):format(w, h))
end
```
