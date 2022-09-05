-- Telescope config
map('n', '<leader>f', '<cmd>Telescope find_files<cr>')
map('n', '<leader>g', '<cmd>Telescope live_grep<cr>')
map('n', ';', '<cmd>Telescope buffers<cr>')
-- grep current word
map('n', 'K', '<cmd>Telescope grep_string<cr>')
