return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  config = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_browser = 'firefox'
  end,
}

-- return {
--   'toppair/peek.nvim',
--   event = { 'VeryLazy' },
--   build = 'deno task --quiet build:fast',
--   config = function()
--     require('peek').setup()
--     vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
--     vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
--   end,
-- }
