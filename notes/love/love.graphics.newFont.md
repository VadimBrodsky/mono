---
title: "love.graphics.newFont"
tags: ["LÖVE"]
created: "20230710224553228"
modified: "20230711015917580"
---

The [`love.graphics.newFont`](https://love2d.org/wiki/love.graphics.newFont) function loads a font file into memory  at a specific path, setting it to specific size, and storing it in an object that we can use to globally change the current active font that Love2D is using to render text. Functioning like a state machine.

Fonts are immutable and same font face with different sizes need to be declared separately. 

```lua
font = love.graphics.newFont(path, size)
```
