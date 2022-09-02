-- Setup lspconfig.
-- https://github.com/hrsh7th/cmp-nvim-lsp
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- interesting stuff here with ftplugin https://teukka.tech/luanvim.html
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workleader_folder, bufopts)
	-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workleader_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, bufopts)

	-- VISIT https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#choosing-a-client-for-formatting
	if client.name == "tsserver" then
		-- let null-ls do the formatting
		client.resolved_capabilities.document_formatting = false
	end
end

local lspconfig = require("lspconfig")

-- Options for the lsps setup
local options = {
	capabilities = capabilities,
	on_attach = on_attach,
}

-- TODO move all this in ftplugin
-- Register handlers for languages, is that the right way to do?
lspconfig.tsserver.setup(options)
lspconfig.jedi_language_server.setup(options)
lspconfig.tflint.setup(options)
-- lspconfig.vimls.setup(options)
lspconfig.rnix.setup(options)
lspconfig.sorbet.setup(options)
