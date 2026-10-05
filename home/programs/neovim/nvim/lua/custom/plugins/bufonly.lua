return {
  'schickling/vim-bufonly',
  keys = {
    -- NOTE: `<leader>bd` instead of the default `'`: mapping `'` shadows the
    -- built-in mark-jump motion.
    { '<leader>bd', ':Bonly<CR>', desc = 'Delete all but current buffer' },
  },
}
