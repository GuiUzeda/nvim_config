local M = {}

---Auto-completion for Obsidian folders
---@param ArgLead string
---@param CmdLine string
---@param CursorPos integer
---@return table
function M.folder_complete(ArgLead, CmdLine, CursorPos)
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

---Interactive creation of a new Obsidian note with templates and advanced options
function M.new_note_advanced()
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

          vim.g.obsidian_current_title = title
          vim.cmd('ObsidianNew ' .. full_path_arg)

          if template ~= 'None' then
            vim.defer_fn(function()
              -- Clear the buffer completely to avoid duplicating frontmatter and titles
              vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
              vim.cmd('ObsidianTemplate ' .. template)
              vim.defer_fn(function()
                vim.g.obsidian_current_title = nil
              end, 100)
            end, 200)
          else
            vim.g.obsidian_current_title = nil
          end
        end)
      end

      if folder == '+ Create New Folder' then
        vim.ui.input({
          prompt = 'New Folder Name (e.g. 01_Projects/NewApp): ',
          completion = 'customlist,v:lua.require"custom.obsidian_utils".folder_complete',
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
end

return M
