return {
  'schrieveslaach/sonarlint.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'lewis6991/gitsigns.nvim', -- Optional: Required for SCM/Connected Mode features
  },
  config = function()
    -- Determine the path to the mason installation directory
    local mason_registry = require 'mason-registry'
    local mason_root = mason_registry.get_prefix()
    
    require('sonarlint').setup {
      server = {
        cmd = {
          'sonarlint-language-server',
          '-stdio',
          '-analyzers',
          -- Add paths to the analyzers you need here. 
          -- Mason typically installs them in share/sonarlint-analyzers/
          mason_root .. '/share/sonarlint-analyzers/sonarcfamily.jar',
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
