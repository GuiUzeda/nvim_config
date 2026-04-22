-- lua/config/trouble.lua
require('trouble').setup()

local function tmap(keys, cmd, desc)
  vim.keymap.set('n', keys, cmd, { desc = desc })
end

tmap('<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics (Trouble)')
tmap('<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics (Trouble)')
tmap('<leader>q', '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics (Trouble)')
tmap('<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', 'Symbols (Trouble)')
tmap('<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', 'LSP Definitions / references / ... (Trouble)')
tmap('<leader>xL', '<cmd>Trouble loclist toggle<cr>', 'Location List (Trouble)')
tmap('<leader>xQ', '<cmd>Trouble qflist toggle<cr>', 'Quickfix List (Trouble)')

vim.keymap.set('n', '[q', function()
  if require('trouble').is_open() then
    require('trouble').prev { skip_groups = true, jump = true }
  else
    local ok, err = pcall(vim.cmd.cprev)
    if not ok then vim.notify(err, vim.log.levels.ERROR) end
  end
end, { desc = 'Previous Trouble/Quickfix Item' })

vim.keymap.set('n', ']q', function()
  if require('trouble').is_open() then
    require('trouble').next { skip_groups = true, jump = true }
  else
    local ok, err = pcall(vim.cmd.cnext)
    if not ok then vim.notify(err, vim.log.levels.ERROR) end
  end
end, { desc = 'Next Trouble/Quickfix Item' })

vim.keymap.set('n', '[d', function()
  require('trouble').prev { mode = 'diagnostics', skip_groups = true, jump = true }
end, { desc = 'Previous Diagnostic (Trouble)' })

vim.keymap.set('n', ']d', function()
  require('trouble').next { mode = 'diagnostics', skip_groups = true, jump = true }
end, { desc = 'Next Diagnostic (Trouble)' })
