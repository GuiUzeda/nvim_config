return {
  'supermaven-inc/supermaven-nvim',
  event = 'InsertEnter',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<C-l>',
        clear_suggestion = '<C-]>',
        accept_word = '<C-j>',
      },
      ignore_filetypes = { 'TelescopePrompt' },
      color = {
        suggestion_color = '#808080',
      },
      disable_inline_completion = false,
    }
  end,
}
