Go through this tutorial -- [Git Tutorials](https://www.atlassian.com/git/tutorial)


## Initial Setup
- Setup user name and email that will appear in commits.

```bash
git config --global user.name "Your Name"
git config --global user.email your.email@example.com
```

```bash
git config --global core.editor "subl -w"
```

## Setup SSH Keys
 
- Generate new SSH identity `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`                                                                
- Check if SSH Agent is running `ps -e | grep [s]sh-agent`
- Start SSH Agent `ssh-agent /bin/bash`                                                                                                            
- Load identity into SSH agent `ssh-add ~/.ssh/id_rsa`                                                                                             
- List SSH commands that the agent is managing `ssh-add ~/.ssh/id_rsa`                                                                             
- Check connection to Github `ssh -T git@github.com`


## Checkout
- Checkout the previous repository and discard all current changes.

```bash
git checkout -f
```

### Checkout a Remote Branch Locally

```bash
git branch -a
git checkout origin/branch_name
git checkout -b branch_name origin/branch_name
```

## Cleaning Up

### Remove Local Untracked files
- Use the `git clean` [command](http://git-scm.com/docs/git-clean) to remove untracked files from the working tree.
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


### Track a remote branch with an Existing Branch

```bash
git branch -u remote/branch_name
git branch -u remote/branch_name branch_name
```


## Setting Github Repo

```bash
git remote add origin https://github.com/<username>/first_app.git
git push -u origin master
```


## Pushing a Local Branch to Github

```bash
git push origin branch-name
```


## Rename Files
- Renaming files with Git tracking.

```bash
git mv README.rdoc README.md
```


## Branches

### View All Branches

```bash
git branch
```

### Switch to a Branch

```bash
git checkout branch-name
```

### Abandon a Feature Branch

```bash
git checkout master
git branch -D bad-branch
```


### Delete Branch

```bash
git branch -d branch-name
```


### Create a Branch
- To create a new branch use the `checkout` command.
- Use the `-b` flag to switch to the new branch at creation.

```bash
git checkout -b branch-name
```


## Merge

### Merge

```bash
git checkout master
git merge branch-name
```


### Creating a Tag
- Annotated Tags: 
	- Stored as full objects in the Git database, 
	- Checksummed
	- Contain the tagger name, e-mail, and date, 
	- Have a tagging message and 
	- Can be signed and verified with GPG.
	- Specify `-a` when you run the `tag` command.
- Lightweight Tags: 
	- The commit checksum stored in a file — no other information is kept. 
	- To create a lightweight tag, don’t supply any of the `-a`, `-s`, or `-m` options.

```bash
git tag -a v1.4
git tag -a v1.4 -m 'my version 1.4'
```

```bash
git push --tags
git push --tags <tagname>
```