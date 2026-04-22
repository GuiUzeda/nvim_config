-- lua/config/neo-tree.lua
require('neo-tree').setup {
  log_level = 'debug',
  log_to_file = true,
  diagnostics = { enable = true, show_name = true },
  filesystem = { window = { mappings = { ['\\'] = 'close_window' } } },
  event_handlers = {
    {
      event = 'file_opened',
      handler = function() require('neo-tree.command').execute { action = 'close' } end,
    },
    {
      event = 'file_moved',
      handler = function(data) require('lsp-file-operations').on_file_moved(data.source, data.destination) end,
    },
    {
      event = 'file_renamed',
      handler = function(data) require('lsp-file-operations').on_file_renamed(data.source, data.destination) end,
    },
  },
}

-- Keymaps
vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
vim.keymap.set('n', '<leader>ee', '<cmd>Neotree toggle<cr>', { desc = 'Explorer NeoTree (Toggle)' })
vim.keymap.set('n', '<leader>ef', '<cmd>Neotree focus<cr>', { desc = 'Explorer NeoTree (Focus)' })
vim.keymap.set('n', '<leader>er', '<cmd>Neotree reveal<cr>', { desc = 'Explorer NeoTree (Reveal)' })
