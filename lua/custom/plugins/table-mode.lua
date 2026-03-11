return {
  'dhruvasagar/vim-table-mode',
  ft = 'markdown',
  keys = {
    { '<leader>tm', '<cmd>TableModeToggle<cr>', desc = '[T]able [M]ode Toggle' },
    { '<leader>tr', '<cmd>TableModeRealign<cr>', desc = '[T]able [R]ealign' },
  },
  config = function()
    -- Enable Markdown-compatible table corner characters
    vim.g.table_mode_corner = '|'
  end,
}
