---
title: "number data type in Lua"
tags: ["lua"]
created: "20221213021747731"
modified: "20221213022052760"
---

A number can represent any real number: 0, -1, 5 or even decimals such as 3.14592.

Lua does not differentiate between while and decimal numbers. All numbers are real numbers.

Lua has build-in `math` functions.

```lua
pi = 3.1415
three = math.floor(pi)
five = math.ceil(4.145)
```

Basic arithmetic operations such as addition, subtraction, multiplication or division can be performed on integers.

```lua
five = 3 + 2
```
