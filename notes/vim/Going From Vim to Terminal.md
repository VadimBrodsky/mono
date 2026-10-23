---
title: "Going From Vim to Terminal"
tags: ["vim"]
created: "20220326172936363"
modified: "20220326173418124"
---

Vim can be suspended using job control with the `Ctrl+z` command, and continued with the foreground `fg` command.

```
Ctrl+z
fg
```

Another way to use the shell while in Vim is the `:sh` command to start a new shell. Use `Ctrl+d` or `exit` to terminate the shell and go back to Vim.


```vim
:sh
Ctrl+d or exit
```
