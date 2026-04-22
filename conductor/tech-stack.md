# Tech Stack - Uzeda's Neovim Configuration

## Core
- **Neovim**: Version 0.12+ (Stable/Nightly)
- **Runtime**: LuaJIT (Built-in)
- **Plugin Management**: Transitioning from `lazy.nvim` to native `vim.pack`.

## Language Servers (LSP)
- **Infrastructure**: `nvim-lspconfig`, `mason.nvim`, `mason-tool-installer`.
- **Python**: `basedpyright` (type checking), `ruff` (linting/formatting).
- **Go**: `gopls` (Go language server), `goimports`, `gofumpt`.
- **Web**: `ts_ls`, `eslint`, `tailwindcss-language-server`, `prettierd`.
- **Other**: `lua_ls`, `sqls`, `dockerls`, `beancount-language-server`.

## Syntax & Tree-sitter
- **Engine**: Native Neovim Tree-sitter integration.
- **Parsers**: Managed via native 0.12 APIs (replacing `nvim-treesitter` automation).

## UI & Navigation
- **Fuzzy Finding**: `telescope.nvim` for advanced search.
- **Completion**: `blink.cmp` for high-performance snippets and completion.
- **File Explorer**: `neo-tree.nvim`.
- **UI Enhancements**: `ui2` (native), `lualine.nvim` (statusline), `alpha-nvim` (dashboard).

## Specialized Tools
- **Obsidian**: `obsidian.nvim` for personal knowledge management integration.
- **Formatting**: `conform.nvim` for standardized code formatting.
- **Diagnostics**: `trouble.nvim` and native diagnostic APIs.
- **Utilities**: `mini.nvim` (various modules), `gitsigns.nvim`.
