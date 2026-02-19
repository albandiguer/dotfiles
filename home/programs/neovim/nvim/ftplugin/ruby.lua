function SendToTmuxPane(include_line)
  local current_file = vim.fn.expand '%'
  local current_line = ''

  if include_line then
    current_line = ':' .. vim.fn.line '.'
  end

  -- Correctly quote TEST_CMD to handle multiple words
  local cmd = string.format("tmux send-keys -t ':.1' 'sh -c \"%s %s%s\"' C-m", os.getenv 'TEST_CMD', current_file, current_line)
  vim.fn.system(cmd)
end

vim.api.nvim_set_keymap('n', '<Leader>t', ':lua SendToTmuxPane(true)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>T', ':lua SendToTmuxPane(false)<CR>', { noremap = true, silent = true })

require('luasnip').filetype_extend('ruby', { 'rails' })
require('luasnip').filetype_extend('eruby', { 'html' })

