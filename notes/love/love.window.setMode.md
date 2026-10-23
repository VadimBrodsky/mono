---
title: "love.window.setMode"
created: "20230710144910405"
modified: "20230711003419061"
---

The [`love.window.setMode`](https://love2d.org/wiki/love.window.setMode) function is used to initialize the window's dimensions and to set parameters like vsync (vertical sync), whether we're full-screen or not, and whether the window is re-sizable after startup.

```lua
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end
```
