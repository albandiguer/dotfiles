-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
	git = {
		ignore = true,
	},
	view = {
		width = {
			min = 30,
			max = 40
		}
	},
	filters = {
		dotfiles = false,
	},
	renderer = {
		full_name = false
	},
})

map('n', '<C-n>', ':NvimTreeToggle')
map('n', '<C-b>', ':NvimTreeFindFile<CR>')
