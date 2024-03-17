# Function to source files if they exist
function zsh_add_file() {
    declare root_dir="${2:-$ZDOTDIR}"
    [ -f "$root_dir/$1" ] && source "$root_dir/$1"
}

# Function to clone and source plugin files
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    declare root_dir="${2:-$ZDOTDIR}"
    declare source_before="$3"
    if [ ! -d "$root_dir/plugins/$PLUGIN_NAME" ]; then
        git clone --depth 1 "https://github.com/$1.git" "$root_dir/plugins/$PLUGIN_NAME"
    fi
    if [ -d "$root_dir/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        [ -n "$source_before" ] && zsh_add_file "plugins/$PLUGIN_NAME/$source_before" "$root_dir"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" "$root_dir" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh" "$root_dir" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.sh" "$root_dir"
    fi
}

function zsh_add_completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For completions
        completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        fpath+="$(dirname "${completion_file_path}")"
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
        fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
    fi
    completion_file="$(basename "${completion_file_path}")"
    if [ "$2" = true ] && compinit "${completion_file:1}"
}

function mach_java_mode() {
    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}
