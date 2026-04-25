-- lua/config/autosave.lua
require('auto-save').setup {
  enabled = true,
  trigger_events = { "InsertLeave", "TextChanged" },
  condition = function(buf)
    local fn = vim.fn
    local utils = require("auto-save.utils.data")

    if fn.getbufvar(buf, "&modifiable") == 1 and
       utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
      return true
    end
    return false
  end,
  write_delay = 2000, -- The "cooldown" (delay in ms)
  debounce_delay = 135,
  callbacks = {
    enabling = nil,
    disabling = nil,
    before_asserting_save = nil,
    before_saving = nil,
    after_saving = nil,
  },
}
