-- poc for now, load lspconfig in ftplugin look again the neat dotfiles + some
-- inspiration here https://github.com/neovim/neovim/issues/12688
-- https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/

local lspconfig = require("lspconfig")
local runtime_path = vim.split(package.path, ";")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	commands = {
		Format = {
			function()
				require("stylua-nvim").format_file()
			end,
		},
	},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
