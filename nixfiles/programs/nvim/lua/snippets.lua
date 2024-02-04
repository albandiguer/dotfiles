local ls = require('luasnip')
-- Extend filetypes for ERB to include "html"
ls.filetype_extend("ruby", { "rails" })
-- Extend filetypes for ERB to include "html"
ls.filetype_extend("eruby", { "html" })
-- below loads friendly-snippets see doc here
-- https://github.com/L3MON4D3/LuaSnip#add-snippets
require("luasnip.loaders.from_vscode").lazy_load()


-- vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-H>", function() ls.jump(-1) end, { silent = true })

-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, { silent = true })
