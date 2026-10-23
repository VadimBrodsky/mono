---
title: "Integrating Vim with System Clipboard"
tags: ["vim"]
created: "20220310214234057"
modified: "20220310214629665"
---

Visual mode `<leader>y`

```vim
vnoremap <leader>y "+y
```

Normal mode `<leader>y`

```vim
nnoremap <leader>y "+y
```

Whole document to clipboard in normal mode

```vim
nnoremap <leader>Y gg"+yG
```

replace word with yanked text

```vim
vnoremap <leader>p "_dP
```
