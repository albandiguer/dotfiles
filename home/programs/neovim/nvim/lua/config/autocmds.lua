-- Autocommands. See `:help lua-guide-autocommands`.

-- Highlight when yanking (try `yap` in normal mode)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
