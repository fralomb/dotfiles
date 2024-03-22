# dotfiles
Collection of all my configuration files

## Installation
The `symlinks` script manages all the dotfiles contained in this repo by means of the **stow** command.

It will create / remove a symlink for each specified **package**, a collection of files and directories that you wish to administer as a unit and that needs to be installed in a particular directory structure (starting from a **target folder**).

One or more packages will __appear__ to be installed in a **target directory**, the root tree in which the symlinks will be created.

It is possible to ignore some files or directories passing it as a parameter through the `--ignore` option.
Also, inside a package directory it can be defined a `.target` file, containing a path to a target file that differs from the current folder structure.

Usage:
```
  ./symlinks [--install | -i] [--uninstall | -u] [--recursive | -r] [--target | -t] <TARGET_VALUE> FOLDER
```
Explanation:
* [--install | -i]: will create symlinks to TARGET folder
* [--uninstall | -u]: will remove previously created symlinks from TARGET folder (if any)
* [--target | -t] TARGET_VALUE: the target folder (default: $HOME)
* [--recursive | -r]: will iterate through dirs inside FOLDER (the stow package) and stow all the content
* [--help | -h]: show the helper menu
* FOLDER: the source folder to use to create/delete the symlink

### Neovim
#### build prerequisites
[neovim prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites)

#### remove everything about nvim
- rm -rf ~/.environment/.neovim
- rm -rf ~/.config/nvim
- rm -rf ~/.local/share/nvim

#### plugin dependencies
`nerd-fonts`: install patched fonts from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
on macos:
```
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```
> [!warning]
> make sure the patched font is used by the terminal

#### neovim plugins
- `mason` needs:
  - `wget`
  - `curl https://sh.rustup.rs -sSf | sh` installs `cargo` and `rust`
- `vim-cmp`: Follow configuration here: [doc](https://github.com/hrsh7th/nvim-cmp)
- `Telescope`: as a dependencies install `ripgrep`
- `Harpoon`: [doc](https://github.com/ThePrimeagen/harpoon)

#### neovim LSPs
- c compiler: `sudo apt-get install build-essential`
- bashls depends on `brew install shellcheck` for linting
- bash
  - install npm before `sudo apt-get install nodejs`
  - `npm i -g bash-language-server`
- python
  - [doc](https://github.com/palantir/python-language-server)
- Java
  - `https://github.com/mfussenegger/nvim-jdtls`
  - `https://github.com/eclipse/eclipse.jdt.ls#installation`
  - `https://github.com/mfussenegger/nvim-dap`
  - `https://github.com/microsoft/vscode-java-test`
  - `apt-get install -y maven`
  - `apt-get install -y openjdk-8-jdk`
- Python
  - flake8 for diagnostic `pip install flake8`
  - autopep8 for formatting `pip install autopep8`
  - install `pip3 install pynvim` that implements support for python plugins in Nvim
- HURL
  - test curl request easily: https://hurl.dev
- gopls
 - installation through `go install golang.org/x/tools/gopls@latest`
- HTML/CSS
  - Emmet toolkit for html, css and javascript development
  - `https://github.com/mattn/emmet-vim`
  - `https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL`
- terraform:
  - `brew install hashicorp/tap/terraform-ls`
  - [doc](https://github.com/hashicorp/terraform-ls)
- packer: `brew tap hashicorp/tap && brew install hashicorp/tap/packer`
- htmx: `cargo install htmx-lsp` - documentation [here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#htmx)

### Brewfile
Contains all the macOs packages installed via homebrew. Documentation [here](https://github.com/Homebrew/homebrew-bundle).
- To install all dependencies run `brew bundle install --verbose --file Brewfile` command.
- To get all the installed packages run `brew bundle dump --file=Brewfile` command.
- To uninstall all formulae not listed in the Brewfile run `brew bundle cleanup --force` command.
- To check if there is anything to install or upgrade in the Brewfile run `brew bundle check` command.
- To output the list of all entries in the Brewfile run `brew bundle list --all` command.

### Other dependencies
- ZSH: [doc](https://wiki.archlinux.org/title/zsh#History_search)
- fzf: [doc](https://github.com/unixorn/fzf-zsh-plugin)
- watch: `brew install watch`
- oathtool: `brew install oath-toolkit`

### Github Copilot
Documentation [here](https://github.com/github/copilot.vim?tab=readme-ov-file)
