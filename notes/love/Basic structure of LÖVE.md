---
title: "Basic structure of LÖVE"
tags: ["LÖVE"]
created: "20230705202923943"
modified: "20230706174710636"
---

The basic functions that make up a LÖVE game:

- [[./love.load|`love.load()`]] - preloads all the necessary assets we need.
- [[./love.update|`love.update(dt)`]] - deal with events, called before the frame is drawn, `dt` is the time to draw a frame.
- [[./love.draw|`love.draw()`]] - draws to display.
