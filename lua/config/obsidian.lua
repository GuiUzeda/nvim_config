-- lua/config/obsidian.lua
require('obsidian').setup {
  workspaces = { { name = 'notes', path = '~/Notes' } },
  completion = { nvim_cmp = false, min_chars = 2 },
  ui = { enable = false },
  daily_notes = {
    folder = "Daily",
    date_format = "%Y-%m-%d",
    alias_format = "%B %-d, %Y",
    default_tags = { "daily-notes" },
    template = "Daily.md"
  },
  templates = {
    folder = vim.fn.stdpath("config") .. "/obsidian_templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    substitutions = {
      title = function()
        if vim.g.obsidian_current_title then return vim.g.obsidian_current_title end
        return "Untitled"
      end,
    },
  },
  note_id_func = function(title)
    if title ~= nil then return title else return tostring(os.time()) end
  end,
}

-- [[ Obsidian Keymaps ]]
local function map(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { desc = '[O]bsidian ' .. desc })
end

map('<leader>on', '<cmd>ObsidianQuickSwitch<cr>', 'Notes (Switch)')
map('<leader>os', '<cmd>ObsidianSearch<cr>', 'Search')
map('<leader>ot', '<cmd>ObsidianToday<cr>', 'Today')
map('<leader>oc', '<cmd>ObsidianCapture<cr>', 'Capture')
map('<leader>ol', '<cmd>ObsidianLinks<cr>', 'Links')
