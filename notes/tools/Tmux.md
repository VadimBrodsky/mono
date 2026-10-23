## Tmux

### Sessions

Create a new named session
```shell
tmux new-session -s session_name
tmux new -s session_name
tmux new -s background_session -d
```

Listing sessions
```shell
tmux list-sessions
tmux ls
```

Attaching to a session
```shell
tmux attach
tmux a
tmux attach -t session_name
```

Killing sessions
```shell
tmux kill-session -t session_name
```


### Windows
New session with named window
```shell
tmux new -s session_session -n window_name

# command mode
new-window -n window_name
new-window -n processes "htop"  # initial command for the window
```


### Copy Mode

```bash
tmux capture-pane
tmux show-buffer
tmux save-buffer buffer.txt

tmux capture-pane && tmux save-buffer buffer.txt

# command mode
capture-pane; save-buffer buffer.txt
list-buffers
choose-buffer
```

```
h/j/k/l - cursor movement
Enter - exit copy mode
w/b   - jump by words
f/F   - find forward and back
C-b   - down one page full
C-f   - up one page full
g     - top of buffer history
G     - bottom of buffer history
?     - search backward through the buffer
/     - seach forward through the buffer
n/N   - jump to next or previous search result
Space - start copy select, Enter to finish
```


### Prefix commands
```
# Windows
<P> d - detach from session
<P> c - create new window
<P> , - rename window
<P> n - next window
<P> p - previous window
<P> 1 - jump to window 1 (0..9)
<P> f - find window by name
<P> w - select window from list
<P> & - kill window with confirmation

# Panes
<P> % - split window vertically
<P> " - split window horizontally
<P> o - cycle through the panes
<P> up / down / left / right - to move around the panes
<P> space - cycle through pane layouts
<p> x - kill pane with confirmation

<P> : - enter command mode
<P> ? - list of predefined tmux keybindings

# Copy Mode
<P> [ - enter copy mode
<P> ] - pase copied text
<P> = - lists all paste buffers and pastes selected buffer
<P> : - capture-pane, copies everything that is visible
```


### Sample Configuration

```conf
# TMUX Configuration
# ==============================================
# set-option / set - set an option
# unbind-key / unbind - unbinds a key binding 
# setw / set-window-option - set window specific option

# -g flag - sets the option to global
# \; user to separate a series of commands

# to reload tmux configuration
# :source-file ~/.tmux.conf


# Global Settings
# ==============================================

# Set the tmux prefix to C-a
set -g prefix C-a
unbind C-b

# Decrease the escape time, better for Vim
set -sg escape-time 1

# Change window numbering
set -g base-index 1
setw -g pane-base-index 1

# Set Vim style keybindings for copy mode
setw -g mode-keys vi

# Enable mouse interaction with tmux
# setw -g mode-mouse off
setw -g mode-mouse on
set -g mouse-select-pane on
set -g mouse-resize-pane on
set -g mouse-select-window on

# Monitor activity in other windows
set -g visual-activity on
setw -g monitor-activity on


# Custom Keybindings
# ==============================================
# bind - to bind new keys
# -n flag - bind without the prefix
# -r flag - key binding may repeat

# reload configuration
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# send C-a instead of prefix when pressed twice
bind C-a send-prefix

# window splits
bind | split-window -h
bind - split-window -v

# setting window movement to hjkl
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# cycle through windows
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# resize panes
bind H resize-pane -L 5
bind J resize-pane -D 5
bind K resize-pane -U 5
bind L resize-pane -R 5

# copy mode
unbind [
bind Escape copy-mode
unbind p
bind p paste-buffer
bind -t vi-copy 'v' begin-selection
bind -t vi-copy 'y' copy-selection

# integrate with xclip on linux
# bind C-c run "tmux save-buffer - | xclip -i -sel clipboard"
# bind C-v run "tmux set-buffer \"$(xclip -o -sel clipboard)\"; tmux paste-buffer"

# integrate with pbcopy on osx
# set -g default-command "reattach-to-user-namespace -l /bin/bash"
# bind C-c run "tmux save-buffer - | reattach-to-user-namespace pbcopy"
# bind C-v run "tmux set-buffer $(reattach-to-user-namespace pbpaste); tmux paste-buffer"

# Visual
# ==============================================
# tmux supports: black, red, green, yellow, blue,
# magenta, cyan, white, color0 - color255

# use all 256 colors
set -g default-terminal "screen-256color"

# change the colors of the status line
set -g status-fg white
set -g status-bg black

# change the colors of the window list
setw -g window-status-fg cyan
setw -g window-status-bg default
setw -g window-status-attr dim

setw -g window-status-current-fg white
setw -g window-status-current-bg red
setw -g window-status-current-attr bright

# change color of pane border
set -g pane-border-fg green
set -g pane-border-bg black
set -g pane-active-border-fg white
set -g pane-active-border-bg yellow

# change color of the tmux command line
set -g message-fg white
set -g message-bg black
set -g message-attr bright

# change the contents of the status line
# utf8 for special characters
set -g status-utf8 on

# refresh the status line every 60 seconds, default is 15
set -g status-interval 60

# left side
set -g status-left-length 40
set -g status-left "#[fg=green]Session: #S #[fg=yellow]#I #[fg=cyan]#P "

# right side
# can use any strftime formatting for the date
set -g status-right "#[fg=cyan]%d %b %R"

# window list
set -g status-justify centre

```


### Status Line Variables

```
#H - hostname of local host
#h - hostname of local host without the domain name
#F - current window flag
#I - current window index
#P - current pane index
#S - current session name
#T - current window title
#W - current window name
## - literal #
#(shell-command) - first line of the shell commands output
#[attributes] - color or attribute change
```


### Sample Tmux Script

```
tmux has-session -t development
if [ $? != 0 ]
then
  # create new development session
  # create editor window
  # detach from session
  tmux new-session -s development -n editor -d

  # open the development folder
  # C-m is carriage return
  tmux send-keys -t development 'cd ~/code' C-m

  # open vim in that folder
  tmux send-keys -t development 'vim' C-m

  # split the window vertically
  # tmux split-window -v -t development
  # specify a percentage for the split
  tmux split-window -v -p 10 -t development

  # change layout to one of built-ins
  tmux select-layout main-horizontal -t development

  # target window 1 split 2
  tmux send-keys -t development:1.2 'cd ~/code' C-m

  # create new window
  tmux new-window -n console -t development

  # cd into the right folder
  tmux send-keys -t development:2 'cd ~/code' C-m

  # select the first window
  tmux select-window -t development:1

  # attach
  tmux attach -t development
fi

tmux attach -t development
```

