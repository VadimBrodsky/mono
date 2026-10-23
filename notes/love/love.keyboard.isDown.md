---
title: "love.keyboard.isDown"
tags: ["LÖVE"]
created: "20230711022232483"
modified: "20230711022553202"
---

The [`love.keyboard.isDown`](https://love2d.org/wiki/love.keyboard.isDown) function returns `true` or `false` depending on whether the specified key is currently held down. Differs from [[./love.keypressed]] in that this can be called arbitrarily  and will continuously return true if the key is pressed down.

```lua
right_pressed = love.keyboard.isDown('right')
```
