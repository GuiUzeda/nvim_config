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
        virt_texts_line_pos = 'right_align',
        -- Highlight the entire line like Error Lens
        softwrap = 15, -- Allow some wrapping but keep it neat
      },
    }

    -- Disable the default Neovim virtual text to avoid duplication
    vim.diagnostic.config { virtual_text = false }
  end,
}
