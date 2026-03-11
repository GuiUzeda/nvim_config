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

    -- Resize mode (Alt + h/j/k/l)
    vim.keymap.set('n', '<M-h>', ss.resize_left, { desc = 'Resize Left' })
    vim.keymap.set('n', '<M-j>', ss.resize_down, { desc = 'Resize Down' })
    vim.keymap.set('n', '<M-k>', ss.resize_up, { desc = 'Resize Up' })
    vim.keymap.set('n', '<M-l>', ss.resize_right, { desc = 'Resize Right' })

    ss.setup {
      move_cursor_same_row = false,
      multiplexer_integration = 'wezterm',
      at_edge = function(ctx)
        if vim.env.DESKTOP_SESSION == 'awesome' then
          local awesome_dir = ({ left = 'left', down = 'down', up = 'up', right = 'right' })[ctx.direction]
          os.execute(string.format("/usr/bin/awesome-client \"awesome.emit_signal('focus_direction', '%s')\" > /dev/null 2>&1 &", awesome_dir))
        end
      end,
    }
  end,
}
