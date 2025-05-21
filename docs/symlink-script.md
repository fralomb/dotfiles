---
layout: default
---

# `symlinks` Script Documentation

The `symlinks` script is a utility designed to manage dotfiles within this repository using the **stow** command. It simplifies the process of creating and removing symbolic links for various configuration "packages."

## Core Functionality

A **package** is defined as a collection of files and directories that you wish to administer as a unit. These packages are intended to be installed into a specific directory structure, starting from a designated **target folder**.

When a package is "installed" using the script, its contents will appear to be located in the **target directory** (the root tree where symlinks are created), while the actual files remain within this repository. This allows for version control and easy management of configurations across different environments or machines.

## Features

*   **Selective Symlinking:** Create or remove symlinks for specified packages.
*   **Custom Target Directory:** Define a target directory for symlinks, defaulting to `$HOME`.
*   **Recursive Operation:** Option to iterate through subdirectories within a package and stow all their contents.
*   **Ignoring Files:** Specify files or directories to be ignored during the symlinking process using the `--ignore` option.
*   **Custom Target Paths:** Define a `.target` file within a package directory. This file can contain a path to a specific target file, overriding the default behavior of mirroring the current folder structure.

## Usage

The script is invoked from the command line with various options:

```bash
./symlinks [--install | -i] [--uninstall | -u] [--recursive | -r] [--target | -t] <TARGET_VALUE> FOLDER
```

### Command Options:

*   `--install` or `-i`:
    *   **Action:** Creates symbolic links for the specified `FOLDER` (package) into the `TARGET_VALUE` directory.
*   `--uninstall` or `-u`:
    *   **Action:** Removes previously created symbolic links for the specified `FOLDER` from the `TARGET_VALUE` directory.
*   `--target` or `-t` `<TARGET_VALUE>`:
    *   **Action:** Specifies the target directory where symlinks will be created or removed.
    *   **Default:** `$HOME` (your home directory).
*   `--recursive` or `-r`:
    *   **Action:** When used with `--install` or `--uninstall`, this option will iterate through all directories inside the specified `FOLDER` (stow package) and apply the stow operation to all their content. This is useful for packages that have a nested structure.
*   `--help` or `-h`:
    *   **Action:** Displays a help menu with usage instructions and option explanations.
*   `FOLDER`:
    *   **Required Argument:** Specifies the source folder (package) within the repository that you want to install or uninstall. For example, `main/zsh` or `other/git`.

## Examples

1.  **Install a Personal Zsh Configuration:**
    To create symlinks for your personal Zsh configuration files located in `main/zsh` to your home directory:
    ```bash
    ./symlinks --install main/zsh
    ```
    or using the short-hand:
    ```bash
    ./symlinks -i main/zsh
    ```

2.  **Uninstall a Work-Specific Git Configuration:**
    To remove symlinks for a work-specific Git configuration located in `other/git` from your home directory:
    ```bash
    ./symlinks --uninstall other/git
    ```
    or:
    ```bash
    ./symlinks -u other/git
    ```

3.  **Install a Package to a Custom Target Directory:**
    To install a work-specific tool configuration (e.g., `other/specific_tool`) into a custom target directory like `~/.config/other_configs`:
    ```bash
    ./symlinks --install --target ~/.config/other_configs other/specific_tool
    ```
    or:
    ```bash
    ./symlinks -i -t ~/.config/other_configs other/specific_tool
    ```

4.  **Recursively Install a Package with Nested Directories:**
    If you have a package, for instance `main/complex_tool`, which contains multiple subdirectories that themselves need to be stowed into the target directory, you would use:
    ```bash
    ./symlinks -i -r main/complex_tool
    ```
    This will stow `main/complex_tool/sub_config1`, `main/complex_tool/sub_config2`, etc., into the target directory.

5.  **Ignoring Specific Files During Installation:**
    If a package `main/my_app` contains a `temp_notes.txt` file that you don't want to symlink, you could run:
    ```bash
    ./symlinks -i --ignore temp_notes.txt main/my_app
    ```
    Multiple files/directories can be ignored by repeating the `--ignore` option or by providing a comma-separated list (check script's specific implementation for multiple ignores).

## `.target` File for Custom Paths

In some cases, a file within your package directory needs to be symlinked to a location that doesn't directly mirror the structure of your dotfiles repository. For example, you might have `main/my_editor/config.json` but it needs to be symlinked to `~/.config/my_editor_app/settings.json`.

To handle this, you can create a `.target` file inside the `main/my_editor` directory. The content of this `.target` file would be the desired absolute path for `config.json`, or a path relative to the main target directory. The `symlinks` script would then read this file to determine the correct symlink location for `config.json`.

**Note:** The exact implementation details of how the `.target` file is parsed and used should be verified within the `symlinks` script itself.

---
This script is crucial for maintaining a clean and organized set of dotfiles, allowing for easy management and deployment across different systems.
