require("nvim-treesitter.configs").setup({
	-- Modules and its options go here
	parser_install_dir = "~/.config/treesitter",
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	-- installed in neovim.nix
	ensure_installed = {
		-- 	"javascript",
		-- 	"lua",
		-- 	"markdown",
		-- 	"nix",
		"python",
		"ruby",
		"typescript",
		"tsx",
		-- 	"vim",
		"mermaid"
	},
})

require("treesitter-context").setup({
	enable = true,
})
