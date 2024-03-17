#!/bin/bash

declare scriptname=$(basename $0)

print_usage() {
    echo "./$scriptname [--create-window | -C] [--find-window | -F]"
    echo "   * [--find-window | -F]: list existing tmux windows for current session"
    echo "   * [--create-window | -C]: create new window in current session"
}

declare -a ARGS
# read parameters
while [[ $# -gt 0 ]]; do
    case $1 in
        -C|--create-window)
            CREATE_WINDOW="true"
            shift # past argument
            ;;
        -F|--find-window)
            FIND_WINDOW="true"
            shift # past argument
            ;;
        -*|--*)
            echo "Unknown option $1"
                exit 1
            ;;
        *)
            ARGS+=("$1") # save positional arg
            shift # past argument
            ;;
    esac
done

set -- "${ARGS[@]}" # restore positional parameters

if [[ -n "$FIND_WINDOW" && -n "$CREATE_WINDOW" ]]; then
    echo "Only one option allowed"
fi

# list existing tmux windows for current session
if [[ -n "$FIND_WINDOW" ]]; then
    window=$(tmux list-windows -F "#{window_index}: #{window_name}" | fzf)
    IFS=': ' read -r -a arr <<< "$window"
    if [[ ${#arr[@]} -ne 0 ]]; then
        windex="${arr[0]}"
        tmux select-window -t "$windex"
    fi
fi

# create new window in current session, searching for window root working directory
if [[ -n "$CREATE_WINDOW" ]]; then
    start_dir=$(fd -t d . "$HOME" --max-depth 2 | fzf)
    # remove trailing / if defined
    start_dir_escaped=${start_dir%/}
    IFS='/' read -r -a arr <<< "$start_dir_escaped"
    if [[ ${#arr[@]} -ne 0 ]]; then
        arrlen=${#arr[@]}
        wname="${arr[arrlen-1]}"
        already_opened=$(tmux list-windows -F "#{window_index}: #{window_name}" | grep -w "${wname}$")

        IFS=': ' read -r -a wins <<< "$already_opened"
        if [[ ${#wins[@]} -ne 0 ]]; then
            windex="${wins[0]}"
            tmux select-window -t "$windex"
        else
            tmux new-window -c "$start_dir_escaped" -n "$wname"
        fi
    fi
fi
