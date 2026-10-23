---
title: "love.graphics.printf"
tags: ["LÖVE"]
created: "20230710144638890"
modified: "20230711003426143"
---

The [`love.graphics.printf`](https://love2d.org/wiki/love.graphics.printf) is a versatile print function that can align text left, right or centre on the screen.

```lua
function love.draw()
    love.graphics.printf(
        'Hello Pong!',          -- text to render
        0,                      -- starting X (0 since we're going to center it based on width)
        WINDOW_HEIGHT / 2 - 6,  -- starting Y (halfway down the screen)
        WINDOW_WIDTH,           -- number of pixels to center within (the entire screen here)
        'center')               -- alignment mode, can be 'center', 'left', or 'right'
end
```
