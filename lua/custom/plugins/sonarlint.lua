return {
  'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'lewis6991/gitsigns.nvim', -- Optional: Required for SCM/Connected Mode features
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    -- Determine the path to the mason installation directory
    local mason_root = vim.fn.stdpath 'data' .. '/mason'

    require('sonarlint').setup {
      server = {
        flags = {
          debounce_text_changes = 3000, -- Increase debounce to reduce server load
        },
        on_attach = function(client, _)
          -- Ensure diagnostics only update when leaving Insert mode
          vim.diagnostic.config({ update_in_insert = false }, vim.lsp.diagnostic.get_namespace(client.id))
        end,
        cmd = {
          'sonarlint-language-server',
          '-stdio',
          '-analyzers',
          -- Add paths to the analyzers you need here.
          -- Mason typically installs them in share/sonarlint-analyzers/
          mason_root .. '/share/sonarlint-analyzers/sonarjava.jar',
          mason_root .. '/share/sonarlint-analyzers/sonarpython.jar',
          mason_root .. '/share/sonarlint-analyzers/sonargo.jar',
          mason_root .. '/share/sonarlint-analyzers/sonarjs.jar',
          mason_root .. '/share/sonarlint-analyzers/sonarhtml.jar',
          mason_root .. '/share/sonarlint-analyzers/sonarxml.jar',
          mason_root .. '/share/sonarlint-analyzers/sonariac.jar',
        },
      },
      filetypes = {
        'python',
        'java',
        'cpp',
        'c',
        'go',
        'javascript',
        'typescript',
        'html',
        'xml',
        'terraform',
        'json',
        'yaml',
      },
    }
  end,
}
