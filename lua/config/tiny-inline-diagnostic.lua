-- lua/config/tiny-inline-diagnostic.lua
require('tiny-inline-diagnostic').setup {
  preset = 'modern',
  hi = {
    background = 'DiagnosticVirtualTextError',
    fallback = 'DiagnosticVirtualTextError',
  },
  options = {
    show_source = true,
    use_icons = true,
    add_missing_linebreak = true,
    virt_texts_line_pos = 'between_statements',
    softwrap = 30,
    multiple_diag_under_cursor = true,
    multilines = true,
  },
}
