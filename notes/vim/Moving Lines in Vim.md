---
title: "Moving Lines in Vim"
tags: ["vim"]
created: "20220310214429853"
modified: "20220310214505860"
---

- Map `J` to move a line up
- Map `K` to move a line down

```vim
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<+2<CR>gv=gv
```
