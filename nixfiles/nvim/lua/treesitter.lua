require("nvim-treesitter.configs").setup({
	-- Modules and its options go here
	parser_install_dir = "~/.config/treesitter",
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	ensure_installed = {
		"javascript",
		"lua",
		"markdown",
		"python",
		"nix",
		"python",
		"ruby",
		"typescript",
		"vim",
	},
})

require("treesitter-context").setup({
	enable = true,
})
