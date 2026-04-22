-- lua/config/which-key.lua
require('which-key').setup {
  delay = 0,
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ', Down = '<Down> ', Left = '<Left> ', Right = '<Right> ',
      C = '<C-…> ', M = '<M-…> ', D = '<D-…> ', S = '<S-…> ',
      CR = '<CR> ', Esc = '<Esc> ', ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ', NL = '<NL> ', BS = '<BS> ',
      Space = '<Space> ', Tab = '<Tab> ',
    },
  },
  spec = {
    { '<leader>b', group = '[B]uffer' },
    { '<leader>c', group = '[C]ode' },
    { '<leader>d', group = '[D]ebug' },
    { '<leader>e', group = '[E]xplorer' },
    { '<leader>f', group = '[F]ind' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { '<leader>m', group = '[M]arkdown' },
    { '<leader>o', group = '[O]bsidian' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>w', group = '[W]indow' },
    { '<leader>x', group = 'Trouble/Diagnostics' },
  },
}
