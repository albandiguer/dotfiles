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


local lspconfig = require("lspconfig")
local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
local lsp_defaults = {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = formatting_augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
}

-- local format_on_save = function(client, bufnr)
-- 	if client.supports_method("textDocument/formatting") then
-- 		vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			group = formatting_augroup,
-- 			buffer = bufnr,
-- 			callback = function()
-- 				vim.lsp.buf.formatting_sync()
-- 			end,
-- 		})
-- end

-- local format_on_save = function(client, bufnr)
-- 	if client.supports_method("textDocument/formatting") then
-- 		vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			group = formatting_augroup,
-- 			buffer = bufnr,
-- 			callback = function()
-- 				vim.lsp.buf.formatting_sync()
-- 			end,
-- 		})
-- end

-- override global config
-- :h lspconfig-global-defaults
lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

-- define auto command group
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


-- Ruby
-- could just be a tcp connection, so no lspconfig, just raw lsp conf
-- see bookmarks firefox/dev on pretto macbook
-- https://github.com/castwide/vscode-solargraph#extension-settings
-- DOCKER example :
-- 	cmd = { "docker-compose", "exec", "-T", "app", "solargraph", "stdio" },
-- define settings in project .solargraph.yml
lspconfig.solargraph.setup({
	-- load this only if there is a .solargraph.yml file
	root_dir = lspconfig.util.root_pattern(".solargraph.yml", vim.fn.getcwd()),
	cmd = { "./bin/solargraph" }
})

-- Lua
lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			["diagnostics.globals"] = { 'vim' } -- do not warn on unrecognize 'vim' global
		}
	}
})

-- Docker
lspconfig.dockerls.setup {
	before_init = function(params)
		params.processId = vim.NIL
	end,
	cmd = require 'lspcontainers'.command('dockerls'),
	root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
	settings = {
		docker = {
			formatter = true;
		}
	}
}

-- Nix
lspconfig.rnix.setup {}

-- Markdown
lspconfig.marksman.setup {
	cmd = { 'marksman', 'server' }
}

-- Terraform
require 'lspconfig'.terraformls.setup {}

-- Yaml
require 'lspconfig'.yamlls.setup {}
