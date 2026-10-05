-- Global keymaps. See `:help vim.keymap.set()`.

-- Clear search highlight on <Esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode (normally <C-\><C-n>)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('i', '<C-k>', '<space>->')
vim.keymap.set('i', '<C-c>', '<esc>')
vim.keymap.set('n', '<M-a>', '<esc>ggVG', { desc = 'Select all' })

-- Jump to previous buffer
vim.keymap.set('n', ',,', '<c-^>', { desc = 'Previous buffer' })
