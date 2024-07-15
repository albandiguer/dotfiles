require("trouble").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	action_keys = {
		cancel = ")",   -- close the list
		hover = "K",    -- opens a small popup with the full multiline message
	},
	auto_close = true, -- auto close list when empty
	height = 14
})

map("n", "(", ":Trouble document_diagnostics<CR>")
map("n", "gd", ":Trouble lsp_definitions<CR>")
map("n", "gt", ":Trouble lsp_type_definitions<CR>")
map("n", "gi", ":Trouble lsp_implementations<CR>")
map("n", "gr", ":Trouble lsp_references<CR>")
