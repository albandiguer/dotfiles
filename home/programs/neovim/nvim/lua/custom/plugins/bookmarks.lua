return {
  'MattesGroeger/vim-bookmarks',
  init = function()
    -- Register keymaps with descriptions for which-key
    vim.keymap.set('n', 'mm', '<cmd>BookmarkToggle<CR>', { desc = 'Toggle bookmark' })
    vim.keymap.set('n', 'mi', '<cmd>BookmarkAnnotate<CR>', { desc = 'Annotate bookmark' })
    vim.keymap.set('n', 'mn', '<cmd>BookmarkNext<CR>', { desc = 'Next bookmark' })
    vim.keymap.set('n', 'mp', '<cmd>BookmarkPrev<CR>', { desc = 'Prev bookmark' })
    vim.keymap.set('n', 'ma', '<cmd>BookmarkShowAll<CR>', { desc = 'Show all bookmarks' })
    vim.keymap.set('n', 'mc', '<cmd>BookmarkClear<CR>', { desc = 'Clear bookmarks (buffer)' })
    vim.keymap.set('n', 'mx', '<cmd>BookmarkClearAll<CR>', { desc = 'Clear all bookmarks' })
    vim.keymap.set('n', 'mkk', '<cmd>BookmarkMoveUp<CR>', { desc = 'Move bookmark up' })
    vim.keymap.set('n', 'mjj', '<cmd>BookmarkMoveDown<CR>', { desc = 'Move bookmark down' })
  end,
}
