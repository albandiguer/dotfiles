return {
  'stevearc/overseer.nvim',
  keys = {
    { '<leader>kr', '<cmd>OverseerRun<cr>', desc = 'Tas[k] Run' },
    { '<leader>kk', '<cmd>OverseerToggle<cr>', desc = 'Tas[k] Toggle' },
  },
  config = function()
    require('overseer').setup()
  end,
}
