---
title: "LÖVE configuration using conf.lua"
tags: ["LÖVE"]
created: "20230705204516077"
modified: "20230706162529133"
---

Use the `conf.lua` file to set specs for the LÖVE game.

```lua
function love.conf(w)
  w.window.width = 1024
  w.window.height = 768
  w.window.title = "Title"
end
```
