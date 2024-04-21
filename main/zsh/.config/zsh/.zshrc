# zmodload zsh/zprof
# more options: man zshoptions - options are case insentive and underscores are ignored
# Manage history
export HISTSIZE="10000000"
export SAVEHIST="10000000"
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE="$ZSH_MAINDIR/.zsh_history"
setopt inc_append_history
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
# setopt share_history
setopt append_history
setopt nomatch
setopt menu_complete
setopt interactive_comments

unsetopt beep

# completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit -d "$ZSH_MAINDIR/.zcompdump"
zstyle ':completion:*' menu select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.


# import all utility functions
for config_file ("$ZDOTDIR"/lib/*.zsh); do
  [[ -f "$config_file" ]] && source "$config_file"
done

# add plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions" "$ZSH_MAINDIR"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting" "$ZSH_MAINDIR"
zsh_add_plugin "jonmosco/kube-ps1" "$ZSH_MAINDIR"
# zsh_add_plugin "unixorn/fzf-zsh-plugin" "$ZSH_MAINDIR"

# needs zsh to be installed through brew!
zsh_add_plugin "fralomb/pure" "$ZSH_MAINDIR" "async.zsh"
fpath+=($ZSH_MAINDIR/plugins/pure)

# source other configurations
zsh_add_file "config/prompt.zsh"
zsh_add_file "config/aliases.zsh"
zsh_add_file "config/key-bindings.zsh"
zsh_add_file "config/krew.zsh"
# install useful key bindings and fuzzy completion
# $(brew --prefix)/opt/fzf/install --bin


# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# enable autocompletion for aws
complete -C '/usr/local/bin/aws_completer' aws

# enable autocompletion for helm
source <(helm completion zsh)

# enable autocompletion for kubectl
source <(kubectl completion zsh)

# source work utility scripts
source $ZSH_UTILITIES/.utils

# ensure jdtls is installed
zsh_add_file "config/jdtls-config.zsh"
zsh_add_file "config/fzf.zsh"

# add GOBIN directory to path
golangbin="$(go env GOPATH)/bin"
export PATH=$PATH:$golangbin
