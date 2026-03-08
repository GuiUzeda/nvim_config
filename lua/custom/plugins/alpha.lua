return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Set header (ASCII art)
    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button('e', '  New file', '<cmd>ene <BAR> startinsert <cr>'),
      dashboard.button('f', '󰈞  Find file', '<cmd>Telescope find_files<cr>'),
      dashboard.button('r', '󰄉  Recent files', '<cmd>Telescope oldfiles<cr>'),
      dashboard.button('g', '󰱼  Find text', '<cmd>Telescope live_grep<cr>'),
      dashboard.button('c', '  Configuration', '<cmd>e $MYVIMRC <cr>'),
      dashboard.button('z', '󰒲  Lazy', '<cmd>Lazy<cr>'),
      dashboard.button('q', '󰅚  Quit Neovim', '<cmd>qa<cr>'),
    }

    -- Set footer
    local function footer()
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return '󱐌 Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
    end

    dashboard.section.footer.val = footer()

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
