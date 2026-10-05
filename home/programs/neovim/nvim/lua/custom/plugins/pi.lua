-- pi.nvim — minimal pi coding-agent integration
-- https://github.com/pablopunk/pi.nvim
-- Config leans on pi's own defaults (~/.pi/agent/settings.json).
return {
  'pablopunk/pi.nvim',
  cmd = { 'PiAsk', 'PiAskSelection', 'PiCancel', 'PiLog' },
  keys = {
    { '<leader>pa', ':PiAsk<CR>', desc = 'Ask pi (buffer)' },
    { '<leader>pa', ':PiAskSelection<CR>', mode = 'v', desc = 'Ask pi (selection)' },
    { '<leader>pc', ':PiCancel<CR>', desc = 'Cancel pi request' },
    { '<leader>pl', ':PiLog<CR>', desc = 'Show pi session log' },
  },
  config = function()
    require('pi').setup {
      context = { diagnostics = { enabled = true } },
    }
  end,
}
