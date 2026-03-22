return {
  'pwntester/octo.nvim',
  cmd = 'Octo',
  opts = {
    picker = 'telescope',
    enable_builtin = true,
  },
  keys = {
    { '<leader>O', '<CMD>Octo<CR>', desc = 'Octo' },
    { '<leader>op', '<CMD>Octo pr list<CR>', desc = 'List PRs' },
    { '<leader>oi', '<CMD>Octo issue list<CR>', desc = 'List Issues' },
    { '<leader>or', '<CMD>Octo review start<CR>', desc = 'Start PR Review' },
    { '<leader>oc', '<CMD>Octo comment add<CR>', desc = 'Add Comment' },
    { '<leader>oC', '<CMD>Octo review comments<CR>', desc = 'Review Comments' },
    { '<leader>os', '<CMD>Octo review submit<CR>', desc = 'Submit Review' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
}
