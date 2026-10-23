---
title: "love.graphics.setDefaultFilter"
tags: ["LÖVE"]
created: "20230710143336389"
modified: "20230711003500269"
---

The [`setDefaultFilter`](https://love2d.org/wiki/love.graphics.setDefaultFilter) function sets the texture scaling filter when minimizing and magnifying textures and fonts; default is bilinear, which causes blurriness, if we want a sharp pixelated look we typically want nearest-neighbour filtering `nearest`, which results in perfect up-scaling and downswing, simulating a retro feel.

```lua
love.graphics.setDefaultFilter(min, mag)
```
