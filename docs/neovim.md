# Neovim Configuration Details

This document provides a comprehensive overview of the Neovim setup, including build prerequisites, plugin dependencies, Language Server Protocol (LSP) configurations, and other specific settings used in this dotfiles repository.

The primary Neovim configuration is located in `main/neovim/.config/nvim/`.

## Build Prerequisites

To build Neovim from source or ensure all features work correctly, certain prerequisites might be needed. Refer to the official documentation for the most up-to-date list:
*   [Neovim Build Prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites)

## Initial Setup / Reset

If you need to reset your Neovim environment (use with caution):
```bash
rm -rf ~/.environment/.neovim  # Or any custom directory for Neovim data/binaries
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

## Core Dependencies

### Patched Fonts (for Icons)
Many Neovim themes and plugins utilize icons for an enhanced user interface. It's crucial to install a patched Nerd Font and configure your terminal emulator to use it.
*   **Resource:** [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
*   **Installation on macOS (example with Hack Nerd Font):**
    ```bash
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
    ```
    > **Warning:** Ensure your terminal emulator (e.g., Alacritty, iTerm2) is configured to use the installed Nerd Font. Otherwise, icons will not render correctly.

## Plugin Management
This configuration uses Packer or a similar plugin manager (details should be in `main/neovim/.config/nvim/init.lua` or a dedicated plugins file). Key plugins and their specific dependencies are listed below.

### Plugin-Specific Dependencies & Notes:

*   **`mason.nvim` (and `mason-lspconfig.nvim`)**:
    *   Manages LSP servers, DAP servers, linters, and formatters.
    *   Requires:
        *   `wget`
        *   `curl`
        *   `cargo` and `rust` (for some components, install with: `curl https://sh.rustup.rs -sSf | sh`)

*   **`nvim-cmp` (Auto-completion)**:
    *   Provides completion features. Configuration details are critical for a good experience.
    *   **Documentation:** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

*   **`telescope.nvim` (Fuzzy Finder)**:
    *   A highly extendable fuzzy finder.
    *   **Dependency:** `ripgrep` (for fast file searching). `brew install ripgrep`

*   **`harpoon` (File/Mark Navigation)**:
    *   Quickly navigate between frequently used files/buffers.
    *   **Documentation:** [Harpoon](https://github.com/ThePrimeagen/harpoon)

## Language Server Protocol (LSP) Configurations

LSPs provide features like auto-completion, go-to-definition, diagnostics (linting/errors), and hover information. They are typically installed and managed via `mason.nvim`.

### General LSP Dependencies:
*   **C/C++ Compiler (for some LSPs or tree-sitter parsers):**
    *   `sudo apt-get install build-essential` (Linux)
    *   Xcode Command Line Tools (macOS)

### Specific Language LSPs and Tools:

*   **Bash:**
    *   `bash-language-server`: Requires Node.js and npm.
        *   Install Node.js: `sudo apt-get install nodejs` (or via `nvm`/`brew`)
        *   Install server: `npm i -g bash-language-server`
    *   `shellcheck` (for linting): `brew install shellcheck` or `sudo apt install shellcheck`

*   **Python:**
    *   Multiple LSP options exist (e.g., `pyright`, `python-lsp-server`). Check your Mason setup.
    *   **Documentation (example for `python-lsp-server`):** [python-language-server](https://github.com/palantir/python-language-server) (Note: this specific server might be outdated; `pyright` is a common modern choice).
    *   `pynvim` (for Python plugin support in Neovim): `pip3 install pynvim`
    *   **Linters/Formatters:**
        *   `flake8` (diagnostics): `pip install flake8`
        *   `autopep8` (formatting): `pip install autopep8` (or `black`, `isort`)

*   **Java:**
    *   `jdtls` (Eclipse JDT Language Server). Managed by Mason.
    *   **References & Dependencies:**
        *   [nvim-jdtls (Neovim plugin)](https://github.com/mfussenegger/nvim-jdtls)
        *   [eclipse.jdt.ls (The language server itself)](https://github.com/eclipse/eclipse.jdt.ls#installation)
        *   [nvim-dap (Debug Adapter Protocol plugin)](https://github.com/mfussenegger/nvim-dap)
        *   [vscode-java-test (for running tests)](https://github.com/microsoft/vscode-java-test)
    *   **System Dependencies:**
        *   `maven` or `gradle` (project build tools): `sudo apt-get install -y maven`
        *   JDK (e.g., OpenJDK 8 or later): `sudo apt-get install -y openjdk-8-jdk`

*   **Hurl (HTTP Testing):**
    *   For testing HTTP requests easily.
    *   **Website:** [hurl.dev](https://hurl.dev/)
    *   An LSP for Hurl might be available via Mason.

*   **Go (`gopls`):**
    *   The official Go language server.
    *   **Installation (if not using Mason):** `go install golang.org/x/tools/gopls@latest`

*   **HTML/CSS/JavaScript:**
    *   **Emmet:** For faster HTML/CSS development.
        *   Plugin: `emmet-vim` ([mattn/emmet-vim](https://github.com/mattn/emmet-vim))
        *   **Tutorial:** [Emmet Tutorial](https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL)
    *   LSPs like `vscode-langservers-extracted` (for HTML, CSS, JSON, ESLint) or `tailwindcss-language-server` are typically used.

*   **Terraform:**
    *   `terraform-ls` (HashiCorp Language Server for Terraform).
    *   **Installation (if not using Mason):** `brew install hashicorp/tap/terraform-ls`
    *   **Documentation:** [terraform-ls](https://github.com/hashicorp/terraform-ls)
    *   **Packer (for building Packer templates, often used with Terraform):**
        *   `brew tap hashicorp/tap && brew install hashicorp/tap/packer`

*   **HTMX:**
    *   Language server for HTMX.
    *   **Installation (if not using Mason):** `cargo install htmx-lsp`
    *   **Neovim LSP Config Documentation:** [htmx](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#htmx)

*   **Tailwind CSS:**
    *   `tailwindcss-language-server` for Tailwind CSS autocompletion and linting.
    *   **Installation (if not using Mason):** `npm install -g @tailwindcss/language-server`
    *   **Documentation:**
        *   [Tailwind CSS IntelliSense](https://github.com/tailwindlabs/tailwindcss-intellisense/tree/master/packages/tailwindcss-language-server)
        *   [Neovim LSP Config: tailwindcss](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss)

*   **Angular:**
    *   `@angular/language-server` for Angular template support.
    *   **Installation (if not using Mason):** `npm install -g @angular/language-server`
    *   **Angular CLI (optional but recommended for Angular development):** `npm install -g @angular/cli`
    *   **Neovim LSP Config Documentation:** [angularls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#angularls)

## GitHub Copilot

If using GitHub Copilot:
*   **Plugin:** `copilot.vim` or a Lua equivalent.
*   **Documentation:** [copilot.vim](https://github.com/github/copilot.vim?tab=readme-ov-file)
    *   Follow setup instructions, including authentication.

---
This document outlines the core components of the Neovim configuration. For the actual Lua configuration files, plugin lists, and key mappings, please refer to the files within the `main/neovim/.config/nvim/` directory.
