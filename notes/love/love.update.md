---
title: "love.update"
tags: ["LÖVE"]
created: "20230706174717187"
modified: "20230711003641287"
---

The [`love.udpate`](https://love2d.org/wiki/love.update) function is called for each frame by Love; `dt` will be the elapsed time in seconds since the last frame, and we can use this to scale any changes in our game for even behaviour across frame rates.

Passed a `dt` value which is the delta time for the frame which is usually 1 / 60 of a second for 60hz.

```lua
function love.update(dt)
  if love.keyboard.isDown('d') then
    angle = angle + math.pi * dt
  elseif love.keyboard.isDown('a') then
    angle = angle - math.pi * dt
  end
end
```
