-- Disable netrw: nvim-tree (and friends) replace it. A dummy `FileExplorer`
-- augroup keeps plugins that reference it from erroring.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_augroup('FileExplorer', { clear = true })

-- Set <space> as the leader. Must happen before plugins -> keymaps are loaded.
-- See `:help mapleader`.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'

-- vim: ts=2 sts=2 sw=2 et
