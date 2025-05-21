# Dotfiles Management

This repository contains a collection of personal and work dotfiles, configurations for npm packages, Brew-installed tools, and a script for managing symlinks.

## Core Components

*   **Dotfiles:** Configurations for various tools including Zsh, Neovim, Git, Alacritty, Tmux, and more.
*   **`symlinks` Script:** A utility script leveraging `stow` to manage the symlinking of these dotfiles into their correct locations.
*   **`Brewfile`:** Manages macOS application and tool installations via Homebrew.
*   **`package.json`:** Lists Node.js dependencies, primarily for Neovim LSP support and other development utilities.
*   **Themes:** Includes color schemes like Rose Pine for iTerm2.

## Quick Start with `symlinks` Script

The `symlinks` script is used to install or uninstall dotfile packages.

### Basic Usage:
```bash
# Install a personal Zsh configuration
./symlinks -i main/zsh

# Uninstall a work-specific Git configuration
./symlinks -u other/git

# Install a package to a custom target directory
./symlinks -i -t ~/.config/other_configs other/specific_tool
```

---
This `README.md` provides a brief overview. For comprehensive information, please visit the [documentation site](https://fralomb.github.io/dotfiles/).
