-- init.lua
-- Neovim 0.12 Native Overhaul

-- Enable the experimental Lua loader for faster startup
if vim.loader then
  vim.loader.enable()
end

-- Enable native ui2 engine
pcall(function()
  require('vim._core.ui2').enable()
end)

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Global settings
vim.g.have_nerd_font = true

-- Load modules
require('options')
require('keymaps')
require('plugins') -- This will also load lua/config/*.lua
require('lsp')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
