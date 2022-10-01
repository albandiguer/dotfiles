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
--
-- TODO read this about global configuration
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
--
local lsp_defaults = {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
	end,
}

local lspconfig = require("lspconfig")
local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- override global config
-- :h lspconfig-global-defaults
lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

-- define key bindings
vim.api.nvim_create_autocmd("User", {
	pattern = "LspAttached",
	desc = "LSP actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Displays hover information about the symbol under the cursor
		bufmap("n", "H", "<cmd>lua vim.lsp.buf.hover()<cr>")

		-- Displays a function's signature information
		bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
	end,
})

-- could just be a tcp connection, so no lspconfig, just raw lsp conf
-- see bookmarks firefox/dev on pretto macbook
-- https://github.com/castwide/vscode-solargraph#extension-settings
-- DOCKER version :
-- 	cmd = { "docker-compose", "exec", "-T", "app", "solargraph", "stdio" },
lspconfig.solargraph.setup({
	cmd = require 'lspcontainers'.command('solargraph'),
	settings = {
		solargraph = {
			diagnostics = false,
			formatting = false
		}
	}
})

-- Lua stuff
lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			["diagnostics.globals"] = { 'vim' } -- do not warn on unrecognize 'vim' global
		}
	},
	-- that is a reuse of the code from null-ls on attach to format on save,
	-- looks like the same api
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = formatting_augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,

})

lspconfig.dockerls.setup {
	before_init = function(params)
		params.processId = vim.NIL
	end,
	cmd = require 'lspcontainers'.command('dockerls'),
	root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
}
