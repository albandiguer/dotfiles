require("nvim-treesitter.configs").setup({
	-- Modules and its options go here
	parser_install_dir = "~/.config/treesitter",
	highlight = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
	textobjects = { enable = true },
	-- installed in neovim.nix
	ensure_installed = {
		-- "mermaid",
		-- "python",
		-- "ruby",
		-- "tsx",
		-- "typescript"
	},
})

require("treesitter-context").setup({
	enable = true,
})
