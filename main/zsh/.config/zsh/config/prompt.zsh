#!/bin/sh

# kubernetes prompt on the right
function get_cluster() {
    # echo "$1"
    local aws_account=$(echo "$1" | cut -d : -f5)
    local clustername=$(echo "$1" | cut -d / -f2)
    echo "($aws_account) $clustername"
}
function get_cluster_namespace() {
    # echo "$1" | tr '[:lower:]' '[:upper:]'
    echo "$1"
}

export KUBE_PS1_LABEL_USE_IMG=true
export KUBE_PS1_SYMBOL_PADDING=true
export KUBE_PS1_CLUSTER_FUNCTION=get_cluster
export KUBE_PS1_NAMESPACE_FUNCTION=get_cluster_namespace
# disabling kube_ps1 by default
kubeoff

RPROMPT='$(kube_ps1)'

# Using custom pure for left prompt
autoload -U promptinit; promptinit

# Showing git stash status
zstyle :prompt:pure:git:stash show yes

prompt pure
