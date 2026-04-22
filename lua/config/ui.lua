-- lua/config/ui.lua
require('notify').setup {
  timeout = 3000,
  render = 'wrapped-compact',
  stages = 'static',
}

require('dressing').setup {}
