return {
  'nickjvandyke/opencode.nvim',
  version = '*',
  dependencies = {
    {
      'folke/snacks.nvim',
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...) return require('opencode').snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
        terminal = {},
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}

    vim.o.autoread = true

    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ox', function() require('opencode').select() end, { desc = 'Execute opencode action' })
    vim.keymap.set({ 'n', 't' }, '<leader>oo', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })
    vim.keymap.set('n', '<leader>ou', function() require('opencode').command('session.half.page.up') end, { desc = 'Scroll opencode up' })
    vim.keymap.set('n', '<leader>od', function() require('opencode').command('session.half.page.down') end, { desc = 'Scroll opencode down' })
  end,
}
