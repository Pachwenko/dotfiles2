return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local function get_recent_sessions(max)
			local save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/neovim_persisted_sessions/")
			local files = vim.fn.glob(save_dir .. "*.vim", false, true)
			table.sort(files, function(a, b)
				return vim.fn.getftime(a) > vim.fn.getftime(b)
			end)
			local sessions = {}
			for i = 1, math.min(max, #files) do
				local name = vim.fn.fnamemodify(files[i], ":t:r")
				local dir = name:gsub("%%", "/")
				local short = dir:match(".*/(.-)$") or dir
				table.insert(sessions, { name = short, path = files[i], dir = dir })
			end
			return sessions
		end

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
		}

		-- Action buttons
		local buttons = {
			dashboard.button("e", "  New File", "<cmd>ene<CR>"),
			dashboard.button("<leader> pp", "  Open Project", "<cmd>ProjectPicker<CR>"),
			dashboard.button("<leader> sf", "  Find File", "<cmd>lua Snacks.picker.files()<CR>"),
			dashboard.button("<leader> sg", "  Find Word", "<cmd>lua Snacks.picker.grep()<CR>"),
			dashboard.button("<leader> ss", "  All Sessions", "<cmd>Persisted<cr>"),
			dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
		}

		-- Recent sessions
		local sessions = get_recent_sessions(5)
		if #sessions > 0 then
			table.insert(buttons, { type = "padding", val = 1 })
			table.insert(buttons, {
				type = "text",
				val = "Recent Sessions",
				opts = { hl = "SpecialComment", position = "center" },
			})
			for i, s in ipairs(sessions) do
				local cmd = string.format(
					"<cmd>lua vim.fn.chdir('%s'); require('persisted').load({ session = '%s' })<CR>",
					s.dir,
					s.path
				)
				local btn = dashboard.button(tostring(i), "  " .. s.name, cmd)
				table.insert(buttons, btn)
			end
		end

		dashboard.section.buttons.val = buttons

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
