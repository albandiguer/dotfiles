-- Adds git signs to the gutter. See `lua/kickstart/plugins/gitsigns.lua` for the
-- optional recommended keymaps (`<leader>h*`).
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
