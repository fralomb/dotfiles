# CLAUDE.md - AI Assistant Guide for Dotfiles Repository

This document provides comprehensive guidance for AI assistants working with this dotfiles repository. Last updated: 2025-11-15

## Repository Overview

This is a professional-grade dotfiles management repository with a clear separation between personal and work configurations. The repository uses GNU Stow for symlink management and supports macOS, Linux, and cloud-native development workflows.

**Primary Purpose:** Manage development environment configurations across personal and work contexts with automated installation, comprehensive documentation, and modern tooling.

**Documentation Site:** https://fralomb.github.io/dotfiles/

## Repository Structure

```
dotfiles/
├── main/              # Personal configuration packages
│   ├── ai/            # AI tool API keys (OpenAI, Gemini, Mistral, Codestral)
│   ├── alacritty/     # Terminal emulator config (Rose Pine theme)
│   ├── aws/           # AWS CLI configuration
│   ├── bat/           # Syntax highlighting for cat
│   ├── docker/        # Docker client configuration
│   ├── gh/            # GitHub CLI configuration
│   ├── git/           # Git configs with conditional includes
│   ├── neovim/        # Extensive Neovim setup (52 files, LSP, AI integration)
│   ├── ssh/           # SSH config with AWS SSM proxy
│   ├── terraform/     # Terraform linting configuration
│   ├── tmux/          # Tmux multiplexer with plugin management
│   └── zsh/           # Zsh shell with custom plugins
├── other/             # Work-specific configurations
│   ├── git/           # Work-specific git configuration
│   ├── gh/            # Work-specific GitHub CLI hosts (git-crypt encrypted)
│   ├── saml/          # SAML2AWS configuration
│   └── zsh/           # Work utilities (OTP, EKS utils)
├── docs/              # GitHub Pages documentation site (Jekyll)
├── theme/             # Color themes (Rose Pine for iTerm2)
├── symlinks           # Main installation/management script
├── pip.sh             # Python LSP server installation script
├── Brewfile           # macOS package management (82+ packages)
├── package.json       # Node.js dependencies (Angular, Claude, OpenAI)
└── README.md          # Quick start guide
```

### Key Directory Purposes

- **main/**: Personal daily-use configurations (11 tool configs)
- **other/**: Work-specific configurations (4 tool configs) - some encrypted with git-crypt
- **docs/**: GitHub Pages documentation site with detailed guides
- **.environments/**: External runtime data directory (`~/.environments/`)
  - `.neovim/`: Neovim plugin data
  - `.zsh/`: Zsh history and plugin data
  - `.tmux/`: Tmux plugin data

## Core Conventions and Patterns

### 1. Configuration Organization

**Separation by Context:**
- `main/` = Personal configurations
- `other/` = Work configurations
- Allows selective installation based on environment

**Directory Structure within Packages:**
Each package (e.g., `main/zsh/`) mirrors the target filesystem:
```
main/zsh/
├── .zshenv                    # → $HOME/.zshenv
└── .config/zsh/              # → $HOME/.config/zsh/
    ├── .zshrc
    ├── lib/
    └── config/
```

**Custom Target Directories:**
Some packages use `.target` files to specify non-standard symlink destinations:
```bash
# Example: other/gh/.target contains
~/.config/gh
```

### 2. Environment Variables

Centralized in `.zshenv`:
```bash
ENVSPATH="$HOME/.environments"       # Runtime data storage
NVIM_MAINDIR="$ENVSPATH/.neovim"    # Neovim plugins/cache
ZSH_MAINDIR="$ENVSPATH/.zsh"        # Zsh history/plugins
ZDOTDIR="$HOME/.config/zsh"         # Zsh config location
TMUX_MAINDIR="$ENVSPATH/.tmux"      # Tmux plugins
```

### 3. Conditional Loading

**Git Configuration:**
Uses conditional includes based on directory (main/git/.gitconfig:1-5):
```gitconfig
[includeIf "gitdir:~/personal/"]
    path = ~/.gitconfig.personal

[includeIf "gitdir:~/workspace/"]
    path = ~/.gitconfig.other
```

**Implication:** Projects under `~/personal/` use personal git config, `~/workspace/` uses work config.

### 4. Theming

**Rose Pine** color scheme is used consistently across:
- Neovim (rose-pine theme)
- Alacritty (Rose Pine Moon theme)
- iTerm2 (theme/rosepine/)
- Variants: standard, moon, dawn

### 5. Security Practices

**Protected Files:**
- API keys stored in `~/.config/{service}` files (git-ignored)
- Work secrets encrypted with git-crypt (e.g., other/gh/.target)
- SSH signing for git commits
- .gitignore protects: `.tokens`, `hosts.yml`, history files, node_modules

**Never commit:**
- API keys or tokens
- SSH private keys
- Decrypted work credentials
- Personal email addresses (use conditional git configs)

## Installation and Setup Workflow

### The `symlinks` Script

**Location:** `/home/user/dotfiles/symlinks`

**Core Functionality:**
- Uses GNU Stow to create/remove symlinks
- Supports custom target directories via `.target` files
- Error handling with stack traces
- Recursive operation for batch installation

**Basic Usage:**
```bash
# Install personal Zsh configuration
./symlinks -i main/zsh

# Install to custom target
./symlinks -i -t ~/.config/nvim main/neovim

# Uninstall work Git configuration
./symlinks -u other/git

# Install all work configs recursively
./symlinks -i -r other
```

**Important Parameters:**
- `-i, --install`: Create symlinks
- `-u, --uninstall`: Remove symlinks
- `-t, --target TARGET`: Specify custom target directory (default: $HOME)
- `-r, --recursive`: Process all subdirectories in source folder
- `-v, --verbose`: Show detailed stow output

**How It Works:**
1. Validates source folder exists
2. Checks for `.target` file for custom destination
3. Uses `stow` with `--ignore=.target --ignore=.DS_Store`
4. Creates necessary parent directories

### Package Management

**Homebrew (macOS) - Brewfile:**
```bash
# Install all packages
brew bundle install

# Update Brewfile with current packages
brew bundle dump --force

# Remove packages not in Brewfile
brew bundle cleanup --force
```

**NPM - package.json:**
```bash
npm install  # Installs Angular LSP, Claude Code, OpenAI packages
```

**Python - pip.sh:**
```bash
./pip.sh  # Creates venv at ~/.local/pip and installs Python LSP servers
```

## Technology Stack

### Shell Environment
- **Zsh** with extensive customization
- Plugins: zsh-autosuggestions, zsh-syntax-highlighting, kube-ps1, pure theme
- FZF integration for fuzzy finding
- 10M history entries with timestamps

### Editors
- **Neovim** (primary) with Lazy.nvim plugin manager
  - 52 configuration files
  - LSP support: Bash, Python, Java, Go, Terraform, Angular, Tailwind, HTMX, Helm, YAML, JSON, Lua, Docker, Groovy
  - AI integration: codecompanion, minuet-ai
  - Modern UI: Snacks.nvim, rose-pine, lualine, markview

### Terminal & Multiplexer
- **Alacritty** terminal with Rose Pine Moon theme
- **Tmux** with TPM (Tmux Plugin Manager)
- Auto-session restoration

### Development Tools
- **Git**: Conditional configs, SSH signing
- **AWS**: CLI, eksctl, session-manager-plugin
- **Docker/Podman**: Podman aliased as docker
- **Kubernetes**: kubectl, kubectx, helm
- **HashiCorp**: Terraform, Packer, Pulumi
- **Search**: ripgrep, fd, fzf, bat

## Development Workflows

### Making Changes to Configurations

**Safe Modification Process:**

1. **Identify the Package:**
   - Determine if it's personal (`main/`) or work (`other/`)
   - Navigate to the appropriate subdirectory

2. **Edit Configuration Files:**
   - Edit files in place within the dotfiles repository
   - Use absolute paths: `/home/user/dotfiles/main/<package>/...`

3. **Test Changes:**
   - For shell configs: `source ~/.zshrc` or restart shell
   - For Neovim: Restart Neovim or `:source $MYVIMRC`
   - For Tmux: `tmux source ~/.config/tmux/tmux.conf`

4. **Reinstall if Needed:**
   - Symlinks update automatically (they point to the files)
   - Only reinstall if structure changed (new files/directories)

5. **Commit Changes:**
   - Always commit to the current branch: `claude/claude-md-mi0g97ok4kjxwnf3-01NJhRxBDuXLHGEXzonkwmVh`
   - Use descriptive commit messages
   - Push to the designated branch

### Adding New Packages

**Steps:**

1. **Create Package Directory:**
   ```bash
   mkdir -p main/new-tool/.config/new-tool
   ```

2. **Add Configuration Files:**
   - Mirror the target filesystem structure
   - Example: `main/new-tool/.config/new-tool/config.yml`

3. **Optional - Add .target File:**
   ```bash
   echo "~/.config/new-tool" > main/new-tool/.target
   ```

4. **Install Package:**
   ```bash
   ./symlinks -i main/new-tool
   ```

5. **Update Documentation:**
   - Add entry to `docs/dotfiles.md`
   - Update `README.md` if it's a core component

### Updating Dependencies

**Homebrew:**
```bash
brew update && brew upgrade
brew bundle dump --force  # Update Brewfile
```

**NPM:**
```bash
npm update
npm install  # Regenerate package-lock.json
```

**Python LSP Servers:**
```bash
rm -rf ~/.local/pip
./pip.sh  # Reinstall fresh
```

**Neovim Plugins:**
- Open Neovim: `:Lazy sync`
- Mason LSP servers: `:Mason` then `U` for update all

**Tmux Plugins:**
- In Tmux: `prefix + I` (capital i) to install/update

## Working with Neovim Configuration

### Structure
```
main/neovim/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── options.lua         # Vim options
│   ├── keymaps.lua         # Key mappings
│   ├── autocmds.lua        # Autocommands
│   └── plugins/            # Plugin configurations (Lazy.nvim)
│       ├── init.lua
│       ├── ai.lua          # AI plugins (codecompanion, minuet)
│       ├── completion.lua  # nvim-cmp, LuaSnip
│       ├── editor.lua      # Core editing plugins
│       ├── lsp.lua         # LSP configuration
│       └── ui.lua          # UI plugins
```

### Key Dependencies

**Required LSP Servers** (install via Mason or system package manager):
- bashls, pyright, jdtls, gopls, terraformls, angularls, tailwindcss, htmx-lsp
- helm-ls, yamlls, jsonls, lua_ls, dockerls, groovyls

**Required System Packages:**
- ripgrep, fd-find (for Telescope/pickers)
- tree-sitter CLI (for syntax highlighting)
- nerd-fonts (Hack Nerd Font configured)

### Making Changes

**When modifying Neovim configs:**

1. Edit files in `/home/user/dotfiles/main/neovim/.config/nvim/`
2. Test with `:source $MYVIMRC` or restart Neovim
3. Check for errors with `:Lazy check`
4. Verify LSP servers with `:LspInfo`
5. Commit changes with descriptive messages

## Git Workflow

### Branch Management

**Current Development Branch:**
- `claude/claude-md-mi0g97ok4kjxwnf3-01NJhRxBDuXLHGEXzonkwmVh`

**CRITICAL: All development must happen on this branch.**

### Commit Guidelines

**Good Commit Messages:**
```
feat: Add Rust LSP support to Neovim
fix: Correct tmux plugin installation script
docs: Update CLAUDE.md with new conventions
refactor: Reorganize zsh config structure
```

**Commit Process:**
```bash
git status                    # Review changes
git diff                      # Review actual changes
git add <files>              # Stage specific files
git commit -m "message"      # Commit with message
git push -u origin claude/claude-md-mi0g97ok4kjxwnf3-01NJhRxBDuXLHGEXzonkwmVh
```

**Retry Logic for Push Failures:**
- Network failures: Retry up to 4 times with exponential backoff (2s, 4s, 8s, 16s)
- 403 errors: Verify branch name starts with `claude/` and ends with session ID

### What to Never Commit

- `.zsh_history` files
- API token files (`.tokens`, `.config/*/api_key`)
- `node_modules/`
- `.DS_Store` files
- Neovim plugin directories (`plugged/`, `autoload/`)
- Decrypted work credentials
- `.config/gh/hosts.yml` (personal version)

## Testing and Validation

### No Automated Tests
This repository does not have automated test scripts, but validation mechanisms include:

**Pre-Installation Validation:**
- Check `stow` is installed: `which stow`
- Verify source directory exists before `./symlinks` usage
- Check `.target` file syntax if used

**Post-Installation Validation:**
```bash
# Verify symlinks created
ls -la ~/ | grep "\->"

# Test shell configuration
zsh -c "echo $ZDOTDIR"

# Test Neovim
nvim --headless "+Lazy! sync" +qa
nvim --headless "+checkhealth" +qa

# Verify LSP servers
nvim --headless "+Mason" +qa
```

**Quality Tools Configured:**
- `shellcheck` for bash/zsh scripts
- `tflint` for Terraform
- `gitleaks` for secret detection
- `pre-commit` framework support
- Python linters via pylsp

### Manual Testing Checklist

When making changes:

1. **Shell configs**: Source the config and run common commands
2. **Neovim configs**: Open Neovim, check for errors, test LSP
3. **Tmux configs**: Source config or restart tmux
4. **Git configs**: Test `git config --list` in personal/work directories
5. **Symlinks**: Verify with `ls -la` that symlinks point correctly

## Common Tasks for AI Assistants

### Task: Add a New Shell Alias

```bash
# 1. Edit zsh configuration
vim /home/user/dotfiles/main/zsh/.config/zsh/.zshrc

# 2. Add alias
alias new_command="existing_command --with-flags"

# 3. Test
source ~/.zshrc
new_command

# 4. Commit
git add main/zsh/.config/zsh/.zshrc
git commit -m "feat: Add new_command alias to zsh"
git push -u origin claude/claude-md-mi0g97ok4kjxwnf3-01NJhRxBDuXLHGEXzonkwmVh
```

### Task: Install a New Neovim Plugin

```lua
-- 1. Edit plugin configuration
-- File: /home/user/dotfiles/main/neovim/.config/nvim/lua/plugins/new-category.lua

return {
  {
    "author/plugin-name",
    config = function()
      require("plugin-name").setup({
        -- configuration
      })
    end,
  }
}

-- 2. Restart Neovim and run
:Lazy sync

-- 3. Test plugin functionality

-- 4. Commit
git add main/neovim/.config/nvim/lua/plugins/new-category.lua
git commit -m "feat: Add plugin-name to Neovim"
git push -u origin claude/claude-md-mi0g97ok4kjxwnf3-01NJhRxBDuXLHGEXzonkwmVh
```

### Task: Update Brewfile

```bash
# 1. Install new package
brew install new-package

# 2. Update Brewfile
brew bundle dump --force

# 3. Verify
git diff Brewfile

# 4. Commit
git add Brewfile
git commit -m "feat: Add new-package to Brewfile"
git push -u origin claude/claude-md-mi0g97ok4kjxwnf3-01NJhRxBDuXLHGEXzonkwmVh
```

### Task: Add Work-Specific Configuration

```bash
# 1. Create configuration in other/ directory
mkdir -p other/new-tool/.config/new-tool

# 2. Add configuration files
echo "work_specific_config: true" > other/new-tool/.config/new-tool/config.yml

# 3. Optional: Add .target file
echo "~/.config/new-tool" > other/new-tool/.target

# 4. Consider git-crypt if sensitive
# (Requires git-crypt setup and .gitattributes configuration)

# 5. Install
./symlinks -i other/new-tool

# 6. Commit
git add other/new-tool
git commit -m "feat: Add work configuration for new-tool"
git push -u origin claude/claude-md-mi0g97ok4kjxwnf3-01NJhRxBDuXLHGEXzonkwmVh
```

## Important Files Reference

### Critical Files (Never Delete)

| File | Purpose | Notes |
|------|---------|-------|
| `symlinks` | Main installation script | Uses GNU Stow, error handling |
| `main/zsh/.zshenv` | Environment variables | Sourced first by zsh |
| `main/zsh/.config/zsh/.zshrc` | Zsh main config | Sources lib/ and config/ |
| `main/neovim/.config/nvim/init.lua` | Neovim entry point | Loads all plugin configs |
| `main/git/.gitconfig` | Git conditional includes | Routes personal/work configs |
| `Brewfile` | macOS package manifest | 82+ packages |
| `package.json` | NPM dependencies | LSP and AI tools |
| `pip.sh` | Python LSP installer | Creates venv at ~/.local/pip |

### Configuration Entry Points

| Tool | Entry Point | Additional Config Locations |
|------|-------------|---------------------------|
| Zsh | `.zshenv` → `.zshrc` | `.config/zsh/lib/`, `.config/zsh/config/` |
| Neovim | `init.lua` | `lua/plugins/*.lua` |
| Tmux | `.config/tmux/tmux.conf` | `.config/tmux/conf/` |
| Git | `.gitconfig` | `.gitconfig.personal`, `.gitconfig.other` |
| Alacritty | `.config/alacritty/alacritty.yml` | Inline theme config |

### Documentation Files

| File | Purpose | URL |
|------|---------|-----|
| `README.md` | Quick start guide | Root of repo |
| `docs/index.md` | Documentation home | https://fralomb.github.io/dotfiles/ |
| `docs/dotfiles.md` | Package details | https://fralomb.github.io/dotfiles/dotfiles |
| `docs/neovim.md` | Neovim guide | https://fralomb.github.io/dotfiles/neovim |
| `docs/symlink-script.md` | Symlinks usage | https://fralomb.github.io/dotfiles/symlink-script |

## Troubleshooting Guide

### Symlink Installation Fails

**Symptom:** `./symlinks -i main/zsh` fails with conflicts

**Solutions:**
```bash
# 1. Check existing files
ls -la ~/.zshenv

# 2. Back up existing configs
mv ~/.zshenv ~/.zshenv.backup

# 3. Retry installation
./symlinks -i main/zsh

# 4. Or force with stow directly
stow --adopt --dir=main --target=$HOME zsh
```

### Neovim Plugins Not Loading

**Symptom:** Plugins don't work after changes

**Solutions:**
```bash
# 1. Check for syntax errors
nvim --headless "+checkhealth" +qa

# 2. Reinstall plugins
nvim --headless "+Lazy! sync" +qa

# 3. Check lazy.nvim log
nvim ~/.local/state/nvim/lazy/lazy.log

# 4. Verify plugin directory
ls ~/.environments/.neovim/lazy/
```

### Zsh Configuration Not Applying

**Symptom:** Changes to .zshrc not taking effect

**Solutions:**
```bash
# 1. Verify symlink
ls -la ~/.zshenv ~/.config/zsh/.zshrc

# 2. Check for errors
zsh -x -c "source ~/.zshrc" 2>&1 | less

# 3. Verify ZDOTDIR
echo $ZDOTDIR  # Should be ~/.config/zsh

# 4. Reinstall
./symlinks -u main/zsh
./symlinks -i main/zsh
```

### Git Conditional Includes Not Working

**Symptom:** Wrong git config used in personal/work directories

**Solutions:**
```bash
# 1. Verify directory structure
pwd  # Should be under ~/personal/ or ~/workspace/

# 2. Check git config
git config --list --show-origin

# 3. Verify conditional includes
cat ~/.gitconfig

# 4. Create personal/work config files if missing
ls ~/.gitconfig.personal ~/.gitconfig.other
```

## Best Practices for AI Assistants

### DO:
1. Always use the TodoWrite tool for multi-step tasks
2. Read existing configurations before making changes
3. Test changes in a safe environment first
4. Use descriptive commit messages following conventional commits
5. Check for existing documentation in `docs/` before asking
6. Respect the main/ vs other/ separation
7. Use the symlinks script for installation (don't manually ln -s)
8. Validate symlinks point to the dotfiles repo, not copies
9. Keep configurations modular and organized
10. Document significant changes in commit messages

### DON'T:
1. Never commit sensitive data (API keys, tokens, credentials)
2. Don't modify files outside `/home/user/dotfiles/` directly
3. Don't push to branches other than the designated Claude branch
4. Avoid creating duplicate configurations
5. Don't hardcode absolute paths (use environment variables)
6. Never delete the symlinks script or Brewfile
7. Don't commit to main branch without explicit permission
8. Avoid mixing personal and work configurations
9. Don't bypass git-crypt for work credentials
10. Never remove safety features (error handling, backups)

### When in Doubt:
1. Check the documentation site: https://fralomb.github.io/dotfiles/
2. Review existing similar configurations
3. Test in isolation before committing
4. Ask the user for clarification on work vs personal context
5. Use git diff before committing to review changes

## Quick Reference Commands

### Installation
```bash
./symlinks -i main/zsh              # Install personal zsh
./symlinks -i -r main               # Install all personal configs
./symlinks -u other/git             # Uninstall work git config
brew bundle install                 # Install Homebrew packages
npm install                         # Install NPM packages
./pip.sh                           # Install Python LSP servers
```

### Validation
```bash
git status                          # Check repository status
git diff                            # Review changes
ls -la ~/ | grep "\->"             # Check symlinks
nvim --headless "+checkhealth" +qa  # Neovim health check
zsh -c "echo $ZDOTDIR"             # Verify zsh config
stow --version                      # Verify stow installed
```

### Updates
```bash
brew update && brew upgrade         # Update Homebrew packages
brew bundle dump --force            # Update Brewfile
npm update                          # Update NPM packages
:Lazy sync                         # Update Neovim plugins (in nvim)
prefix + I                         # Update Tmux plugins (in tmux)
```

### Git Operations
```bash
git add <file>                      # Stage changes
git commit -m "message"            # Commit changes
git push -u origin claude/...      # Push to Claude branch
git log --oneline -10              # View recent commits
git diff HEAD~1                    # Compare with previous commit
```

## Conclusion

This dotfiles repository is a well-organized, comprehensive development environment configuration system. It prioritizes:

- Modularity (main/ vs other/)
- Automation (symlinks script, package managers)
- Documentation (GitHub Pages site)
- Security (git-crypt, .gitignore)
- Modern tooling (Neovim with LSP, Zsh, AI integration)

When working with this repository, always prioritize safety, testing, and documentation. Respect the existing structure and conventions, and use the designated tools (symlinks script, package managers) rather than manual operations.

For detailed information on specific components, consult the documentation site at https://fralomb.github.io/dotfiles/.
