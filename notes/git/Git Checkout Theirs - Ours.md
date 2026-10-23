---
title: "Git Checkout Theirs / Ours"
tags: ["git"]
created: "20220721154531229"
modified: "20220721154908187"
---

To resolve a git conflict in favour of their changes during a pull, when in a conflict state. Abbreviated from [StackOverflow](https://stackoverflow.com/a/21777677).

```bash
git checkout --theirs path/to/file
```

```bash
git checkout --theirs .
```

Or the opposite

```bash
git checkout --ours .
```
