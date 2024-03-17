alias grep="grep --color=auto"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias k="kubectl"
# alias terraform="docker run --rm -it --platform linux/amd64 -v '$(pwd -P)/infrastructure/terraform:/data' -v "~/.terraformrc":/root/.terraformrc --workdir='/data' hashicorp/terraform"
# alias terraform_exec="docker run --rm -it --entrypoint="" --platform linux/amd64 -v '$(pwd -P)/infrastructure/terraform:/data' -v "~/.terraformrc":/root/.terraformrc --workdir='/data' hashicorp/terraform /bin/sh"

# find_dir_and_cd() {
#   local dir
#   dir=$(fd -t d ${1:-.} | fzf-tmux -d 40)
#   cd "$dir"
# }
# alias fd="find_dir_and_cd"
