-- poc for now, load lspconfig in ftplugin look again the neat dotfiles + some
-- inspiration here https://github.com/neovim/neovim/issues/12688
-- https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/

-- here for the settings https://github.com/sumneko/lua-language-server/wiki/Settings#format
-- NOTE https://github.com/sumneko/lua-language-server/wiki/Settings#formatdefaultconfig
-- if there is a .editorconfig in the workspace, it will take priority
--
-- chris@machine does it like that for autoformatting
-- https://www.chiarulli.me/Neovim/28-neovim-lua-development/
require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			["diagnostics.globals"] = { 'vim' } -- get the language server to recognize the 'vim' global
		}
	},
	-- BUG not working yet, reuse the code from null-ls on attach to format on save, looks like the same api
	on_attach = function(client, bufnr)
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,

})
