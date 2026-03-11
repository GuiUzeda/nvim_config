-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Obsidian keymaps for fast notes access
_G.obsidian_folder_complete = function(ArgLead, CmdLine, CursorPos)
  local vault_path = vim.fn.expand '~/Notes'
  local ok, scan = pcall(require, 'plenary.scandir')
  if not ok then
    return {}
  end

  local success, dirs = pcall(scan.scan_dir, vault_path, { hidden = false, only_dirs = true })
  if not success then
    return {}
  end

  local results = {}
  for _, dir in ipairs(dirs) do
    local rel_path = dir:sub(#vault_path + 2)
    if rel_path:sub(1, #ArgLead) == ArgLead then
      table.insert(results, rel_path)
    end
  end
  table.sort(results)
  return results
end

vim.keymap.set('n', '<leader>on', '<cmd>ObsidianQuickSwitch<cr>', { desc = '[O]bsidian [N]otes (Switch)' })
vim.keymap.set('n', '<leader>os', '<cmd>ObsidianSearch<cr>', { desc = '[O]bsidian [S]earch' })
vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianToday<cr>', { desc = '[O]bsidian [T]oday' })
vim.keymap.set('n', '<leader>ow', function()
  local vault_path = vim.fn.expand '~/Notes'

  vim.ui.input({ prompt = 'Note Title: ' }, function(title)
    if not title or title == '' then
      return
    end

    local scan = require 'plenary.scandir'
    local dirs = scan.scan_dir(vault_path, { hidden = false, only_dirs = true })

    local folder_opts = { '/' }
    for _, dir in ipairs(dirs) do
      local rel_path = dir:sub(#vault_path + 2)
      table.insert(folder_opts, rel_path)
    end
    table.insert(folder_opts, '+ Create New Folder')

    vim.ui.select(folder_opts, { prompt = 'Select Directory:' }, function(folder)
      if not folder then
        return
      end

      local function next_step(chosen_folder)
        local template_dir = vim.fn.stdpath 'config' .. '/obsidian_templates'
        local templates = { 'None' }
        local tmpl_files = scan.scan_dir(template_dir, { hidden = false, depth = 1 })
        for _, tmpl in ipairs(tmpl_files) do
          table.insert(templates, vim.fn.fnamemodify(tmpl, ':t'))
        end

        vim.ui.select(templates, { prompt = 'Select Template:' }, function(template)
          if not template then
            return
          end

          local full_path_arg = title
          if chosen_folder ~= '/' then
            full_path_arg = chosen_folder .. '/' .. title
          end

          vim.cmd('ObsidianNew ' .. full_path_arg)

          if template ~= 'None' then
            vim.defer_fn(function()
              -- Clear the buffer completely to avoid duplicating frontmatter and titles
              vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
              vim.cmd('ObsidianTemplate ' .. template)
            end, 200)
          end
        end)
      end

      if folder == '+ Create New Folder' then
        vim.ui.input({
          prompt = 'New Folder Name (e.g. 01_Projects/NewApp): ',
          completion = 'customlist,v:lua.obsidian_folder_complete',
        }, function(new_folder)
          if not new_folder or new_folder == '' then
            return
          end
          vim.fn.mkdir(vault_path .. '/' .. new_folder, 'p')
          next_step(new_folder)
        end)
      else
        next_step(folder)
      end
    end)
  end)
end, { desc = '[O]bsidian Ne[W] Note (Advanced)' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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
