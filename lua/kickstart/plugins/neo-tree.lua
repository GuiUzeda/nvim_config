-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>ee', '<cmd>Neotree toggle<cr>', desc = 'Explorer NeoTree (Toggle)' },
    { '<leader>ef', '<cmd>Neotree focus<cr>', desc = 'Explorer NeoTree (Focus)' },
    { '<leader>er', '<cmd>Neotree reveal<cr>', desc = 'Explorer NeoTree (Reveal)' },
  },
  opts = {
    diagnostics = {
      enable = true,
      show_name = true,
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function()
          -- Close neo-tree when a file is opened
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
      {
        event = 'neo_tree_window_after_open',
        handler = function()
          vim.api.nvim_create_autocmd('WinLeave', {
            once = true,
            callback = function()
              vim.cmd 'Neotree close'
            end,
          })
        end,
      },
      {
        event = 'file_moved',
        handler = function(data)
          require('lsp-file-operations').on_file_moved(data.source, data.destination)
        end,
      },
      {
        event = 'file_renamed',
        handler = function(data)
          require('lsp-file-operations').on_file_renamed(data.source, data.destination)
        end,
      },
    },
  },
}
