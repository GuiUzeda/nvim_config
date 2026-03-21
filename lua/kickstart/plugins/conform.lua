return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run these sequentially as per your requested commands
        python = { 'autoflake', 'autopep8', 'black', 'isort' },
        go = { 'goimports', 'gofumpt' },
        --
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
      },
      formatters = {
        autoflake = {
          -- Match your requested flags
          args = {
            '--remove-all-unused-imports',
            '--remove-unused-variables',
            '--expand-star-imports',
            '--remove-duplicate-keys',
            '--ignore-init-module-imports',
            '--in-place',
            '--stdin-display-name',
            '$FILENAME',
            '-',
          },
        },
        autopep8 = {
          -- Match your requested flags: aggressive and line-length 120
          prepend_args = { '--aggressive', '--max-line-length', '120' },
        },
        black = {
          -- Match your requested line-length 120
          prepend_args = { '--line-length', '120' },
        },
        isort = {
          -- Match your requested profile black
          prepend_args = { '--profile', 'black' },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
