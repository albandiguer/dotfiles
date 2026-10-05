return {
  'folke/tokyonight.nvim',
  'catppuccin/nvim',
  'olivercederborg/poimandres.nvim',
  'rebelot/kanagawa.nvim',
  'sainnhe/edge',
  'sainnhe/everforest',
  'sainnhe/gruvbox-material',
  'sainnhe/sonokai',
  'slugbyte/lackluster.nvim',
  'vague2k/vague.nvim',
  {
    'wtfox/jellybeans.nvim',
    lazy = false,
    priority = 1000,
    opts = {}, -- Optional
  },

  -- Active colorscheme. Load after the others and apply it.
  {
    'savq/melange-nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'melange'
      -- Recolor float borders; re-applied on every colorscheme switch.
      local set_border = function()
        vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#ffb964' })
      end
      vim.api.nvim_create_autocmd('ColorScheme', { callback = set_border })
      set_border()
    end,
  },
}
