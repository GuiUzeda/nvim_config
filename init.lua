-- init.lua
-- Neovim 0.12 Native Overhaul

-- 1. Set leader keys (MUST be first)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- 2. Enable the experimental Lua loader
if vim.loader then
  vim.loader.enable()
end

-- 3. Enable native ui2 engine (Experimental 0.12 feature)
pcall(function()
  require('vim._core.ui2').enable()
end)

-- 4. Enable built-in plugins
vim.cmd('packadd nvim.undotree')
vim.cmd('packadd nvim.difftool')

-- 5. Load options and keymaps
require('options')
require('keymaps')

-- 5. Load plugins and their configurations
require('plugins')

-- 6. Load LSP configuration
require('lsp')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
