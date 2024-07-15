require('lazy').setup({
	spec = {
		{ import = "lazyplugins" },
		{
			change_detection = {
				notify = false,
			},
		}
	},
	install = { colorscheme = { "gruvbox" } },
})
