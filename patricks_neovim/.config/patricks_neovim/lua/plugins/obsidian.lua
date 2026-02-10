return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = false,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/Documents/notes/",
			},
		},
		daily_notes = {
			folder = "Misc/B",
			date_format = "%Y%m%d",
			template = "yyyy-mm-dd",
		},
	},
}
