local opt = vim.opt
local g = vim.g

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- g.mapleader = ","

-- opt.colorscheme = 'grb256'
-- g.g:context_nvim_no_redraw thats for context.vim
opt.colorcolumn = "80"
opt.mouse = "a"
opt.number = true
opt.smartcase = true -- search with smart case
opt.termguicolors = true
