-- lua/keymaps.lua
-- Centralized Keymap Configuration

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- [[ Global Mappings ]]

-- Clear search highlights
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move lines in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Better indenting (stay in visual mode)
map('v', '<', '<gv')
map('v', '>', '>gv')

-- [[ Grouped Mappings ]]

-- [B]uffer Management
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Previous [B]uffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next [B]uffer' })
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = '[B]uffer [D]elete' })
map('n', '<leader>bb', function() require('telescope.builtin').buffers() end, { desc = '[B]uffer [B]rowse (Telescope)' })

-- [W]indow Management
map('n', '<leader>wv', '<C-w>v', { desc = '[W]indow Split [V]ertical' })
map('n', '<leader>ws', '<C-w>s', { desc = '[W]indow Split [S]horizontal' })
map('n', '<leader>wc', '<C-w>c', { desc = '[W]indow [C]lose' })

-- [T]oggles
map('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = '[T]oggle [W]rap' })
map('n', '<leader>ts', '<cmd>set spell!<cr>', { desc = '[T]oggle [S]pell' })
map('n', '<leader>tn', '<cmd>set relativenumber!<cr>', { desc = '[T]oggle Relative [N]umber' })
map('n', '<leader>tr', '<cmd>restart<cr>', { desc = '[T]oggle [R]estart Neovim (Native)' })

-- [U]tils
map('n', '<leader>ut', '<cmd>Undotree<cr>', { desc = '[U]ndo [T]ree (Native)' })
map('n', '<leader>dt', '<cmd>DiffTool<cr>', { desc = '[D]iff [T]ool (Native)' })

-- [F]ind (Telescope)
-- We wrap these in functions so Telescope is only required when used.
map('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = '[F]ind [F]iles' })
map('n', '<leader>fr', function() require('telescope.builtin').oldfiles() end, { desc = '[F]ind [R]ecent Files' })
map('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = '[F]ind [B]uffers' })
map('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = '[F]ind [H]elp' })
map('n', '<leader>fk', function() require('telescope.builtin').keymaps() end, { desc = '[F]ind [K]eymaps' })

-- [S]earch (Telescope)
map('n', '<leader>sg', function() require('telescope.builtin').live_grep() end, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sw', function() require('telescope.builtin').grep_string() end, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sd', function() require('telescope.builtin').diagnostics() end, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>ss', function() require('telescope.builtin').builtin() end, { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>sr', function() require('telescope.builtin').resume() end, { desc = '[S]earch [R]esume' })
map('n', '<leader>sn', function() 
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } 
end, { desc = '[S]earch [N]eovim files' })

-- [O]bsidian (Keymaps handled by config/obsidian.lua)
-- [G]it (Keymaps handled by gitsigns.lua)
-- [X] Diagnostics (Keymaps handled by trouble.lua)
-- [C] Code (Keymaps handled by lsp/init.lua and conform.lua)

-- vim: ts=2 sts=2 sw=2 et
