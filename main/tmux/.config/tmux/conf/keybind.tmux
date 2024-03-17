# hjkl pane traversal
# <prefix> + o: next pane
# <prefix> + ;: alternate last pane
# <prefix> + x: close pane
bind H select-pane -L
bind J select-pane -D
bind K select-pane -U
bind L select-pane -R

# Split windows vertically and horizontally
bind-key | split-window -h -c "#{pane_current_path}"
bind-key _ split-window -v -c "#{pane_current_path}" \; resize-pane -y 30%

# Reorganize windows easily
bind-key < swap-window -d -t -
bind-key > swap-window -d -t +

# # Sync panes
# bind C-s set-window-option synchronize-panes \; display-message "All Windows and Panes synced"

# Create a popup with all available sessions, ordered by utilization
bind S display-popup -E "\
    tmux list-sessions -F '#{?session_attached,,#{session_activity},#{session_name}}' |\
    sort -r |\
    sed '/^$/d' |\
    cut -d',' -f2- \|
    fzf --reverse --header jump-to-sessions --preview 'tmux list-windows -t {}'  |\
    xargs tmux switch-client -t"

# back on previous active session
# bind-key B run-shell "tmux list-sessions -F '#{?session_attached,,#{session_activity},#{session_name}}' | sort -r | awk -F, 'NR==1{print $2}' | xargs tmux switch-client -t"

# generate OTP for 2FA
bind-key a run-shell "$ZSH_UTILITIES/scripts/genotp.sh"

# in tmux copy mode enable selection and yank vim-like
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe

# Create a new named window
bind-key C run-shell "tmux display-popup -T 'Select new window:' -E $TMUX_SUBDIR/scripts/tmux_fzf.sh -C"

# open fzf to choose tmux window
bind-key F run-shell "tmux display-popup -T 'Switch windows:' -E $TMUX_SUBDIR/scripts/tmux_fzf.sh -F"
