return {
	'iamcco/markdown-preview.nvim',
	run = 'cd app && yarn install',
	ft = { 'markdown' },
	cmd = { 'MarkdownPreview' },
	config = function()
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 0
		vim.g.mkdp_refresh_slow = 0
		vim.g.mkdp_browser = 'firefox'
	end,
}
