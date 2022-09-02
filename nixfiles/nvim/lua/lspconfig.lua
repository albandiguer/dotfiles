-- Setup lspconfig.
-- https://github.com/hrsh7th/cmp-nvim-lsp
-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- local options = {
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- 	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
-- 	on_attach = function(client, bufnr)
-- 		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
-- 	end,
-- }

-- TODO move all this in ftplugin
-- Register handlers for languages, is that the right way to do?
-- lspconfig.tsserver.setup(options)
-- lspconfig.jedi_language_server.setup(options)
-- lspconfig.tflint.setup(options)
-- lspconfig.vimls.setup(options)
-- lspconfig.rnix.setup(options)
-- require("lspconfig").sorbet.setup(options)
