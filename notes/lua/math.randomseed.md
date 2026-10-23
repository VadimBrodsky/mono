---
title: "math.randomseed"
tags: ["lua"]
created: "20230711024425852"
modified: "20230711024732556"
---

The `math.randomseed` function seeds the random number generator used by Lua ([`math.random`](#math.random)) with some value such that its randomness is dependent on that supplied value, allowing us to pass in different numbers each play-through to guarantee non-consistency across program executions (or uniformity if we want consistent behaviour for testing).

```lua
math.randomseed(num)
```
