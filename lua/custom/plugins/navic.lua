return {
  'SmiteshP/nvim-navic',
  dependencies = { 'neovim/nvim-lspconfig' },
  opts = {
    highlight = true,
    separator = '  ',
    depth_limit = 0,
    depth_limit_indicator = '..',
    safe_output = true,
    icons = {
      File = ' ',
      Module = ' ',
      Namespace = ' ',
      Package = ' ',
      Class = ' ',
      Method = ' ',
      Property = ' ',
      Field = ' ',
      Constructor = ' ',
      Enum = ' ',
      Interface = ' ',
      Function = ' ',
      Variable = ' ',
      Constant = ' ',
      String = ' ',
      Number = ' ',
      Boolean = ' ',
      Array = ' ',
      Object = ' ',
      Key = ' ',
      Null = ' ',
      EnumMember = ' ',
      Struct = ' ',
      Event = ' ',
      Operator = ' ',
      TypeParameter = ' ',
    },
  },
  config = function(_, opts)
    local navic = require 'nvim-navic'
    navic.setup(opts)

    -- Set winbar
    vim.api.nvim_create_autocmd({ 'DirChanged', 'BufEnter', 'BufWinEnter' }, {
      callback = function()
        if navic.is_available() then
          vim.opt_local.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
        else
          vim.opt_local.winbar = ''
        end
      end,
    })

    -- Add it to LSP attach in kickstart
    -- We can also do it globally here
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.documentSymbolProvider then
          navic.attach(client, args.buf)
        end
      end,
    })
  end,
}
