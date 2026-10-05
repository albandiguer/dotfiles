-- Editor options. See `:help option-list`.

-- Make line numbers default
vim.o.number = true
-- vim.o.relativenumber = true

-- Enable mouse mode (useful for resizing splits)
vim.o.mouse = 'a'

-- Don't show the mode, it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim. Scheduled after `UiEnter` so it doesn't
-- slow down startup. Remove if you want the OS clipboard to stay independent.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true -- indent wrapped lines
vim.o.undofile = true -- persistent undo

-- Case-insensitive search unless \C or a capital letter is present
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 250 -- faster CursorHold
vim.o.timeoutlen = 300 -- shorter mapped-sequence wait

vim.o.splitright = true
vim.o.splitbelow = true

-- Show whitespace
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- live substitution preview
vim.o.cursorline = true

-- Keep 10 screen lines above/below the cursor
vim.o.scrolloff = 10

-- Ask to save instead of failing on `:q` with unsaved changes
vim.o.confirm = true

-- Rounded borders on all floating windows
vim.o.winborder = 'rounded'

vim.opt.hlsearch = true
vim.opt.colorcolumn = '80'

-- Allow per-project .nvim.lua / .nvimrc
vim.opt.exrc = true

-- Troubleshooting log (only written when `:set verbose>0`)
vim.o.verbosefile = vim.fn.expand '~/.nvim_verbose.log'

-- Use ripgrep for text searching
vim.g.grepprg = 'rg --vimgrep'
vim.g.grepformat = '%f:%l:%c:%m,%f:%l:%m'
