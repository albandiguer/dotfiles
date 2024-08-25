-- require("lspconfig").solargraph.setup({
-- 	cmd = { "docker-compose", "run", "-t", "-p", "7658:7658", "--rm", "app", "solargraph", "stdio" },
-- 	settings = {
-- 		solargraph = {
-- 			transport = "stdio",
-- 			-- transport = "external",
-- 			-- externalServer = {
-- 			-- 	host = "localhost",
-- 			-- 	port = 7658
-- 			-- },
-- 			diagnostics = true,
-- 			init_options = {
-- 				formatting = true
-- 			}
-- 		}
-- 	}
-- })
--
-- NOTE this seems to be doing the trick
-- https://github.com/autozimu/LanguageClient-neovim/blob/next/INSTALL.md

function SendToTmuxPane(include_line)
	local current_file = vim.fn.expand('%')
	local current_line = ""

	if include_line then
		current_line = ":" .. vim.fn.line('.')
	end

	local cmd = string.format("tmux send-keys -t ':.1' '%s %s%s' C-m", os.getenv("TEST_CMD"), current_file, current_line) -- NOTE set $TEST_CMD in project .envrc
	vim.fn.system(cmd)
end

vim.api.nvim_set_keymap('n', '<Leader>t', ':lua SendToTmuxPane(true)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>T', ':lua SendToTmuxPane(false)<CR>', { noremap = true, silent = true })

require('luasnip').filetype_extend("ruby", { "rails" })
require('luasnip').filetype_extend("eruby", { "html" })
