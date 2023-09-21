local opt = vim.opt
local g = vim.g

-- Functional wrapper for mapping custom keybindings
-- example: map("n", "(", "Trouble")
function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = ","               -- set leader key to comma

opt.colorcolumn = "80"          -- show 80 column
opt.mouse = "a"                 -- enable mouse
opt.relativenumber = true       -- show line numbers
opt.cursorline = false          -- highlight current line

opt.ignorecase = true           -- search with ignore case
opt.smartcase = true            -- search with smart case

opt.termguicolors = true        -- enable 24-bit RGB colors

g['context_nvim_no_redraw'] = 1 -- context-nvim avoid flickering

g['loaded_perl_provider'] = 0   -- do not load perl provider (checkhealth happy)


map('i', '<C-l>', '<space>=>')
map('i', '<C-k>', '<space>->')
map('i', '<C-c>', '<esc>')

map('n', 'Q', '<Nop>') -- disable ex mode
-- map('n', '<leader>y', '"+y') -- copy de ouf
-- map('n', 'p', 'pgvy') -- paste de ouf
-- https://twitter.com/vim_tricks/status/1545065274369609728
map('n', 'gp', '`[v`]') -- reselect pasted text
map('n', '<leader>m', ':Make')
map('n', '<leader>d', ':Dispatch')
map('n', '<leader>p', ':MarkdownPreview<CR>')
map('n', '<C-a>', '<esc>ggVG<CR>') -- select all
map('n', '<leader><leader>', '<c-^>')

map('n', '<Down>', '<Nop>')
map('n', '<Left>', '<Nop>')
map('n', '<Right>', '<Nop>')
map('n', '<Up>', '<Nop>')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
