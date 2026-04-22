-- lua/config/ui.lua
require('notify').setup {
  timeout = 3000,
  render = 'wrapped-compact',
  stages = 'static',
}

require('dressing').setup {}

require('noice').setup {
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
  routes = {
    { filter = { event = 'notify', find = 'No information available' }, opts = { skip = true } },
    { filter = { event = 'msg_show', any = { { find = '%d+L, %d+B' }, { find = '; after #%d+' }, { find = '; before #%d+' } } }, view = 'mini' },
  },
}
