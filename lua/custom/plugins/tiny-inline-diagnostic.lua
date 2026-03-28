return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000, -- Load early to override default virtual text
  config = function()
    require('tiny-inline-diagnostic').setup {
      preset = 'modern', -- Matches the look in your image
      hi = {
        background = 'DiagnosticVirtualTextError', -- Background color for the diagnostic message
        fallback = 'DiagnosticVirtualTextError', -- Fallback color if the diagnostic group doesn't exist
      },
      options = {
        show_source = true,
        use_icons = true,
        add_missing_linebreak = true,
        -- This ensures the diagnostic doesn't collide with other virtual text
        virt_texts_line_pos = 'between_statements', -- Changed to make it more prominent
        -- Highlight the entire line like Error Lens
        softwrap = 30, -- Increased for better readability of long messages
        multiple_diag_under_cursor = true, -- Show all diagnostics under cursor
        multilines = true, -- Allow multiple lines for long errors
      },
    }

    -- Disable the default Neovim virtual text to avoid duplication
    vim.diagnostic.config { virtual_text = false }
  end,
}
