return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  init = function()
    -- Reusable function to register keymaps in different contexts
    local function set_keymaps()
      vim.keymap.set({ 'n', 't', 'v' }, '<C-h>', '<cmd>TmuxNavigateLeft<cr>')
      vim.keymap.set({ 'n', 't', 'v' }, '<C-j>', '<cmd>TmuxNavigateDown<cr>')
      vim.keymap.set({ 'n', 't', 'v' }, '<C-k>', '<cmd>TmuxNavigateUp<cr>')
      vim.keymap.set({ 'n', 't', 'v' }, '<C-l>', '<cmd>TmuxNavigateRight<cr>')
    end

    -- Register once globally
    set_keymaps()

    -- Re-register for terminal buffers to prevent literal command injection
    vim.api.nvim_create_autocmd('TermOpen', {
      callback = set_keymaps,
    })
  end,
}
