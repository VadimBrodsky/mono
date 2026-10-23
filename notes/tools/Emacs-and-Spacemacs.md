## Spacemacs Specifics
- `<SPC> f f` - Find file, use `<Tab>` to autocomplete.
- `<SPC> b b` - Buffer switch, type the buffer name.
- `<SPC> :` - Run Emacs functions, same as `M-x`.
- `<SPC> h d f` - Help Define Function, defines the function that can be run with `M-x`.
- `<SPC> w /` - Split the window vertically.
- `<SPC> w -` - Split the window horizontally.
- `<SPC> 0`...`<SPC> 9` - Switch between windows, or use `<SPC> w j` where j is the direction.


## General Commands
- `C-x C-c` Exit Emacs
- `C-g` Quit partially entered command
- `C-z` - Suspend Emacs, returns to command line, `fg` or `%emacs` to return back
  (**Spacemacs**: `C-z` has been rebound, use `C-x C-z` instead)
- `<ESC> <ESC> <ESC>` - get out of recursive editing level etc.


## Help
- `C-h <character` - to get help about a specific subject
- `C-h ?` - To get Emacs' generic help
- `C-h c C-p` - Mini help about the `C-p` function
- `C-h k C-P` - Full documentation for the`C-p` function
- `C-h f` - Find a function by describing it
- `C-h v` - displays the documentation about variables
- `C-h a` - Find documentation using keyword, command apropos
- `C-h i` - Opens Emacs manuals


## Screen Movement
- `C-v` View next screen (**Spacemacs**: <kp-next>)
- `M-v` View previous screen 
- `C-l` Center the cursor and text to middle of the screen 
- `C-l C-l` Move text and cursor to top of the screen 
- `C-l C-l C-l` Move text and cursor to bottom of the screen 
- `M-<` Beginning of the document
- `M->` End of the document


## Modifier
- `C-u` `8` `C-f` - Move forward 8 characters
- `C-u` `8` `C-v` - Move down 8 lines
- `C-u` `5` `*` - Inserts `*****`
 

## Cursor Movement
- `C-f` Forward one character  (**Spacemacs**: Use vim bindings)
- `C-b` Backwards one character (**Spacemacs**: Use vim bindings)
- `C-p` Previous line (**Spacemacs**: Use vim bindings)
- `C-n` Next line (**Spacemacs**: Use vim bindings)


## Word Movement
- `M-f` Forward one word 
- `M-b` Backward one word 
  - When cursor is in the middle of the word
  - When cursor is in the white space it skips the word


## Line Movement
- `C-a` Beginning of the line 
- `M-a` Beginning of the sentence 
- `C-e` End of the line (**Spacemacs**: Use vim bindings)
- `M-e` End of the sentence 


## Deleting
- `<DEL>` - Delete a character before the cursor
- `C-d` - Delete a character after the cursor (**Spacemacs**: Use vim binding)
- `M-<DEL>` - Kill the word before the cursor
- `M-d` - Kill the word after the cursor
- `C-k` - Kill all from cursor position to end of line
- `M-k` - Kill all from cursor position to end of sentence
- `C-<SPC>` `M-e` `C-w` - Kill all text in the selection (**Spacemacs**: C-w was rebound)


## Yanking
- `C-y` - Yanks / pasted the killed text (**Spacemacs**: C-y was rebound)
- `C-m` - Yanks the previous killed text
- `M-x` `replace-string` `foo` `bar` - replaces the string foo with bar in the text following the cursor

## Undo
- `C-/` - Undo command
- `C-_` - Undo command
- `C-x u` - Undo command (**Spacemacs**: `C-x u` was rebound, use `C-_` instead)


## Files
- `C-x C-f  Find a file` - Open a file
- `C-x C-s` - Save the file
- `M-x recover-file` - Recovers an autosaved version of the file after a crash

## Buffers
- `C-x 1` - Kill all other windows (**Spacemacs**: Use <SPC> f menu instead)
- `C-x C-b` - List all buffers
- `C-x b buffer_name` - Switch to a different buffer
- `C-x s` - Save some buffers


## Windows
- `C-x 2` - Split the current buffer into 2
- `C-x o` - To move the cursor to the other window
- `C-M-v` - Scroll down the other window
- `C-x 4 C-f` - Open a file in a split


## Frames
- `M-x make-frame` - Creates a new frame
- `M-x delete-frame` - Removes the selected frame


## Extend Commands
- `C-x` - Character extend, followed by one character
- `M-x` - Named command extend, followed by a long name


## Switching Modes
- `M-x fundametal-mode` - Switches to the fundamental major mode
- `M-x text-mode` - Switches to text major mode
- `C-x m` - Get documentation about the current mode
- `C-x auto-fill-mode` - Activates the auto-fill minor mode
- `C-u 2 0 C-x f` - Changes the auto-fill line to 20
- `M-q` - Auto-fill will re-fill a previosuly set paraghraph if initiated inside the paragraph


## Searching
- `C-s` - Forward search, additional `C-s` will go to next result `<DEL>` will go back
- `C-r` - Reverse search