# Dotfiles Management

**For detailed documentation, please visit our [GitHub Pages site](https://YOUR_GITHUB_USERNAME.github.io/YOUR_REPOSITORY_NAME/).**
Please replace `YOUR_GITHUB_USERNAME` and `YOUR_REPOSITORY_NAME` with your actual GitHub username and repository name.

This repository contains a collection of personal and work dotfiles, configurations for npm packages, Brew-installed tools, and a script for managing symlinks.

## Core Components

*   **Dotfiles:** Personal (`main/`) and work-related (`other/`) configurations for various tools including Zsh, Neovim, Git, Alacritty, Tmux, and more.
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
For more detailed instructions on the `symlinks` script, dotfile configurations, Homebrew packages, NPM dependencies, and Neovim setup, please refer to the [full documentation site](https://YOUR_GITHUB_USERNAME.github.io/YOUR_REPOSITORY_NAME/).
Please replace `YOUR_GITHUB_USERNAME` and `YOUR_REPOSITORY_NAME` with your actual GitHub username and repository name.

## Repository Structure Overview

*   `docs/`: Contains all detailed documentation for the GitHub Pages site.
*   `main/`: Personal dotfile configurations.
    *   `ai/`, `alacritty/`, `aws/`, `bat/`, `docker/`, `gh/`, `git/`, `neovim/`, `ssh/`, `terraform/`, `tmux/`, `zsh/`
*   `other/`: Work-specific dotfile configurations.
    *   `gh/`, `git/`, `saml/`, `zsh/`
*   `theme/`: Terminal themes.
*   `Brewfile`: Homebrew package list.
*   `package.json`: NPM dependency list.
*   `symlinks`: The symlink management script.

---
This `README.md` provides a brief overview. For comprehensive information, please visit the [documentation site](https://YOUR_GITHUB_USERNAME.github.io/YOUR_REPOSITORY_NAME/).
Please replace `YOUR_GITHUB_USERNAME` and `YOUR_REPOSITORY_NAME` with your actual GitHub username and repository name.
