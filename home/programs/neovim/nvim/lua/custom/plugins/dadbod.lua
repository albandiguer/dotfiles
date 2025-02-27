return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
    },
    after = 'vim-dadbod',
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    cmd = { 'DB', 'DBUI' },
    keys = {
      { '<leader>db', '<cmd>DBUI<CR>', { desc = 'Open DBUI' } },
    },
    config = function()
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_execute_on_save = 0 -- safer
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 35
      vim.g.db_ui_winheight = 15
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_table_helpers = {
        postgres = {
          select = 'SELECT * FROM %s LIMIT 100',
          count = 'SELECT COUNT(*) FROM %s',
          delete = 'DELETE FROM %s WHERE id = ?',
          update = 'UPDATE %s SET name = ? WHERE id = ?',
          insert = 'INSERT INTO %s (name) VALUES (?)',
        },
      }
    end,
  },
}
