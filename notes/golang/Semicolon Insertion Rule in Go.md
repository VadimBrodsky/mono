---
title: "Semicolon Insertion Rule in Go"
tags: ["golang"]
created: "20230114153225569"
modified: "20230114153726865"
---

Go requires a semicolon at the end of every statement, however Go developers never put the semicolons in themselves. The Go compiler does it.

If the last token before a newline is any of the following, the lexer inserts a semicolon after the token:
- An identifier (which includes worlds like `int` and `float64`)
- A basic literal such as a number or string constant
- One of the tokens: `break`, `continue`, `fallthrough`, `return`, `++`, `--`, `)` or `}`
