# Specification - Overhaul to Neovim 0.12 Native Standards

## Overview
Migrate the existing Neovim configuration from `lazy.nvim` and `nvim-treesitter` to Neovim 0.12 native features (`vim.pack`, native Tree-sitter management, and `ui2`). This overhaul aims to leverage the "Out of the Box" improvements in 0.12 to reduce dependency on external plugins and improve performance.

## Functional Requirements
- **Plugin Management**: Transition from `lazy.nvim` to the native `vim.pack` Lua module.
- **UI Engine**: Enable the experimental native `ui2` and optimize the command-line/message experience.
- **Tree-sitter**: Move from `nvim-treesitter` plugin to native parser management using 0.12 APIs and the `tree-sitter` CLI.
- **LSP Configuration**: Modernize LSP setup using the new `vim.lsp.config` and `vim.lsp.enable` APIs.
- **Feature Parity**: Ensure all existing specialized workflows (Python with Ruff/Basedpyright, Go, and Obsidian) are fully functional in the new architecture.

## Non-Functional Requirements
- **Performance**: Maintain or improve the sub-50ms startup time.
- **Maintainability**: Utilize extreme modularity for the new configuration structure.
- **Stability**: Ensure the configuration is robust enough for daily use despite adopting experimental features.

## Acceptance Criteria
- Neovim starts without errors or "Press ENTER" interruptions.
- All plugins are successfully loaded via `vim.pack`.
- Syntax highlighting and LSP features work across all supported languages.
- `:checkhealth` returns no critical errors for Tree-sitter or LSP.
- Obsidian integration (templates, switch, search) remains functional.
