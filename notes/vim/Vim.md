# Building NeoVim
```bash
sudo apt-get install git
sudo apt-get install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
git clone https://github.com/neovim/neovim.git
git checkout v0.2.0
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```


# Moving Around
- `hjkl` - left, down, up, right
- `-` - up char
- `+` - down char
- `b` - before word
- `B` - before code word
- `w` - next word
- `W` - next code word
- `0` - line start
- `^` - first char
- `$` - line end
- `e` - word end
- `E` - code word end
- `{` or `}` - beginning or end of the paragraph
- `(` or `)` - beginning or end of the sentence
- `%` - bounce between parentheses, quotes, and language specific blocks


## Go To
- `gm` - go to middle of line
- `g0` - go to line start
- `g^` - go to first char
- `g$` - got to line end
- `ge` - previous end of word
- `gE` - previous end of code word
- `gk` - go up screen line
- `gj` - go down screen line


## Find on Line
- `fx` - find next x
- `Fx` - find previous x
- `;` - repeat latest jump forward
- `,` - repeat latest jump backward


## Screen Position
- `H` - high, top of screen
- `L` - low, bottom of screen
- `M` - medium, center of screen
- `zt` - scroll current line to top of screen
- `zz` - scroll current line to middle of screen
- `zb` - scroll current line to bottom of screen


## Scrolling
- `C-b` - scroll full screen before / up
- `C-u` - scroll half screen up
- `C-y` - scroll one line up
- `C-e` - scroll one line down
- `C-d` - scroll half screen down
- `C-f` - scroll full screen forward / down


# Document Navigation
- `12G` or `12gg` - jumps to line 12
- `gg` - jumps to top of the document
- `G` - jumps to bottom of the document
- `g C-g` - displays current position in the file
- `H` - high, jumps to the top of the view
- `M` - middle, jumps to the middle of the view
- `L` - low, jumps to the bottom of the view


## Marks
- `ma` - create a mark named 'a', lowercase are file-specific, uppercase are global
- ``a` - jump to the exact line and column
- `'a` - jump to beginning of maked line only
- `d't` - delete to mark `t`


### Vim's Marks
- ``0-`9` - the location of the cursor when you last exited Vim
- `"` and `` - the position of the cursor before the latest jump
- `'.` and ``.` - Location of the last edit
- `:marks` - to see a list of marks


# Inserting Text
- `i` - insert text before the cursor
- `a` - insert text after the cursor
- `I` - move to first non-blank character of line and insert
- `A` - append text at the end of the line
- `o` - open a new line below
- `O` - open a new line above


# Repeating
- `.` - repeat the last command
- `@:` - repeat the last executed command


## Replacing Text
- `r` - replace a single character
- `R` - go to replace mode
- `c` - change: delete words and switch to insert mode
- `cc` or `C` - change the whole line


## Deleting
- `x` - delete a character
- `dd` or `D` - delete a line


## Copying
- `y` - yank the current selection
- `yy` or `Y` - yank the line
- `"ayy` - yank line into register a
- `"+yy` - tank to the system clipboard


## Pasting
- `"ap` - paste from register a
- `""` - the unnamed register, contained the last deleted text
- `"0p` - paster from the zero register - contents of the last yank command
- `:registers` - shows contents of all registers
- `"+` - paste from clipboard



## Joining Lines
- `J` - join the previous line with the current, adds space
- `gJ` - join previous line without adding space


# Text Manipulation
- `<<` - indent left
- `>>` - indent right
- `C-t` - indent right from insert mode
- `C-d` - indent left from insert mode


# Selection
- `vit` - operator extent object
    - operators: change, delete, yank, visual
    - extent: all delimeters, inner object
    - object: word, Word, sentence, paragraphm tag, ", ', [, {
- `o` - in visual mode, switches which end is being manipulated


# Undo / Redo
- `u` - undoes 1 action
- `C-r` - redoes 1 action


# Search in File
- `/query` or `?query` - search down or up
- `n` - next match
- `N` - previous match
- `*` - next current word
- `#` - previous current word
- `g*` - next partial match
- `g#` - previous partial match


# Search & Replace
- `:%s/search/replace/gc`
    - `%` - search the current buffer
    - `g` - global: search all occurrences
    - `c` - confirm: ask for confirmation on each match
    - `i` - ignore case
    - `I` - case-sensitive
    - `n` - show number of matches
    - `p` -print matching lines


# Visual Mode
- `SHF-V` - select the whole line
- `C- V` - visual mode at character


# Working with Files
- `:pwd` - print working directory
- `:cd` - change working directory
- `:set autochdir` - automatically use current file directory as working directory
- `:e filename` - to edit a file
- `gf` - go to file, open the file that under the cursor


# Directory Listings
- `i` - thin, long, wide, or tree listings
- `s` - sort on name, time, or file size
- `r` - reverse sort order
- `gh` - hide or unhide dotfiles
- `<Enter>` - open the file or directory
- `o` - open in a new split
- `x` - view file with associated application
- `d` - make directory
- `D` - delete the file or directory
- `R` - rename the file or directory
- `-` - go up a directory


# Leader
- `\` - custom shortcut key, backslash by default


# Splits 
- `C-w, s` - horizontal split
- `C-w, v` - vertical split


## Closing Splits
- `C-w, c` - close window
- `C-w, q` - close split
- `C-w, o` - make current window the only one


## Cycling Between Splits
- `C-w, C-w` - cycle between splits clockwise
- `C-w, w` - cycle between splits, as above
- `C-w, W` - cycle between splits, counter clockwise
- `C-w, p` - previous window
- `C-w, t` - top left
- `C-w, b` - bottom right
- `C-w, j` - switch focus to the downward split, can also use `h k l`


## Move / Rotate Splits
- `C-w, J` - Move split one down, can also use `h k l`
- `C-w, r` - Rotate splits clockwise
- `C-w, R` - Rotate splits counter-clockwise
- `C-w, x` - Exchange the current window with the next one
- `C-w, T` - Moves the current split to a new tab


# Split with the X mode
- `:q` - closes split
- `:sp filename` - horizontal split
- `:vsp filename` or `:vs filename` - vertical split


# Tabs
- `:tabnew` - map to `<leader>tt`
- `:tabedit` - map to `<leader>te`
- `:tabclose` - map to`<leader>tc` 
- `:tabonly` - map to `<leader>to`
- `:tabnext` - map to `<leader>tn`
- `:tabprevious` - map to `<leader>tp` 
- `:tabfirst` - map to`<leader>tf` 
- `:tablast` - map to `<leader>tl`
- `:tabmove` - map to `<leader>tm`


# Buffers
- `:ls` - list all buffers
- `:b1` - switches to the first buffer, can be a different number
- `:bp` - switched to the previous buffer
- `:bn` - next buffer
- `:bp` - previous buffer
- `:bd` - delete buffer (close file)
- `:bf` - first buffer
- `:bl` - last buffer
- `:ba` - open a window for evey buffer - All
- `C-^` - switch to last buffer


# Terminal
- `C-z` - suspend Vim, `%vim` to go back
- `:! git status` - execute external commands from vim


# Folds
- `zM` - fold all
- `zc` - close fold
- `za` - toggle fold
- `zo` - open fold
- `zR` - open all folds
- `zk` - move up a fold
- `zj` - move down a fold


# Autocomplete
- `C-n` - Activate completion, or completion menu for multiple options


# Settings
- `:set nopaste` - turns off auto indentation and bracket matching for pasting
- `:set paste` - opposite of `:set nopaste`
- `:set copyindent` - can also work


# Document Wide Changes
- `:retab` - replace all tabs with spaces in the current buffer
- `ggVG=` - visually select the entire buffer, format the selection with =
- `gq` - reflow paragraph to 80 characters wide


# Documentation
- `:h a<tab>` - search and autocomplete help topic
- `C-t` - jump back
- `C-]` - open link
- `:helptags ~/.vim/doc` - import standard plugin docs
- `:call pathogen#helptags()` - import docs with the pathogen plugin system


# MacVim
- `brew install macvim` - to install from Homebrew
- `cp mvim /usr/local/bin` - to copy the mvim script to the path


# Plugins
- [X] [CtrlP](http://vimawesome.com/plugin/lustyexplorer)
- [X] [Surroung](http://vimawesome.com/plugin/surround-vim)
- [ ] [NerdTree](http://vimawesome.com/plugin/the-nerd-tree)
- [ ] [LustyExplorer](http://vimawesome.com/plugin/lustyexplorer)
- [ ] [NERD Commenter](http://vimawesome.com/plugin/the-nerd-commenter)
- [ ] [Buffer Explorer](http://vimawesome.com/plugin/bufexplorer-zip)
- [ ] [Vim-Snippets](http://vimawesome.com/plugin/vim-snippets)
- [ ] [Snipmate](http://vimawesome.com/plugin/vim-snipmate-mine)


## Tim Pope's Surround Plugin
- `cst` - change surround tag
- `dst` - delete surround tag
- `Vs` - add a tag around text
- `:h surround` - plugin documentation


## ctrlp.vim Plugin
- `<F5>` - purge the cache for the current directory to get new files
- `<c-f>` and `<c-b>` - to cycle between modes
- `<c-d>` - filename only search instead of full path
- `<c-r>` - regexp mode
- `<c-j>` and `<c-k`> or the arrows - to navigate the results list
- `<c-t>` or `<c-v>`, `<c-x>` - to open the selected entry in tab / split
- `<c-n>` and `<c-p>` - to select next / previous string in the prompt history
- `<c-y>` - create a new file and its parent directories
- `<c-z>` - to mark / unmark multiple files, `<c-o>` to open
- `..` - summit two or more dots to go up th edirectory tree
- `:25` - command to execute it on the opening files, jump to line 25

## NERDCommenter
- `[count]<leader>cc` - |ComComment| Comment out the current line or text selected in visual mode.
- `[count]<leader>cn` - |ComNestedComment| Same as <leader>cc but forces nesting.
- `[count]<leader>c` - |ComToggleComment| Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
- `[count]<leader>cm` - |NERDComMinimalComment| Comments the given lines using only one set of multipart delimiters.
- `[count]<leader>ci` - |NERDComInvertComment| Toggles the comment state of the selected line(s) individually.
- `[count]<leader>cs` - |NERDComSexyComment| Comments out the selected lines ``sexily''
- `[count]<leader>cy`- |NERDComYankComment| Same as <leader>cc except that the commented line(s) are yanked first.
- `<leader>c$` - |NERDComEOLComment| Comments the current line from the cursor to the end of line.
- `<leader>cA` - |NERDComAppendComment| Adds comment delimiters to the end of line and goes into insert mode between them.
- `|NERDComInsertComment|` -  Adds comment delimiters at the current cursor position and inserts between. Disabled by default.
- `<leader>ca` -  |NERDComAltDelim| Switches to the alternative set of delimiters.
- `[count]<leader>cl`
- `[count]<leader>cb |NERDComAlignedComment|` - Same as |NERDComComment| except that the delimiters are aligned down the left side (<leader>cl) or both sides (<leader>cb).
- `[count]<leader>cu |NERDComUncommentLine|`- Uncomments the selected line(s).