-- lua/config/blink.lua
require('blink.cmp').setup {
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  fuzzy = { implementation = "prefer_rust" },
  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
    ghost_text = { enabled = false },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'omni' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },
  snippets = { preset = 'default' },
  signature = { enabled = true },
}
