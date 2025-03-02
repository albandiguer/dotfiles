return {
  'GeorgesAlkhouri/nvim-aider',
  -- cmd = {
  --   'AiderTerminalToggle',
  --   'AiderHealth',
  -- },
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
  config = function()
    -- Function to get API key from Bitwarden
    local function get_deepseek_api_key()
      local handle = io.popen "bw get item 'platform.deepseek.com' | jq -r '.fields.[] | select(.name == \"api-key\").value'"
      if not handle then
        return nil
      end
      local result = handle:read '*a'
      handle:close()
      return result:gsub('%s+', '') -- Remove any whitespace
    end

    local api_key = get_deepseek_api_key()
    if not api_key or api_key == '' then
      vim.notify('Failed to get Deepseek API key from Bitwarden', vim.log.levels.ERROR)
      return
    end

    require('aider').setup {
      cmd = {
        'uv',
        'tool',
        'run',
        '--from',
        'aider-chat',
        'aider',
        '--model',
        'deepseek',
        '--api-key',
        'deepseek=' .. api_key,
        '--pretty',
        '--auto-commits',
      },
    }
  end,
}
