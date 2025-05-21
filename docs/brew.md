# Homebrew Packages and Setup

This document details the macOS packages managed via the `Brewfile` in this repository. Homebrew is a package manager for macOS that simplifies the installation and management of software. Using a `Brewfile` allows for easy setup and replication of the development environment across multiple Macs.

## Managing Brewfile

The `Brewfile` is located at the root of the repository. Here are the common commands for managing packages with it:

*   **Install all dependencies:**
    ```bash
    brew bundle install --verbose --file Brewfile
    ```
    This command reads the `Brewfile` and installs all listed formulae (command-line tools) and casks (GUI applications).

*   **Update Brewfile with currently installed packages:**
    ```bash
    brew bundle dump --file=Brewfile --force
    ```
    This command will overwrite the existing `Brewfile` with a list of all currently installed Homebrew packages. Use `--force` to overwrite.

*   **Uninstall formulae not listed in the Brewfile:**
    ```bash
    brew bundle cleanup --force
    ```
    This command will remove any installed packages that are not present in the `Brewfile`. Use with caution.

*   **Check for missing or outdated packages:**
    ```bash
    brew bundle check
    ```
    This command checks if all packages listed in the `Brewfile` are installed and up-to-date.

*   **List all entries in the Brewfile:**
    ```bash
    brew bundle list --all
    ```
    This command outputs a list of all packages specified in the `Brewfile`.

## Installed Packages

The following packages are managed by the `Brewfile`, grouped by their purpose:

### Terminal Icons & Fonts
These packages provide fonts that include a wide range of icons, often used in terminal applications and text editors like Neovim.
*   **`homebrew/cask-fonts` (Tap):** A repository of fonts for Homebrew.
*   **`font-hack-nerd-font` (Cask):** A patched version of the Hack font with Nerd Fonts glyphs, providing numerous icons.

### Development Tools
Core tools for software development.
*   **`neovim`:** A highly extensible, Vim-based text editor, optimized for speed and flexibility. (See [Neovim Configuration](./neovim.md))
*   **`stow`:** GNU Stow, a symlink farm manager used by the `symlinks` script to manage dotfiles.
*   **`tmux`:** A terminal multiplexer, allowing multiple terminal sessions to be accessed from a single window.
*   **`watch`:** Executes a program periodically, showing its output and/or highlighting changes.
*   **`wget`:** A free utility for non-interactive download of files from the web.
*   **`nmap`:** A powerful network exploration tool and security/port scanner.
*   **`zsh`:** A powerful shell with more features than bash. (See [Zsh Configuration](./dotfiles.md#zsh-mainzsh))
*   **`hurl`:** A command-line tool that runs HTTP requests defined in a simple plain text format.
*   **`podman`:** A daemonless container engine for developing, managing, and running OCI Containers on your Linux System. (Alternative to Docker Desktop)
*   **`python@3.11`:** Specific version of Python 3.11.
*   **`python@3.10`:** Specific version of Python 3.10.
*   **`virtualenv`:** A tool to create isolated Python environments.
*   **`go`:** The Go programming language.
*   **`node`:** Node.js, a JavaScript runtime built on Chrome's V8 JavaScript engine.
*   **`testssl`:** A command-line tool to check a server's TLS/SSL configuration.

### AWS (Amazon Web Services)
Tools for interacting with AWS.
*   **`session-manager-plugin` (Cask):** An AWS CLI plugin to start and end sessions that connect you to your instances.
*   **`awscli`:** The official Amazon Web Services command-line interface.
*   **`weaveworks/tap/eksctl` (Tap & Formula):** A simple CLI tool for creating and managing clusters on EKS (Amazon's managed Kubernetes service).

### Pulumi
Tools for the Pulumi infrastructure as code platform.
*   **`pulumi/tap/pulumi` (Tap & Formula):** The Pulumi CLI, for creating, deploying, and managing cloud infrastructure.

### HashiCorp
Tools from HashiCorp for infrastructure automation.
*   **`hashicorp/tap` (Tap):** HashiCorp's official Homebrew tap.
*   **`hashicorp/tap/packer`:** Packer, a tool for creating identical machine images for multiple platforms from a single source configuration.
*   **`hashicorp/tap/terraform`:** Terraform, an infrastructure as code tool for building, changing, and versioning infrastructure safely and efficiently.
*   **`terraform-docs`:** A utility to generate documentation from Terraform modules in various output formats.

### Search and File Management
Utilities for efficient file searching, viewing, and manipulation.
*   **`bat`:** A `cat(1)` clone with syntax highlighting and Git integration.
*   **`fd`:** A simple, fast and user-friendly alternative to `find`.
*   **`fzf`:** A command-line fuzzy finder.
*   **`ripgrep`:** A line-oriented search tool that recursively searches the current directory for a regex pattern.
*   **`jinja2-cli`:** A command-line interface for Jinja2, a templating engine for Python.
*   **`jq`:** A lightweight and flexible command-line JSON processor.
*   **`catimg`:** A tool to display images in the terminal.
*   **`tree`:** Displays directory listings in a tree-like format.
*   **`yq`:** A lightweight and portable command-line YAML, JSON, and XML processor.

### Git
Tools and utilities for enhancing the Git workflow.
*   **`gh`:** GitHub's official command-line tool.
*   **`git-filter-repo`:** A versatile tool for rewriting Git repository history.
*   **`gitleaks`:** A SAST tool for detecting and preventing hardcoded secrets like passwords, API keys, and tokens in git repos.
*   **`pre-commit`:** A framework for managing and maintaining multi-language pre-commit hooks.
*   **`git-crypt`:** Enables transparent file encryption in git.

### OTP (One-Time Passwords)
Tools for generating one-time passwords.
*   **`oath-toolkit`:** A toolkit for implementing OATH (Initiative for Open Authentication) standards, including HOTP and TOTP.

### Kubernetes
Tools for managing Kubernetes clusters and applications.
*   **`kubernetes-cli` (kubectl):** The command-line tool for controlling Kubernetes clusters.
*   **`kubectx` (includes `kubens`):** A utility to switch between Kubernetes contexts (clusters) and namespaces easily.
*   **`helm`:** The package manager for Kubernetes, helping you define, install, and upgrade even the most complex Kubernetes applications.
*   **`weaveworks/tap` (Tap):** Weaveworks' official Homebrew tap (also used for `eksctl`).

### LSP (Language Server Protocol) & Linters/Formatters
Tools that provide language intelligence, linting, and formatting, often used with Neovim.
*   **`viu`:** A command-line image viewer for the terminal. (Can be used by Neovim plugins to display images).
*   **`shellcheck`:** A static analysis tool for shell scripts (bash, sh, zsh).
*   **`shfmt`:** A shell parser, formatter, and interpreter with bash support; includes `shfmt`.
*   **`hashicorp/tap/terraform-ls`:** Language server for Terraform.
*   **`tflint`:** A Pluggable Terraform Linter.
*   **`efm-langserver`:** A general-purpose Language Server that uses external tools to provide LSP features.
*   **`stylua`:** An opinionated Lua code formatter.

### Applications (Casks)
GUI applications installed via Homebrew Cask.
*   **`alacritty` (args: `{ no_quarantine: true }`):** A fast, cross-platform, OpenGL terminal emulator. The `no_quarantine` argument bypasses macOS Gatekeeper quarantine for this app.
*   **`obsidian`:** A powerful knowledge base that works on local Markdown files.
*   **`drawio`:** A diagramming and whiteboarding application (desktop version of diagrams.net).

---
This list provides a snapshot of the tools used in this development environment. The `Brewfile` is the single source of truth for all Homebrew-managed packages.
