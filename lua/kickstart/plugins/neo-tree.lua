-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    event_handlers = {
      {
        event = 'file_renamed',
        handler = function(args)
          local client = vim.lsp.get_clients({ name = 'basedpyright' })[1]
          if client and client.supports_method 'workspace/willRenameFiles' then
            local resp = client.request_sync('workspace/willRenameFiles', {
              files = {
                {
                  oldUri = vim.uri_from_fname(args.source),
                  newUri = vim.uri_from_fname(args.destination),
                },
              },
            }, 1000, 0)
            if resp and resp.result then
              vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
            end
          end
        end,
      },
      {
        event = 'file_moved',
        handler = function(args)
          local client = vim.lsp.get_clients({ name = 'basedpyright' })[1]
          if client and client.supports_method 'workspace/willRenameFiles' then
            local resp = client.request_sync('workspace/willRenameFiles', {
              files = {
                {
                  oldUri = vim.uri_from_fname(args.source),
                  newUri = vim.uri_from_fname(args.destination),
                },
              },
            }, 1000, 0)
            if resp and resp.result then
              vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
            end
          end
        end,
      },
    },
  },
}
