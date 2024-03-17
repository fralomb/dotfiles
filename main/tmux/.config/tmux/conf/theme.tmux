# Rose-pine color palette
thm_base="#191724";
thm_surface="#1f1d2e";
thm_overlay="#26233a";
thm_muted="#6e6a86";
thm_subtle="#908caa";
thm_text="#e0def4";
thm_love="#eb6f92";
thm_gold="#f6c177";
thm_rose="#ebbcba";
thm_pine="#31748f";
thm_foam="#9ccfd8";
thm_iris="#c4a7e7";
thm_hl_low="#21202e";
thm_hl_med="#403d52";
thm_hl_high="#524f67";

# Icons
nf_md_timelapse="󰔚"
nf_oct_zoom_in=""
nf_oct_terminal=""
nf_oct_terminal_hover=""
nf_md_dots_vertical="󰇙"
nf_md_selection_multiple="󱊅"


source "$TMUX_SUBDIR/plugins/mode_indicator.tmux"
source "$TMUX_SUBDIR/plugins/online_status.tmux"

set -g status on
set -g status-justify centre
set -g status-position bottom
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-style "fg=$thm_pine,bg=$thm_base"

# set -g window-style ""
# set -g window-active-style ""

# messages
set -g message-style "fg=$thm_foam,bg=$thm_base"
set -g message-command-style "fg=$thm_base,bg=$thm_pine"

# tmux integrated modes
setw -g clock-mode-colour "${thm_love}"
# setw -g mode-style "fg=${thm_gold}"

# windows
set -g window-status-current-format "#[fg=$thm_love,bg=$thm_base,bold]  #{nf_oct_terminal} #I #W #{?window_last_flag,,} #{?window_zoomed_flag,#{nf_oct_zoom_in},} "
set -g window-status-format "#[fg=$thm_muted,bg=$thm_base,nobold]  #{nf_oct_terminal} #I #W #{?window_last_flag,#{nf_md_timelapse},} #{?window_zoomed_flag,,} "
setw -g window-status-separator " "

# panes
set -g pane-border-style "fg=$thm_hl_high"
set -g pane-active-border-style "fg=$thm_pine"
set -g display-panes-active-colour "${thm_text}"
set -g display-panes-colour "${thm_pine}"

# status bar left and right
set -g status-right "#[fg=$thm_text,bg=$thm_base]  %Y-%m-%d ❬ %H:%M #{nf_md_dots_vertical} #{online_status}"
set -g status-left "#[fg=$thm_base,bg=$thm_pine,bold] #{nf_md_selection_multiple} #S  #{tmux_mode_indicator}"

