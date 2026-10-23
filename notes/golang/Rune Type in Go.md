---
title: "Rune Type in Go"
tags: ["golang"]
created: "20230129230336236"
modified: "20230129230622387"
---

Go has a type that represents a single code point, the Rune type.

- Is an alias for the `int32` type
- The rune literal's default type is a rune
- If you are referring to a character, use the `rune` type, not the `int23` type. They might be the same to the complier but you want to use the type that clarifies the intent of your code
