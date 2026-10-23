---
title: "Pico-8 Game Loop"
tags: ["pico-8"]
created: "20240324151457268"
modified: "20240324152041480"
---

Pico-8 will use your functions for the game loop.

## _init
Executed once when the program starts, initialize all the things you need.

```lua
function _init()
  print("init")
  cls()
end
```

## _update
Executed every frame of the game, called before `_draw`. Update the game state

```lua
function _update()
  print("update")
end
```

## _draw
Usually executed every frame of the game, called after `_update`. Sometimes might be skipped if the game is lagging.

```lua
function _draw()
  print("draw")
end
```
