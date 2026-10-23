---
title: "Unix Disk Usage"
tags: ["unix"]
created: "20220326172602045"
modified: "20220326172813825"
---

The `df` command indicates how much space is free on a given filesystem, or on the system as whole.

```bash
df
```

The `du` command indicates how many disk blocks are used for a given files and directories.

```bash
du -s * | sort -nr
```
