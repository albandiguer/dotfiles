-- https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#concealing-characters
vim.opt.conceallevel = 1 -- makes markdown look better

require("obsidian").setup({
	-- https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#notes-on-configuration
	workspaces = {
		{
			name = "Reliable Brain",
			path = "/Users/albandiguer/Google Drive/obsidian_vaults/Reliable Brain", -- NOTE symlinked the folder as needed for second machine

			-- `strict=true` here tells obsidian to use the `path` as the workspace/vault root,
			-- even though the actual Obsidian vault root may be `~/vaults/personal/`.
			strict = true,
		},
	},
	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		-- folder = "&#128198;" -- 📆
		folder = "📆"
	},
	-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
	completion = {
		nvim_cmp = true,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},
	-- mappings = {
	-- Toggle check-boxes.
	-- ["<c-x>"] = {
	-- 	action = function()
	-- 		return require("obsidian").util.toggle_checkbox()
	-- 	end,
	-- 	opts = { buffer = true },
	-- },
	-- Open the daily note for the current date.
	-- ["<c-t>"] = {
	-- 	action = function()
	-- 		return require("obsidian").util.open_daily_note()
	-- 	end,
	-- 	opts = { buffer = true },
	-- },
	-- Open note in obsidian
	-- ["<c-o>"] = {
	-- 	action = function()
	-- 		return require("obsidian").util.open_note()
	-- 	end,
	-- 	opts = { buffer = true },
	-- },
	-- Search in obsidian
	-- ["<c-p>"] = {
	-- 	action = function()
	-- 		return require("obsidian").util.search()
	-- 	end,
	-- 	opts = { buffer = true },
	-- },
	-- }
})
