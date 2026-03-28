-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Obsidian keymaps for fast notes access
vim.keymap.set('n', '<leader>on', '<cmd>ObsidianQuickSwitch<cr>', { desc = '[O]bsidian [N]otes (Switch)' })
vim.keymap.set('n', '<leader>os', '<cmd>ObsidianSearch<cr>', { desc = '[O]bsidian [S]earch' })
vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianToday<cr>', { desc = '[O]bsidian [T]oday' })
vim.keymap.set('n', '<leader>ow', require('custom.obsidian_utils').new_note_advanced, { desc = '[O]bsidian Ne[W] Note (Advanced)' })
vim.keymap.set('n', '<leader>oc', '<cmd>ObsidianCapture<cr>', { desc = '[O]bsidian [C]apture' })
vim.keymap.set('n', '<leader>ol', '<cmd>ObsidianLinks<cr>', { desc = '[O]bsidian [L]inks' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Window splits
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = '[W]indow Split [V]ertical' })
vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = '[W]indow Split [S]horizontal' })
vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = '[W]indow [C]lose' })

-- Tmux-style splits (if C-a is your prefix)
vim.keymap.set('n', '<C-a>\\', '<C-w>v', { desc = 'Window Split Vertical (Tmux-style)' })
vim.keymap.set('n', '<C-a>-', '<C-w>s', { desc = 'Window Split Horizontal (Tmux-style)' })

-- Buffer management
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = '[B]uffer [P]revious' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>', { desc = '[B]uffer [B]rowse' })

-- Move lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

-- Better indenting (stay in visual mode)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Toggles
vim.keymap.set('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = '[T]oggle [W]rap' })
vim.keymap.set('n', '<leader>ts', '<cmd>set spell!<cr>', { desc = '[T]oggle [S]pell' })
vim.keymap.set('n', '<leader>tn', '<cmd>set relativenumber!<cr>', { desc = '[T]oggle Relative [N]umber' })

-- Diagnostic keymaps
-- Mapping <leader>q moved to lua/custom/plugins/trouble.lua for better integration

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
