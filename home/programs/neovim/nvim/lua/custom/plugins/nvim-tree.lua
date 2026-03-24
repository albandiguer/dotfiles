return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<C-b>', ':NvimTreeFindFile<CR>', desc = 'Tree Focus' },
    { '<C-n>', ':NvimTreeToggle<CR>', desc = 'Tree Toggle' },
  },
  config = function()
    require('nvim-tree').setup {
      filters = {
        dotfiles = false,
        custom = function(path)
          return path:match '%-meta%.xml$' ~= nil
        end,
      },
      view = {
        width = {
          min = 35,
          max = 45,
        },
      },
      renderer = {
        group_empty = true,
        full_name = false,
      },
      git = {
        ignore = false,
      },
    }
  end,
}
