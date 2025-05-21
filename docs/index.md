# Welcome to Dotfiles Management Documentation

This site provides a comprehensive guide to the collection of dotfiles, configurations for npm packages, Brew-installed tools, and the script for managing symlinks contained in this repository.

## Overview

The repository is structured to manage different types of configurations:
- **Dotfiles:** Configurations for various tools. [Read more about dotfiles](./dotfiles.md)
- **Symlink Management:** A script (`symlinks`) to create and manage symbolic links for these dotfiles. [Learn about the symlink script](./symlink-script.md)
- **Homebrew Packages:** A `Brewfile` to manage macOS packages installed via Homebrew. [See Homebrew package details](./brew.md)
- **NPM Packages:** A `package.json` for project-specific Node.js dependencies. [Explore NPM packages](./npm.md)
- **Themes:** Color schemes for terminal emulators.

## `symlinks` Script

The `symlinks` script manages all the dotfiles contained in this repo by means of the **stow** command.
It allows for easy installation and uninstallation of configuration packages.
[Learn more about the `symlinks` script and its usage](./symlink-script.md)

## Dotfile Configurations

This repository includes a variety of dotfiles for system customization and development. These are separated into personal (`main/`) and work-specific (`other/`) categories.

### Configurations
These are personal configurations located in the `main/` directory.

*   `alacritty`: Configuration for Alacritty, a fast, cross-platform terminal emulator.
*   `aws`: Configuration for AWS CLI, providing credentials and default settings.
*   `bat`: Configuration for Bat, a cat(1) clone with syntax highlighting and Git integration.
*   `docker`: Configuration for Docker, a platform for developing, shipping, and running applications in containers.
*   `gh`: Configuration for GitHub CLI, allowing command-line interaction with GitHub.
*   `git`: Global Git configuration, including aliases and user settings.
*   `neovim`: Extensive configuration for Neovim, a highly extensible text editor. [View full Neovim Setup and Configuration](./neovim.md)
*   `ssh`: SSH client configuration, including host aliases and key settings.
*   `terraform`: Configuration for Terraform, an infrastructure as code tool.
*   `tmux`: Configuration for tmux, a terminal multiplexer.
*   `zsh`: Configuration for Zsh, a powerful shell with advanced features.

[Read more about dotfile configurations](./dotfiles.md)

## Homebrew Packages

The `Brewfile` lists macOS packages installed via Homebrew. This allows for easy setup and replication of the development environment.
[See Homebrew package details and management commands](./brew.md)

## NPM Packages

The `package.json` lists project-specific Node.js package dependencies, primarily for enhancing Neovim's capabilities.
[Explore NPM packages used in this project](./npm.md)

## Themes

*   **iTerm2:** Rose Pine theme located at `theme/rosepine/iterm2/rosepine.itermcolors`.

## Neovim Configuration Details
The detailed Neovim setup, including plugin management, LSPs, and specific configurations, has been moved.
[View full Neovim Setup and Configuration](./neovim.md)

---
