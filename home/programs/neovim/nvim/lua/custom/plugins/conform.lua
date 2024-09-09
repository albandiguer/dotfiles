return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      python = { 'isort', 'black' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      json = { 'prettier' },
      -- yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      lua = { 'stylua' },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    -- Customize formatters
    formatters = {
      prettier = {
        -- exclude the repo /Users/danielmaizel/codefresh/argo-platform
        -- condition = function(ctx)
        --   return vim.fs.find({ 'argo-platform' }, { path = ctx.filename, upward = true })[1]
        -- end,
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
