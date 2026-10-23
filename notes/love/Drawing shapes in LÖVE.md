---
title: "Drawing shapes in LÖVE"
tags: ["LÖVE"]
created: "20230706173238817"
modified: "20230706173320080"
---

Use the `love.graphics` methods to draw shapes.

```lua
function love.draw()
  love.graphics.circle("fill", 200, 300, 50, 50)
  love.graphics.rectangle("fill", 300, 300, 100, 100)
  love.graphics.arc("fill", 450, 300, 100, math.pi / 5, math.pi / 2)
end
```
