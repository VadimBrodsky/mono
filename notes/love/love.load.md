---
title: "love.load"
tags: ["LÖVE"]
created: "20230706173625680"
modified: "20230711003533512"
---

The [`love.load`](https://love2d.org/wiki/love.load) function is used for initializing our game state at the very beginning of  program execution.

```lua
function love.load()
  -- sets the colour for our shapes in RGB
  love.graphics.setColor(0, 0, 0, 255)
  -- sets the colour of the background in RGB
  love.graphics.setBackgroundColor(255, 153, 0)

  -- assigns a font of 25px
  local myfont = love.graphics.newFont(25)
  -- sets the font for the love.graphics.print to use
  love.graphics.setFont(myfont)
end
```
