return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      pipe_table = {
        -- 'overlay' writes completely over the table, removing conceal behavior and highlights
        -- inside the table cells. This guarantees perfect table borders regardless of bold/italic conceal.
        cell = 'overlay',
      },
    },
  },
}
