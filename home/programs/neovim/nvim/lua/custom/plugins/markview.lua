return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  ft = { 'markdown' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('markview').setup {
      markdown_inline = {
        enable = true,
        checkboxes = {
          enable = true,
          checked = { text = '☑', hl = 'MarkviewCheckboxChecked' },
          unchecked = { text = '☐', hl = 'MarkviewCheckboxUnchecked' },
        },
        block_references = { enable = true, default = {} },
        emails = { enable = true, default = {} },
        embed_files = { enable = true, default = {} },
        emoji_shorthands = { enable = true },
        entities = { enable = true },
        escapes = { enable = true },
        footnotes = { enable = true, default = {} },
        highlights = { enable = true, default = {} },
        hyperlinks = { enable = true, default = {} },
        images = { enable = true, default = {} },
        inline_codes = { enable = true },
        internal_links = { enable = true, default = {} },
        uri_autolinks = { enable = true, default = {} },
      },
    }
  end,
}
