---
title: "Vim Rebase Fix"
tags: ["vim", "git"]
created: "20220811140305997"
modified: "20220811140418147"
---

```
alias fix='vim `git diff --name-only | uniq`'
```

Then:
1. `git rebase blah`
2. Merge conflict
3. `fix` opens all the files that have conflicts
