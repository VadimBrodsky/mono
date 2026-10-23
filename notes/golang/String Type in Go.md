---
title: "String Type in Go"
tags: ["golang"]
created: "20230129225955294"
modified: "20230129230656636"
---

Go includes strings as a built-in types,. Strings in Go are immutable; you can reassign the value of a string variable, but you cannot change the value of the string that is assigned to it.

- The zero value for a string is the empty string
- Go supports Unicode. 
- Like integers and floats strings are:
  - compared for equality using `==`
  - difference with `!=`
  - ordering with `>`, `>=`, `<` or `<=`
- Concatenated using the `+` operator
- The type of a string literal is `string`
