-- Plugin: glepnir/dashboard-nvim
-- GitHub: https://github.com/glepnir/dashboard-nvim
-- Description: A highly customizable dashboard for Neovim, offering a beautiful start screen with easy access to commonly used actions.

return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dashboard = require("dashboard")

		dashboard.setup({
			theme = "hyper",
			config = {
				header = {},
				center = {
					{
						icon = "  ",
						desc = "Find File",
						key = "f",
						action = "Telescope find_files",
					},
					{
						icon = "  ",
						desc = "Recents",
						key = "r",
						action = "Telescope oldfiles",
					},
					{
						icon = "S ",
						desc = "Previous Sessions",
						key = "s",
						action = "Telescope persisted",
					},
					{
						icon = "  ",
						desc = "Quit",
						key = "q",
						action = "qa",
					},
				},
				footer = {
					"don't panic",
				},
			},
		})
	end,
}
