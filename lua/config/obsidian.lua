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
