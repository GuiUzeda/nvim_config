-- lua/plugins.lua
-- Native plugin management via Neovim 0.12 vim.pack

local plugins = {
  -- Core Utils
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/folke/which-key.nvim',
  
  -- Telescope
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  
  -- Completion & LSP
  'https://github.com/saghen/blink.cmp',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  
  -- UI & Aesthetics
  'https://github.com/uloco/bluloco.nvim',
  'https://github.com/rktjmp/lush.nvim',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/rcarriga/nvim-notify',
  'https://github.com/stevearc/dressing.nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/goolord/alpha-nvim',
  
  -- PKM
  'https://github.com/epwalsh/obsidian.nvim',
  
  -- Navigation & Multiplexer
  'https://github.com/mrjones2014/smart-splits.nvim',
  
  -- Editing
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/nvim-neo-tree/neo-tree.nvim',
  'https://github.com/antosha417/nvim-lsp-file-operations',
  'https://github.com/MunifTanjim/nui.nvim',
}

-- Add all plugins
vim.pack.add(plugins)

-- Helper to safely load configuration
local function safe_require(module)
  local ok, err = pcall(require, 'config.' .. module)
  if not ok then
    vim.notify('Error loading config for ' .. module .. ': ' .. err, vim.log.levels.ERROR)
  end
end

-- Load configurations in a logical order
local configs = {
  'ui', 'bluloco', 'alpha', 'lualine', 'which-key', 'telescope',
  'blink', 'conform', 'gitsigns', 'todo-comments', 'mini',
  'neo-tree', 'autopairs', 'obsidian', 'smart-splits', 'trouble'
}

for _, name in ipairs(configs) do
  safe_require(name)
end
