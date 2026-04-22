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
  'gh:nvim-telescope/telescope-fzf-native.nvim',
  'gh:nvim-telescope/telescope-ui-select.nvim',
  
  -- Completion & LSP
  'gh:saghen/blink.cmp',
  'gh:L3MON4D3/LuaSnip',
  'gh:rafamadriz/friendly-snippets',
  'gh:folke/lazydev.nvim',
  'gh:neovim/nvim-lspconfig',
  'gh:mason-org/mason.nvim',
  'gh:mason-org/mason-lspconfig.nvim',
  'gh:WhoIsSethDaniel/mason-tool-installer.nvim',
  
  -- UI & Aesthetics
  'gh:uloco/bluloco.nvim',
  'gh:rktjmp/lush.nvim',
  'gh:folke/tokyonight.nvim',
  'gh:folke/todo-comments.nvim',
  'gh:echasnovski/mini.nvim',
  'gh:nvim-tree/nvim-web-devicons',
  'gh:nvim-lualine/lualine.nvim',
  'gh:rcarriga/nvim-notify',
  'gh:stevearc/dressing.nvim',
  'gh:folke/noice.nvim',
  'gh:goolord/alpha-nvim',
  
  -- PKM
  'gh:epwalsh/obsidian.nvim',
  
  -- Navigation & Multiplexer
  'gh:mrjones2014/smart-splits.nvim',
  
  -- Editing
  'gh:stevearc/conform.nvim',
  'gh:mfussenegger/nvim-lint',
  'gh:windwp/nvim-autopairs',
  'gh:nvim-neo-tree/neo-tree.nvim',
  'gh:antosha417/nvim-lsp-file-operations',
  'gh:MunifTanjim/nui.nvim',
}

-- Add all plugins
vim.pack.add(plugins)

-- Automatically load all configuration files in lua/config/
local config_path = vim.fn.stdpath('config') .. '/lua/config'
for _, file in ipairs(vim.fn.readdir(config_path)) do
  if file:match('%.lua$') then
    require('config.' .. file:gsub('%.lua$', ''))
  end
end
