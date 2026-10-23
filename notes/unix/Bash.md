## Basic Unix Commands

| Description                | Command                |
|:---------------------------|:-----------------------|
| List contents              | `ls`                   |
| Make directory             | `mkdir <dirname>`      |
| Change directory           | `cd <dirname>`         |
| Up one directory           | `cd ..`                |
| To home directory          | `cd ~` or `cd`         |
| Move file (rename)         | `mv <source> <target>` |
| Copy file                  | `cp <source> <target>` |
| Remove file                | `rm <file>`            |
| Remove empty directory     | `rmdir <directory>`    |
| Remove non empty directory | `rm -rf <directory>`   |


## Which
- To find where a program is located.

```bash
which $SHELL
/bin/bash
```


## Echo
- Echoes back whatever was typed in.

```bash
echo 'hello'
hello
```

```bash
echo $PATH
/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/Users/vadimbrodsky/bin
```


## Cat
- Concatenates and displays the file contents.

```bash
cat ~/.bash_profile
```


# Editing the Bash Profile
- To customize the bash environment.

```bash
vim ~/.bash_profile
```


# Initializing the New Profile
- Either open a new terminal window to have the changes take effect.
- Or run the command:

```bash
source ~/.bash_profile
```


## Customize Prompt
- Uses the `PS1` setting.

```
PS1="\u$ "
```


## Alias
- Create aliases or shortcuts to different files and programs.

```
alias ll="ls -lahG"
```

## Export Path
- Customize the paths at which Unix will look for commands.

```
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
```

# Setting Up Sublime Text 
- To call Sublime Text from the command line.
- Create a symlink.

```bash
ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
```