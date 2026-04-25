-- lua/lsp/python_utils.lua
local M = {}

---Finds the closest virtual environment directory starting from a given path
---@param start_path string
---@return string|nil
function M.find_venv(start_path)
  return vim.fs.find({ '.venv', 'venv' }, {
    path = start_path,
    upward = true,
    type = 'directory',
  })[1]
end

---Sets the venv configuration for a basedpyright client config
---@param config table The LSP client config
---@param venv_path string The absolute path to the venv directory
function M.setup_venv_config(config, venv_path)
  local python_path = venv_path .. '/bin/python'
  local venv_root = vim.fn.fnamemodify(venv_path, ':h')
  local venv_name = vim.fn.fnamemodify(venv_path, ':t')

  config.settings = config.settings or {}
  config.settings.python = config.settings.python or {}
  config.settings.python.pythonPath = python_path

  config.settings.basedpyright = config.settings.basedpyright or {}
  config.settings.basedpyright.venvPath = venv_root
  config.settings.basedpyright.venv = venv_name
end

---Interactive venv selection for the current buffer
function M.select_venv()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { name = 'basedpyright', bufnr = bufnr }
  local client = clients[1]

  if not client then
    vim.notify('Basedpyright not attached to this buffer', vim.log.levels.WARN)
    return
  end

  local root = client.config.root_dir or vim.fn.getcwd()
  local found = vim.fs.find({ '.venv', 'venv' }, {
    path = root,
    type = 'directory',
    limit = math.huge,
  })

  if #found == 0 then
    vim.notify('No virtual environments found in ' .. root, vim.log.levels.INFO)
    return
  end

  vim.ui.select(found, {
    prompt = 'Select Python Virtual Environment',
    format_item = function(item)
      return item:gsub(root .. '/', '')
    end,
  }, function(choice)
    if choice then
      M.setup_venv_config(client.config, choice)
      vim.notify('Setting venv to ' .. choice .. ' and restarting LSP...', vim.log.levels.INFO)
      
      -- Native Neovim 0.12 LSP Restart
      client:stop(true) -- Force stop
      vim.defer_fn(function()
        vim.lsp.start(client.config, { bufnr = bufnr })
      end, 500)
    end
  end)
end

return M
