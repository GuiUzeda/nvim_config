-- lua/config/bluloco.lua
require('bluloco').setup {
  style = 'auto',
  transparent = false,
  italics = true,
  terminal = vim.fn.has 'gui_running' == 1,
  guicursor = true,
  rainbow_headings = true,
  float_window = 'default',
}

vim.opt.termguicolors = true
vim.cmd 'colorscheme bluloco'

local function set_focus_highlights()
  -- Dim inactive windows (darker bg + muted text)
  vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#21242D', fg = '#636D83' })
  -- Accent the window separator with bluloco blue
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#10B1FE', bg = '#21242D' })
end

set_focus_highlights()

-- Re-apply after any colorscheme reload
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'bluloco*',
  callback = set_focus_highlights,
})
