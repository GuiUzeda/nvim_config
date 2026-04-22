-- lua/lsp/init.lua
-- Neovim 0.12 Native LSP Configuration

-- Add a native command to easily view LSP logs
vim.api.nvim_create_user_command('LspLog', function()
  local path = vim.lsp.log.get_filename()
  vim.cmd('tabedit ' .. vim.fn.fnameescape(path))
end, { desc = 'Open native Neovim LSP log' })

-- 1. Diagnostic Configuration
vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = false,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = false,
}

-- 2. Mason Setup
require('mason').setup({})
require('mason-lspconfig').setup({})

-- 3. Capabilities (Blink integration)
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- 4. Global LspAttach Logic
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local bufnr = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    
    local function map(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    -- Core Mappings
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction')
    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
    
    -- Python Specific Keymaps (grv)
    -- Map it for any python file, the function itself handles checking for the client
    if vim.bo[bufnr].filetype == 'python' then
      map('grv', function() require('lsp.python_utils').select_venv() end, '[G]oto [V]env Selection')
    end
    
    -- Highlight references
    if client and client:supports_method('textDocument/documentHighlight', bufnr) then
      local group = vim.api.nvim_create_augroup('user-lsp-highlight-' .. bufnr, { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = bufnr,
        group = group,
        callback = function() pcall(vim.lsp.buf.document_highlight) end,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = bufnr,
        group = group,
        callback = function() pcall(vim.lsp.buf.clear_references) end,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('user-lsp-detach-' .. bufnr, { clear = true }),
        callback = function(event2)
          pcall(vim.lsp.buf.clear_references)
          pcall(vim.api.nvim_clear_autocmds, { group = 'user-lsp-highlight-' .. event2.buf, buffer = event2.buf })
        end,
      })
    end

    -- Code Lens
    if client and client:supports_method('textDocument/codeLens', bufnr) then
      local codelens_group = vim.api.nvim_create_augroup('user-lsp-codelens-' .. bufnr, { clear = false })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = bufnr,
        group = codelens_group,
        callback = function() pcall(vim.lsp.codelens.refresh, { bufnr = bufnr }) end,
      })
      
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('user-lsp-detach-codelens-' .. bufnr, { clear = true }),
        callback = function(event2)
          pcall(vim.api.nvim_clear_autocmds, { group = 'user-lsp-codelens-' .. event2.buf, buffer = event2.buf })
        end,
      })
      map('<leader>cc', vim.lsp.codelens.run, '[C]ode [C]odeLens Run')
    end
  end,
})

-- 5. Server Definitions
local servers = {
  gopls = {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.mod', 'go.work', '.git' },
  },
  basedpyright = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pipfile', 'pyrightconfig.json', '.git' },
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'openFilesOnly',
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'recommended',
        },
      },
    },
  },
  ruff = { 
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },
  },
  ts_ls = { 
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  },
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    settings = {
      Lua = { runtime = { version = 'LuaJIT' }, workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } } },
    },
  },
}

-- 6. Register and Enable Servers
for name, config in pairs(servers) do
  config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

-- 7. Specialized Native Configs (Beancount)
vim.lsp.config('beancount', {
  cmd = { 'beancount-language-server', '--stdio' },
  filetypes = { 'beancount', 'bean' },
  root_dir = vim.fn.expand '~/tracking',
  capabilities = capabilities,
})
vim.lsp.enable 'beancount'
