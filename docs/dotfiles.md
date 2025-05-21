---
layout: default
---

# Dotfile Configurations

This section provides a detailed look into the various dotfile configurations managed within this repository. These configurations are essential for personalizing the development environment, streamlining workflows, and ensuring consistency across different tools and systems.

The `symlinks` script is used to manage these configurations by creating symbolic links from the repository to their appropriate locations in the user's home directory or other specified target directories.

## Configurations

### AI (`main/ai`)
This directory contains configurations related to Artificial Intelligence tools.
*   **`main/ai/.config/codestral`**: Configuration for Codestral, an AI coding assistant. (Further details about specific files would go here if known).

### Alacritty (`main/alacritty`)
Alacritty is a fast, cross-platform, OpenGL terminal emulator. Its configuration allows for extensive customization of appearance, key bindings, and performance.
*   **Key Files:**
    *   `main/alacritty/.config/alacritty/alacritty.toml`: The main configuration file for Alacritty, defining settings like font, colors, opacity, key bindings, and shell.
    *   `main/alacritty/.config/alacritty/themes/`: Contains various themes for Alacritty. The `catppuccin_mocha.toml` is likely one such theme.

### AWS (`main/aws`)
Configurations for interacting with Amazon Web Services (AWS).
*   **Key Files:**
    *   `main/aws/.aws/config`: Stores AWS CLI configuration profiles, including default region, output format, and SSO settings. This allows for managing multiple AWS accounts and roles seamlessly.

### Bat (`main/bat`)
Bat is a `cat(1)` clone with syntax highlighting and Git integration. It provides a more user-friendly way to view file contents in the terminal.
*   **Key Files:**
    *   `main/bat/.config/bat/config`: Bat's configuration file, which can be used to customize themes, add new syntaxes, or integrate with other tools.

### Docker (`main/docker`)
Configuration for Docker, a platform for developing, shipping, and running applications in containers.
*   **Key Files:**
    *   `main/docker/.docker/config.json`: Stores Docker client configuration, such as authentication details for registries, default settings for builds, and plugin configurations.

### GitHub CLI (`main/gh`)
Configurations for `gh`, the official GitHub command-line interface. This allows for interacting with GitHub repositories, issues, pull requests, and more directly from the terminal.
*   **Key Files:**
    *   `main/gh/.config/gh/config.yml`: Stores authentication tokens, preferred editor, and other default settings for `gh`.
    *   `main/gh/.config/gh/hosts.yml`: Manages authentication for different GitHub instances (e.g., github.com, GitHub Enterprise).

### Git (`main/git`)
Global Git configurations that define user identity, aliases, editor preferences, and other behaviors for version control.
*   **Key Files:**
    *   `main/git/.gitconfig`: The primary global Git configuration file. It includes user information (name, email), aliases for common commands, default editor, merge tool preferences, and more.
    *   `main/git/.gitconfig.personal`: Likely a supplementary Git configuration file, possibly for personal project overrides or specific settings not included in the main `.gitconfig`. This might be included in the main `.gitconfig` via an `[include]` directive.

### Neovim (`main/neovim`)
Neovim is a highly extensible, Vim-based text editor. This configuration is extensive, tailored for a productive development environment.
*   **For detailed Neovim setup, plugins, LSPs, and specific configurations, please see the [Neovim Configuration Documentation](./neovim.md).**
*   **Key Directory:**
    *   `main/neovim/.config/nvim/`: This directory contains all Neovim configuration files, including `init.lua` (or `init.vim`), plugin settings, LSP configurations, custom scripts, and themes.

### SSH (`main/ssh`)
Configurations for the Secure Shell (SSH) client, used for secure remote logins and file transfers.
*   **Key Files:**
    *   `main/ssh/.ssh/config`: Defines host-specific configurations, such as aliases for servers, usernames, identity files (private keys), port numbers, and other SSH options. This file is crucial for simplifying connections to frequently accessed remote machines.
    *   `main/ssh/.ssh/aws-ssm-ec2-proxy-command.sh`: A script likely used in conjunction with the SSH config to connect to EC2 instances via AWS Systems Manager Session Manager, enhancing security by avoiding the need for open inbound SSH ports.
    *   `main/ssh/.ssh/README.md`: Contains specific instructions or notes about the SSH setup, potentially covering key generation, agent forwarding, or usage of the proxy command. (Content from this README should be integrated here).

### Terraform (`main/terraform`)
Configuration for Terraform, an infrastructure as code (IaC) tool used to define and provision data center infrastructure using a declarative configuration language.
*   **Key Files:**
    *   `main/terraform/.tflint.hcl`: Configuration file for TFLint, a linter for Terraform code. It defines rules and settings to enforce best practices and catch errors in Terraform configurations.

### Tmux (`main/tmux`)
Tmux is a terminal multiplexer that allows users to manage multiple terminal sessions from a single window. It enables detaching and reattaching sessions, splitting windows into panes, and customizing status bars.
*   **Key Files:**
    *   `main/tmux/.config/tmux/tmux.conf`: The main configuration file for Tmux. It controls key bindings, appearance (status bar, colors), session behavior, and plugin management (e.g., via TPM - Tmux Plugin Manager).
    *   The `plugins/` subdirectory likely contains plugins managed by TPM.

### Zsh (`main/zsh`)
Zsh (Z shell) is a powerful and highly customizable shell. This configuration enhances its functionality with plugins, themes, aliases, and custom functions.
*   **Key Files:**
    *   `main/zsh/.zshenv`: Read on startup for all Zsh invocations (interactive or not). Typically used to set environment variables like `$PATH`.
    *   `main/zsh/.config/zsh/.zshrc`: The main configuration file for interactive Zsh sessions. It sources plugins, sets options, defines aliases and functions, and customizes the prompt.
    *   `main/zsh/.config/zsh/aliases/`: Directory likely containing files with alias definitions, possibly organized by topic.
    *   `main/zsh/.config/zsh/plugins/`: Could contain custom or manually installed plugins.
    *   `main/zsh/.config/zsh/themes/`: Contains themes, including the `powerlevel10k` configuration (`p10k.zsh`).

---
Properly managing these dotfiles ensures a tailored and efficient environment for both personal and professional tasks. Remember to use the `symlinks` script to install or update these configurations.
