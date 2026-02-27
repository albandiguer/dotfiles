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
        float = {
          enable = true,
          open_win_config = function()
            local HEIGHT_RATIO = 0.8
            local WIDTH_RATIO = 0.5
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w_int = math.floor(screen_w * WIDTH_RATIO)
            local window_h_int = math.floor(screen_h * HEIGHT_RATIO)
            local center_x = (screen_w - window_w_int) / 2
            local center_y = ((vim.opt.lines:get() - window_h_int) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * 0.5)
        end,
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
