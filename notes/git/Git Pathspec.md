---
title: "Git Pathspec"
tags: ["git", "unix"]
created: "20220309133405447"
modified: "20220309153641262"
---

The pathspec is the mechanism that git uses for limiting the scope of a git command to a subset of the repository.

- `:(top)` or `:/` tells git to match the pattern from the root of the git repository instead of the current working directory
- `:(icase)` tells git to ignore the case when matching
- `:(exclude)` or `:!` or `:^` tells git to ignore files

```bash
git ls-files ':(top)*.js'
git ls-files ':/*.js' # shorthand
git ls-files ':(icase)*.jpg'
git grep 'foo' -- '*.js' '^:*.test.js'
```

Reference:
- [Git Pathspecs and how to use them](https://css-tricks.com/git-pathspecs-and-how-to-use-them/)
- [What's a pathspec in the git command](https://stackoverflow.com/questions/27711924/whats-a-pathspec-in-the-git-command/36021991)
