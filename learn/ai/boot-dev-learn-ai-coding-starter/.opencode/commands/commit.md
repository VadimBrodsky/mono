---
description: Review, commit project changes, then rebase on origin/main
---

Review the current project changes before committing:

1. Inspect `git status` and the diffs, including untracked project files. Do not stage secrets, generated files, or unrelated changes. If the changes are unclear or unsafe to commit, stop and ask.
2. Stage the intended project changes and commit them using this exact commit message: `$ARGUMENTS`. If no message was provided, ask for one instead of inventing it.
3. After the commit succeeds, run `git pull --rebase origin main` and report its result. If the rebase encounters conflicts, stop and explain how to resolve them; do not discard changes or force-push.
