-- lua/config/alpha.lua
local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

dashboard.section.header.val = {
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', '<cmd>ene <BAR> startinsert <cr>'),
  dashboard.button('f', '󰈞  Find file', '<cmd>Telescope find_files<cr>'),
  dashboard.button('r', '󰄉  Recent files', '<cmd>Telescope oldfiles<cr>'),
  dashboard.button('g', '󰱼  Find text', '<cmd>Telescope live_grep<cr>'),
  dashboard.button('c', '  Configuration', '<cmd>e $MYVIMRC <cr>'),
  dashboard.button('q', '󰅚  Quit Neovim', '<cmd>qa<cr>'),
}

dashboard.section.footer.val = { '󱐌 Neovim 0.12 Loaded' }

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
