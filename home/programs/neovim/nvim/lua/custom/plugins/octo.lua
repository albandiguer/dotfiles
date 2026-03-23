return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  opts = {
    picker = 'telescope',
    enable_builtin = true,
  },
  keys = {
    { '<leader>Of', '<CMD>Octo search<CR>', desc = 'Octo fuzzy search' },
    { '<leader>Op', '<CMD>Octo pr list<CR>', desc = 'Octo list PRs' },
    { '<leader>Oi', '<CMD>Octo issue list<CR>', desc = 'Octo list Issues' },
    { '<leader>Or', '<CMD>Octo review start<CR>', desc = 'Octo start PR Review' },
    { '<leader>Oc', '<CMD>Octo comment add<CR>', desc = 'Octo add Comment' },
    { '<leader>OC', '<CMD>Octo review comments<CR>', desc = 'Octo review Comments' },
    { '<leader>Os', '<CMD>Octo review submit<CR>', desc = 'Octo submit Review' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
}
