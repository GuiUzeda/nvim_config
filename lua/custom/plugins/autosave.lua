return {
  'okuuva/auto-save.nvim',
  version = '^1.0.0', -- see https://dev.to/okuuva/the-best-autosave-plugin-in-neovim-3d78
  cmd = 'ASToggle', -- optional for lazy loading on command
  event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
  opts = {
    -- your config goes here
    -- or just leave it empty :)
  },
}
