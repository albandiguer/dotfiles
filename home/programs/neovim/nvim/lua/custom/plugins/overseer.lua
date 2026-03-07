-- [recipes here](https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#restart-last-task)
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
    {
      '<leader>ka',
      function()
        local overseer = require 'overseer'
        local task_list = require 'overseer.task_list'
        local tasks = overseer.list_tasks {
          status = {
            overseer.STATUS.SUCCESS,
            overseer.STATUS.FAILURE,
            overseer.STATUS.CANCELED,
          },
          sort = task_list.sort_finished_recently,
        }
        if vim.tbl_isempty(tasks) then
          vim.notify('No tasks found', vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], 'restart')
        end
      end,
      desc = 'Tas[k] restart last (again)',
    },
  },
  config = function()
    require('overseer').setup()
  end,
}
