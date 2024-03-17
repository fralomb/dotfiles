# # Set default shell
# set-option -g default-shell /opt/homebrew/bin/zsh

# History limit
set-option -g history-limit 100000

# Enable mouse support
setw -g mouse on

set-option -g focus-events on

# Enable colors on terminals
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",$TERM:RGB"

# Set parent terminal title to reflect current window in tmux session 
set -g set-titles on
set -g set-titles-string "[#S] - #I:#W"

# Enable vim mode
setw -g mode-keys vi

# remove Esc-Wait off so Vim works faster
set-option -sg escape-time 0

# start numbering of windows from 1
set -g base-index 1

# Renumber windows if others are closed
set -g renumber-windows on

# Extend display time
set-option -g display-time 2500

set-option -g default-command "exec /bin/zsh"

#  # highlight current active window
# set-window-option -g window-status-style none
# set-window-option -g window-status-current-style fg=default,bg=white,bold,italics,dim
#
# set-option -g message-style bg=default,fg=blue,bold
