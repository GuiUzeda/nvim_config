return {
  'mrjones2014/smart-splits.nvim',
  lazy = false, -- Load immediately to handle startup keys
  config = function()
    local ss = require 'smart-splits'

    -- Recommended Mappings (Ctrl + h/j/k/l)
    vim.keymap.set('n', '<C-h>', ss.move_cursor_left, { desc = 'Move Left' })
    vim.keymap.set('n', '<C-j>', ss.move_cursor_down, { desc = 'Move Down' })
    vim.keymap.set('n', '<C-k>', ss.move_cursor_up, { desc = 'Move Up' })
    vim.keymap.set('n', '<C-l>', ss.move_cursor_right, { desc = 'Move Right' })

    -- Optional: Resize mode (Alt + h/j/k/l)
    vim.keymap.set('n', '<M-h>', ss.resize_left)
    vim.keymap.set('n', '<M-j>', ss.resize_down)
    vim.keymap.set('n', '<M-k>', ss.resize_up)
    vim.keymap.set('n', '<M-l>', ss.resize_right)
  end,
}
