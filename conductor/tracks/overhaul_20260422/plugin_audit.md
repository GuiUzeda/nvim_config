# Plugin Audit - Overhaul to Neovim 0.12

## Core Plugins (Kickstart)
| Plugin | File | Migration Note |
| :--- | :--- | :--- |
| `guess-indent.nvim` | `lazy-plugins.lua` | Simple `vim.pack.add` |
| `gitsigns.nvim` | `kickstart/plugins/gitsigns.lua` | Extract `opts` |
| `which-key.nvim` | `kickstart/plugins/which-key.lua` | Extract `opts` |
| `telescope.nvim` | `kickstart/plugins/telescope.lua` | Extract `config` and dependencies |
| `nvim-lspconfig` | `kickstart/plugins/lspconfig.lua` | **Complex**: Needs migration to native `vim.lsp.config` |
| `conform.nvim` | `kickstart/plugins/conform.lua` | Extract `opts` |
| `blink.cmp` | `kickstart/plugins/blink-cmp.lua` | Extract `opts` |
| `tokyonight.nvim` | `kickstart/plugins/tokyonight.lua` | Extract `opts` |
| `todo-comments.nvim` | `kickstart/plugins/todo-comments.lua` | Extract `opts` |
| `mini.nvim` | `kickstart/plugins/mini.lua` | Extract `config` |
| `nvim-treesitter` | `kickstart/plugins/treesitter.lua` | **Native Transition**: Replace with native management |
| `nvim-dap` | `kickstart/plugins/debug.lua` | Extract `config` and dependencies |
| `indent-blankline.nvim` | `kickstart/plugins/indent_line.lua` | Extract `opts` |
| `nvim-lint` | `kickstart/plugins/lint.lua` | Extract `config` |
| `nvim-autopairs` | `kickstart/plugins/autopairs.lua` | Extract `opts` |
| `neo-tree.nvim` | `kickstart/plugins/neo-tree.lua` | Extract `opts` and dependencies |

## Custom Plugins
| Plugin | File | Migration Note |
| :--- | :--- | :--- |
| `nvim-notify` | `custom/plugins/ui.lua` | Extract `opts` |
| `dressing.nvim` | `custom/plugins/ui.lua` | Extract `opts` |
| `noice.nvim` | `custom/plugins/ui.lua` | **Optional**: Might be replaced/conflicted by `ui2` |
| `alpha-nvim` | `custom/plugins/alpha.lua` | Extract `config` |
| `autosave.nvim` | `custom/plugins/autosave.lua` | Extract `opts` |
| `bluloco.nvim` | `custom/plugins/bluloco.lua` | Extract `opts` |
| `ccc.nvim` | `custom/plugins/ccc.lua` | Extract `opts` |
| `glow.nvim` | `custom/plugins/glow.lua` | Extract `opts` |
| `lualine.nvim` | `custom/plugins/lualine.lua` | Extract `config` |
| `markdown-preview.nvim` | `custom/plugins/markdown.lua` | Extract `config` |
| `navic.nvim` | `custom/plugins/navic.lua` | Extract `opts` |
| `obsidian.nvim` | `custom/plugins/obsidian.lua` | Extract `opts` |
| `smear-cursor.nvim` | `custom/plugins/smear-cursor.lua` | Extract `opts` |
| `sonarlint.nvim` | `custom/plugins/sonarlint.lua` | Extract `config` |
| `supermaven-nvim` | `custom/plugins/supermaven.lua` | Extract `opts` |
| `table-mode.nvim` | `custom/plugins/table-mode.lua` | Extract `config` |
| `terminal-nav.nvim` | `custom/plugins/terminal-nav.lua` | Extract `opts` |
| `tiny-inline-diagnostic.nvim` | `custom/plugins/tiny-inline-diagnostic.lua` | Extract `opts` |
| `trouble.nvim` | `custom/plugins/trouble.lua` | Extract `opts` and keys |
