return {
  'coder/claudecode.nvim',
  opts = {
    terminal = {
      provider = 'native',
      split_side = 'right',
      split_width_percentage = 0.30,
    },
  },
  keys = {
    { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude Code' },
    { '<leader>ca', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Ask Claude (send selection)' },
    { '<leader>cx', '<cmd>ClaudeCodeFocus<cr>', desc = 'Execute/focus Claude Code' },
    { '<leader>cr', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
    { '<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
    { '<leader>cA', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
    { '<leader>cD', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
  },
}
