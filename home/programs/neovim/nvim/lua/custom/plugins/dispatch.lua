return {
	'tpope/vim-dispatch',
	keys = {
		{ ',d', ':Dispatch', { desc = 'Dispatch (default make)' } }
	},
	config = function()
		vim.g.dispatch_tmux_height = '35% -h'
	end,
}
