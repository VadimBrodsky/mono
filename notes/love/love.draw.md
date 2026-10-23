---
title: "love.draw"
tags: ["LÖVE"]
created: "20230705203700820"
modified: "20230711003517903"
---

The [`love.draw`](https://love2d.org/wiki/love.graphics.draw) function is called each frame by Love after the update for drawing things to the screen once the are changed.

```lua
function love.draw()
  love.graphics.print('hello world!', 400, 300)
end
```
