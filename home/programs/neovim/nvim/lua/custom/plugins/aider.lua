return {
  'GeorgesAlkhouri/nvim-aider',
  cmd = {
    'AiderTerminalToggle',
    'AiderHealth',
  },
  keys = {
    { '<leader>A/', '<cmd>AiderTerminalToggle<cr>', desc = 'Open Aider' },
    { '<leader>As', '<cmd>AiderTerminalSend<cr>', desc = 'Send to Aider', mode = { 'n', 'v' } },
    { '<leader>Ac', '<cmd>AiderQuickSendCommand<cr>', desc = 'Send Command To Aider' },
    { '<leader>Ab', '<cmd>AiderQuickSendBuffer<cr>', desc = 'Send Buffer To Aider' },
    { '<leader>A+', '<cmd>AiderQuickAddFile<cr>', desc = 'Add File to Aider' },
    { '<leader>A-', '<cmd>AiderQuickDropFile<cr>', desc = 'Drop File from Aider' },
    { '<leader>Ar', '<cmd>AiderQuickReadOnlyFile<cr>', desc = 'Add File as Read-Only' },
    -- Example nvim-tree.lua integration if needed
    { '<leader>A+', '<cmd>AiderTreeAddFile<cr>', desc = 'Add File from Tree to Aider', ft = 'NvimTree' },
    { '<leader>A-', '<cmd>AiderTreeDropFile<cr>', desc = 'Drop File from Tree from Aider', ft = 'NvimTree' },
  },
  dependencies = {
    'folke/snacks.nvim',
    --- The below dependencies are optional
  },
  -- config = true,
  config = function()
    require('nvim_aider').setup {
      aider_cmd = 'uv tool run  --from aider-chat aider',
    }
  end,
}
-- return {
--   'joshuavial/aider.nvim',
--   opts = {
--     -- your configuration comes here
--     -- if you don't want to use the default settings
--     auto_manage_context = true, -- automatically manage buffer context
--     default_bindings = true, -- use default <leader>A keybindings
--     debug = false, -- enable debug logging
--     command = { 'uv', 'tool', 'run', '--from', 'aider-chat', 'aider' }, -- specify the full command
--     keys = {
--       { '<leader>Ao', '<cmd>AiderOpen<cr>', desc = 'Open Aider Session' },
--       { '<leader>Am', '<cmd>AiderAddModifiedFiles<cr>', desc = 'Add Modified Files to Aider' },
--     },
--   },
-- }
