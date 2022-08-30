require("nvim-treesitter.configs").setup({
	-- Modules and its options go here
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	ensure_installed = {
		"javascript",
		"lua",
		"vim",
		"typescript",
		"python",
		"nix",
		"markdown",
	},
})

require("treesitter-context").setup({
	enable = true,
})
