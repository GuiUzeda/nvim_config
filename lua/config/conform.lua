-- lua/config/conform.lua
require('conform').setup {
  format_on_save = false,
  notify_on_error = true,
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_organize_imports', 'ruff_format' },
    go = { 'goimports', 'gofumpt' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    markdown = { 'prettierd', 'prettier', stop_after_first = true },
  },
  formatters = {
    autoflake = {
      args = {
        '--remove-all-unused-imports', '--remove-unused-variables', '--expand-star-imports',
        '--remove-duplicate-keys', '--ignore-init-module-imports', '--in-place',
        '--stdin-display-name', '$FILENAME', '-',
      },
    },
    autopep8 = { prepend_args = { '--aggressive', '--max-line-length', '120' } },
    black = { prepend_args = { '--line-length', '120' } },
    isort = { prepend_args = { '--profile', 'black' } },
  },
}

-- Keymap
vim.keymap.set('n', '<leader>cf', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[C]ode [F]ormat buffer' })
