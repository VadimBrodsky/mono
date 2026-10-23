---
title: "Vim Key Remapping"
tags: ["vim"]
created: "20220310213936212"
modified: "20220310214118271"
---

Using the `remap` command:
- `n` - mode: `i`, `v`, `c`, `t`
- `nore` - no recursive execution
- `map`

```vim
let mapleader = " "
nnoremap <leader>pv :Vex<CR>
```
