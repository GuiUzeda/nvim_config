return {
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          'rafamadriz/friendly-snippets',
        },
        opts = {},
      },
      'folke/lazydev.nvim',

      'olimorris/codecompanion.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {

      keymap = {
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
      },

      sources = {
        default = { 'codecompanion', 'lsp', 'path', 'snippets', 'lazydev', 'omni' },

        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },

          codecompanion = {
            name = 'CodeCompanion',
            module = 'codecompanion.providers.completion.blink',
            enabled = true,
            score_offset = 1000,
            async = true,
            min_keyword_length = 0,
          },
        },
      },

      snippets = { preset = 'luasnip' },
      signature = { enabled = true },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
