---
layout: default
---

# NPM Packages Documentation

This document outlines the Node.js packages managed via the `package.json` file in this repository. These packages are primarily installed to enhance the capabilities of Neovim, particularly for Language Server Protocol (LSP) support and other development utilities.

## `package.json`

The `package.json` file is located at the root of the repository and lists project-specific Node.js dependencies.

### Managing NPM Packages:

While these packages are listed in `package.json`, they are typically installed globally or managed by Neovim's plugin manager (like Mason) which might handle their installation into a Neovim-specific directory. If you need to install them manually for system-wide use or for Neovim to find them (if not managed by a plugin manager):

*   **Install all dependencies locally (in `node_modules`):**
    ```bash
    npm install
    ```
*   **Install a package globally (example):**
    ```bash
    npm install -g @angular/language-server
    ```

Consult your Neovim plugin manager's documentation (e.g., Mason) to see how it handles these NPM-based language servers. Often, no manual NPM installation is needed if Mason is configured correctly.

## Dependencies

The following packages are listed as dependencies in `package.json`:

### `@angular/language-server`
*   **Version:** `^17.3.1` (as per the `package.json` provided)
*   **Purpose:** This package provides language server capabilities for Angular projects. It enables features like autocompletion, error checking, and navigation within Angular templates (`.html` files) and TypeScript code related to Angular components.
*   **Use in Project:** Primarily used by Neovim's LSP client (via `lspconfig` and Mason) to offer rich editing features for Angular development.

### `@anthropic-ai/claude-code`
*   **Version:** `^0.2.117` (as per the `package.json` provided)
*   **Purpose:** This package is likely related to providing AI-assisted coding features using Anthropic's Claude models. It might be a client library or a tool that integrates with Neovim to offer code suggestions, explanations, or generation.
*   **Use in Project:** Integrated into the Neovim setup to leverage AI for coding tasks, potentially through a specific Neovim plugin designed to work with Claude or a general-purpose AI plugin that supports it.

---
These NPM packages extend the development environment, particularly within Neovim, by adding advanced language support and potentially AI-driven coding assistance. Refer to the Neovim configuration for details on how these packages are integrated.
