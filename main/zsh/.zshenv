export ENVSPATH="$HOME/.environments"

export EDITOR="nvim"
# export TERM="alacritty"
# export TERM="xterm-256color"
# export TERMINAL="kitty"

export NVIM_MAINDIR="$ENVSPATH/.neovim"
export ZSH_MAINDIR="$ENVSPATH/.zsh"
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_UTILITIES="$HOME/.config/utilities"
export TMUX_MAINDIR="$ENVSPATH/.tmux"
export TMUX_CONFIGDIR="$HOME/.config/tmux"
export BAT_CONFIG_PATH="$HOME/.config/bat"


usrlocalbin="/usr/local/bin"
localbin="$HOME/.local/bin"
pip_venv="$HOME/.local/pip/bin"
export PATH=$PATH:$pip_venv:$localbin:$usrlocalbin
source "$HOME/.cargo/env"
