return {
  'stevearc/overseer.nvim',
  keys = {
    { '<leader>kr', '<cmd>OverseerRun<cr>', desc = 'Tas[k] Run' },
    { '<leader>kk', '<cmd>OverseerToggle<cr>', desc = 'Tas[k] Toggle' },
    {
      '<leader>kt',
      function()
        if vim.bo.filetype ~= 'ruby' then
          return
        end
        local file = vim.fn.expand '%'
        local line = vim.fn.line '.'
        require('overseer').new_task({ cmd = { 'bin/rspec', file .. ':' .. line } }):start()
      end,
      desc = 'Tas[k] rspec at cursor',
    },
    {
      '<leader>kT',
      function()
        if vim.bo.filetype ~= 'ruby' then
          return
        end
        local file = vim.fn.expand '%'
        require('overseer').new_task({ cmd = { 'bin/rspec', file } }):start()
      end,
      desc = 'Tas[k] rspec file',
    },
  },
  config = function()
    require('overseer').setup()
  end,
}
