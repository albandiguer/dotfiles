-- [[ Install `lazy.nvim` plugin manager ]] https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]] Run `:Lazy` to inspect, `:Lazy update` to update.
require('lazy').setup({
  -- Kickstart example plugins (the lint / gitsigns keymap variants are optional).
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',

  -- Everything in `lua/custom/plugins/*.lua`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- Use the default lazy.nvim Nerd Font icons when a Nerd Font is available,
    -- otherwise fall back to these unicode icons.
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
