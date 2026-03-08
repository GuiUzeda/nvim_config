return {
  'uga-rosa/ccc.nvim',
  cmd = { 'CccPick', 'CccConvert', 'CccHighlighterEnable' },
  opts = {
    lsp = true,
    highlighter = {
      auto_enable = true,
    },
  }, -- Chama o setup() automaticamente
}
