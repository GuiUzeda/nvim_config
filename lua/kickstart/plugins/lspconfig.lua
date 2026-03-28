-- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Custom Rename Handler to automatically save buffers after rename
      local lsp_rename_handler = vim.lsp.handlers['textDocument/rename']
      vim.lsp.handlers['textDocument/rename'] = function(err, result, ctx, config)
        lsp_rename_handler(err, result, ctx, config)
        if not err and result then
          vim.cmd 'silent! wa'
          vim.notify('Renamed and saved all buffers', vim.log.levels.INFO)
        end
      end

      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Find usages (references) for the word under your cursor.
          map('gru', require('telescope.builtin').lsp_references, '[G]oto [U]sages')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Select Python virtual environment
          map('grv', require('custom.python').select_venv, '[G]oto [V]env Selection')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = false,
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      capabilities.workspace = capabilities.workspace or {}
      capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = true }

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- 2. Força o LSP a anexar considerando a pasta tracking como raiz global
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
              -- Enable workspace-wide diagnostics
              directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
              buildFlags = { '-tags=all' },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        ruff = {
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
        },
        basedpyright = {
          flags = { debounce_text_changes = 500 },
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'openFilesOnly', -- Changed from 'workspace'
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'recommended',
                autoImportCompletions = true,
                userFileWatching = true, -- Re-enabled to detect new/moved files
              },
            },
            python = {
              analysis = {
                indexing = false, -- Disabled for performance
                userFileWatching = true, -- Re-enabled to detect new/moved files
              },
            },
          },
          root_dir = function(fname)
            local util = require 'lspconfig.util'
            local root = util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pipfile', 'pyrightconfig.json', '.git')(fname)
            if root then
              return root
            end
            return util.find_git_ancestor(fname) or vim.uv.cwd()
          end,
          before_init = function(_, config)
            local python_utils = require 'custom.python'
            local venv = python_utils.find_venv(vim.fn.expand '%:p:h')
            if venv then
              python_utils.setup_venv_config(config, venv)
            end
          end,
        },
        ts_ls = {
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
          on_new_config = function(config, new_root_dir)
            -- Support Yarn PnP for TypeScript
            local pnp_js = vim.fs.find({ '.pnp.cjs', '.pnp.js' }, { path = new_root_dir, upward = true })[1]
            if pnp_js then
              -- Use the tsserver from the Yarn SDK if it exists
              local tsserver_path = vim.fs.joinpath(new_root_dir, '.yarn', 'sdks', 'typescript', 'bin', 'tsserver')
              if vim.fn.executable(tsserver_path) == 1 then
                config.cmd = { tsserver_path, '--stdio' }
              else
                -- Fallback to yarn exec if SDK isn't generated yet
                config.cmd = { 'yarn', 'exec', 'typescript-language-server', '--stdio' }
              end
            end
          end,
        },
        sqls = {},
        eslint = {
          on_attach = function(client, bufnr)
            vim.keymap.set('n', '<leader>ce', '<cmd>EslintFixAll<cr>', { buffer = bufnr, desc = '[C]ode [E]slint Fix' })
          end,
          on_new_config = function(config, new_root_dir)
            -- Support Yarn PnP
            local pnp_js = vim.fs.find({ '.pnp.cjs', '.pnp.js' }, { path = new_root_dir, upward = true })[1]
            if pnp_js then
              -- Use the eslint from the Yarn SDK if it exists
              local sdk_path = vim.fs.joinpath(new_root_dir, '.yarn', 'sdks', 'eslint', 'bin', 'eslint.js')
              if vim.fn.executable(sdk_path) == 1 then
                config.settings.nodePath = vim.fs.joinpath(new_root_dir, '.yarn', 'sdks')
              end
              config.cmd = { 'yarn', 'exec', 'vscode-eslint-language-server', '--stdio' }
            end
          end,
          settings = {
            workingDirectory = { mode = 'auto' },
            format = true,
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { [[cva\(([^)]*)\)]], [["'`]([^"'`]*).*?["'`]] },
                  { [[cx\(([^)]*)\)]], "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
            },
          },
        },
        dockerls = {},
        docker_compose_language_service = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                workspaceDelay = 3000, -- Delay for workspace diagnostics to avoid CPU spikes
              },
              completion = {
                callSnippet = 'Replace',
                keywordSnippet = 'Replace',
              },
              runtime = {
                version = 'LuaJIT',
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'tree-sitter-cli',
        'goimports',
        'gofumpt',
        'isort',
        'black',
        'autoflake',
        'autopep8',
        'ruff',
        'prettierd',
        'markdownlint',
        'sonarlint-language-server',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
      -- Configuração Nativa do Neovim 0.11 para o Beancount
      vim.lsp.config('beancount', {
        cmd = { 'beancount-language-server', '--stdio' },
        filetypes = { 'beancount', 'bean' },
        -- Trava a raiz do projeto de forma inquestionável
        root_dir = vim.fn.expand '~/tracking',
        init_options = {
          -- Caminho absoluto para a árvore de contas
          journal_file = vim.fn.expand '~/tracking/main.beancount',
          formatting = {
            prefix_width = 30,
            num_width = 10,
            currency_column = 60,
            account_amount_spacing = 2,
            number_currency_spacing = 1,
          },
          diagnostic_flags = { '!' },
          bean_check = {
            method = 'python-embedded',
          },
        },
        capabilities = capabilities,
      })

      -- Habilita o servidor
      vim.lsp.enable 'beancount'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
