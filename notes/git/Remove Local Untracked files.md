# Remove Local Untracked files

- Use the `git clean` command to remove untracked files from the working tree.
- `f` flag to force the removal
- `d` flag to remove directories
- `X` flag to remove ignored files
- `x` flag to remove ignored and non-ignored files

```bash
git clean -f
git clean -f -d
git clean -f -X
git clean -f -x
```
