-- autopairs https://github.com/windwp/nvim-autopairs
-- (blink.cmp is the completion provider here, so no nvim-cmp integration.)
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {}
  end,
}
