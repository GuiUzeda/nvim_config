-- lua/config/lualine.lua
require('lualine').setup {
  options = {
    theme = 'bluloco',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { { 'filename', path = 1 }, 'branch' },
    lualine_c = { '%=' },
    lualine_x = {
      {
        function()
          local ok, supermaven = pcall(require, 'supermaven-nvim.api')
          if not ok then return '' end
          return supermaven.is_running() and ' ' or ' '
        end,
        color = { fg = '#6ab0f3' },
      },
    },
    lualine_y = { 'filetype', 'progress' },
    lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
  },
  inactive_sections = {
    lualine_a = { { 'filename', path = 1 } },
    lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {},
    lualine_z = { 'location' },
  },
  extensions = { 'neo-tree', 'trouble' },
}
