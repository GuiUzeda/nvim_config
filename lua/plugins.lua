-- lua/plugins.lua
-- Native plugin management via Neovim 0.12 vim.pack

-- Shorthands: gh: for GitHub, cb: for Codeberg
local plugins = {
  -- Core Utils
  'gh:NMAC427/guess-indent.nvim',
  'gh:lewis6991/gitsigns.nvim',
  'gh:folke/which-key.nvim',
  
  -- Telescope
  'gh:nvim-lua/plenary.nvim',
  'gh:nvim-telescope/telescope.nvim',
  
  -- Completion & LSP
  'gh:saghen/blink.cmp',
  'gh:neovim/nvim-lspconfig',
  'gh:mason-org/mason.nvim',
  'gh:mason-org/mason-lspconfig.nvim',
  'gh:WhoIsSethDaniel/mason-tool-installer.nvim',
  
  -- UI & Aesthetics
  'gh:folke/tokyonight.nvim',
  'gh:folke/todo-comments.nvim',
  'gh:echasnovski/mini.nvim',
  'gh:nvim-tree/nvim-web-devicons',
  'gh:nvim-lualine/lualine.nvim',
  'gh:rcarriga/nvim-notify',
  'gh:stevearc/dressing.nvim',
  
  -- PKM
  'gh:epwalsh/obsidian.nvim',
  
  -- Editing
  'gh:stevearc/conform.nvim',
  'gh:mfussenegger/nvim-lint',
  'gh:windwp/nvim-autopairs',
  'gh:nvim-neo-tree/neo-tree.nvim',
  'gh:MunifTanjim/nui.nvim',
}

-- Add all plugins
vim.pack.add(plugins)

-- After adding, we can proceed to configure them (either here or in separate modules)
