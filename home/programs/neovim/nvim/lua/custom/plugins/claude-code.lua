return {
  'greggh/claude-code.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for git operations
  },
  config = function()
    require('claude-code').setup {
      window = {
        position = 'vertical', -- Use vertical split for the panel
        split_ratio = 0.3, -- 30% of screen width for vertical split
      },
    }

    -- add a keymap
    vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
  end,
}
