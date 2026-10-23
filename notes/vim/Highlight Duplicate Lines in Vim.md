---
title: "Highlight Duplicate Lines in Vim"
tags: ["vim"]
created: "20220505135229271"
modified: "20220505135604143"
---

1. Sort the file using `:sort`
2. Execute command `:g/^\(.*\)$\n\1$/p`

Source - [StackOverflow](https://stackoverflow.com/a/28690847)
