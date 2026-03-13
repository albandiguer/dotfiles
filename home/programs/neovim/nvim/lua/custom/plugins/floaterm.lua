return {
  'nvzone/floaterm',
  dependencies = 'nvzone/volt',
  cmd = 'FloatermToggle',
  keys = {
    { '<leader>t', '<cmd>FloatermToggle<CR>', desc = 'Toggle floating terminal' },
  },
  opts = {
    size = { h = 95, w = 95 },
  },
}
