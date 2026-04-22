-- lua/lsp/python_utils.lua
local M = {}

function M.find_venv(path)
  local venv_patterns = { '.venv', 'venv' }
  local util = require 'lspconfig.util'
  for _, pattern in ipairs(venv_patterns) do
    local venv_path = util.path.join(path, pattern)
    if util.path.exists(venv_path) then
      return venv_path
    end
  end
  return nil
end

function M.setup_venv_config(config, venv)
  config.settings.python.pythonPath = require('lspconfig.util').path.join(venv, 'bin', 'python')
end

return M
