---
title: "love.graphics.rectangle"
created: "20230711015956826"
modified: "20230711020313655"
---

The [`love.graphics.rectangle`](https://love2d.org/wiki/love.graphics.rectangle) function draws a rectangle onto the screen using whichever our active colour is ([`love.graphics.setColor`](#love.graphics.setColor)). 

`mode` can be set to `'fill'` or `'line'`, which results in a filled or outlined rectangle, and the other four parameters are its position and size dimensions. 

```lua
love.graphics.rectangle(mode, x, y, width, height)
```
