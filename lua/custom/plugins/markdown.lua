return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      pipe_table = {
        enabled = true,
        -- 'raw' replaces only the '|' characters in each row, leaving the cells unmodified.
        -- This is much more resilient to Neovim line wrapping and tree-sitter parsing errors
        -- (like the `\|` in Obsidian links) than 'padded' or 'overlay'.
        cell = 'raw',
      },
    },
  },
}
