return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      pipe_table = {
        -- Disable table rendering because tree-sitter-markdown sees the `\|` inside
        -- Obsidian links as a column separator, breaking the table structure completely.
        enabled = false,
      },
    },
  },
}
