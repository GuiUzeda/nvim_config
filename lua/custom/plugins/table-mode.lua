return {
  'dhruvasagar/vim-table-mode',
  ft = 'markdown',
  config = function()
    -- Enable Markdown-compatible table corner characters
    vim.g.table_mode_corner = '|'
  end,
}
