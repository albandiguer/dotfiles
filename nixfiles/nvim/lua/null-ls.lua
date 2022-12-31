-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#code-1
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require("null-ls")
-- LspFormatting auto command group, clear = false so if there is a lsp
-- formatting we let it do it. example: solargraph(w/rubocop) takes precendence
-- on null_ls+rubocop
local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
null_ls.setup({
	sources = {
		-- null_ls.builtins.completion.spell,
		-- null_ls.builtins.formatting.stylua, -- sumneko now has a formatter
		null_ls.builtins.code_actions.statix, --  for nix
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.hadolint, -- dockerfiles
		null_ls.builtins.diagnostics.rubocop, -- ruby static analysis, solargraph does that
		null_ls.builtins.diagnostics.vint,
		null_ls.builtins.formatting.alejandra,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier.with({ filetypes = { "yaml" } }), -- TODO switch to yamlfmt
		null_ls.builtins.formatting.rubocop, -- ruby formatter
		null_ls.builtins.formatting.terraform_fmt,
	},
	debug = true,
	-- format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = formatting_augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,
	-- should_attach = function(bufnr)
	-- return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
	-- TODO condition to avoid starting null-ls/rubocop if there is a solargraph config
	-- return not vim.api.nvim_buf_get_name
	-- end

})
