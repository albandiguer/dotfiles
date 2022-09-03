-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#code-1
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require("null-ls")
-- use to format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.statix, --  for nix
		-- null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.flake8,
		-- null_ls.builtins.diagnostics.rubocop, -- ruby static analysis
		null_ls.builtins.diagnostics.vint,
		null_ls.builtins.formatting.alejandra,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.formatting.stylua, -- sumneko now has a formatter
		null_ls.builtins.formatting.rubocop, -- ruby formatter
		null_ls.builtins.formatting.terraform_fmt,
	},
	debug = true,
	-- format on save
	on_attach = function(client, bufnr)
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
