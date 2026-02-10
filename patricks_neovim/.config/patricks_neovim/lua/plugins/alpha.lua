return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			[[=================     ===============     ===============   ========  ========]],
			[[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
			[[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
			[[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
			[[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
			[[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
			[[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
			[[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
			[[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
			[[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
			[[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
			[[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
			[[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
			[[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
			[[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
			[[||.=='    _-'                                                     `' |  /==.||]],
			[[=='    _-'                        N E O V I M                         \/   `==]],
			[[\   _-'                                                                `-_   /]],
			[[ `''                                                                      ``' ]],
		} -- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("<leader> tr", "  > Toggle file explorer", "<cmd>Neotree reveal<CR>"),
			dashboard.button("<leader> sf", "󰱼 > Find File", "<cmd>lua Snacks.picker.files()<CR>"),
			dashboard.button("<leader> sg", "  > Find Word", "<cmd>lua Snacks.picker.grep()<CR>"),
			dashboard.button("<leader> ls", "󰁯  > Restore Last Session", "<cmd>SessionLoad<cr>"),
			dashboard.button("<leader> ss", "󰁯  > Manage Sessions", "<cmd>Persisted<cr>"),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
