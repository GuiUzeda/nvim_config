return {
  -- The engine that manages the terminal window
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- General settings for all terminals
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return math.floor(vim.o.columns * 0.15)
        end
      end,
    }

    -- Create a specific "Gemini" terminal instance
    local Terminal = require('toggleterm.terminal').Terminal

    local gemini = Terminal:new {
      cmd = 'gemini',

      hidden = true, -- Keep running in background when closed (saves chat history)
      direction = 'vertical',

      -- 🎨 The "Left Side" Logic
      on_open = function(term)
        vim.cmd 'wincmd L'

        -- Optional: Map <Esc> to exit insert mode inside the terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
      end,

      on_close = function(term)
        -- Optional cleanup
      end,
    }

    -- Define the Toggle Function
    function _gemini_toggle()
      gemini:toggle()
    end

    -- 🎹 Keybinding: Leader + g
    vim.keymap.set('n', '<leader>g', '<cmd>lua _gemini_toggle()<CR>', { noremap = true, silent = true, desc = 'Toggle Gemini AI' })
  end,
}
