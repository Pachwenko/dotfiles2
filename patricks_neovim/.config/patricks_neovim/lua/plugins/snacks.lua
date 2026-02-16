return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		notifier = {
			enabled = false,
			timeout = 3000,
		},
		picker = {
			enabled = true,
			sources = {
				files = {
					exclude = { "node_modules", ".git", "__pycache__", "*/migrations" },
				},
				grep = {
					exclude = { "node_modules", ".git", "__pycache__", "*/migrations" },
				},
			},
		},
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				wo = { wrap = true },
			},
		},
	},
	keys = {
		-- Notifications
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

		-- Buffers / Files
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		{ "<leader>rf", function() Snacks.rename() end, desc = "Rename File" },

		-- Git
		{ "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
		{ "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
		{ "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },

		-- Search (picker)
		{ "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
		{ "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch by [G]rep" },
		{ "<leader>sb", function() Snacks.picker.buffers() end, desc = "[S]earch [B]uffers" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
		{ "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
		{ "<leader>s.", function() Snacks.picker.recent() end, desc = "[S]earch Recent Files" },
		{ "<leader>st", function() Snacks.picker.treesitter() end, desc = "[S]earch [T]reesitter Symbols" },
		{ "<leader>sw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[S]earch [W]orkspace Symbols" },
		{ "<leader>fc", function() Snacks.picker.commands() end, desc = "[F]ind [C]ommands" },
		{ "<leader>fk", function() Snacks.picker.keymaps() end, desc = "[F]ind [K]eymaps" },
		{ "<leader>ch", function() Snacks.picker.command_history() end, desc = "[C]ommand [H]istory" },
		{ "<leader>so", "<cmd>ObsidianSearch<CR>", desc = "[S]earch [O]bsidian" },
		{ "<leader>ss", "<cmd>Persisted<CR>", desc = "[S]earch [S]essions" },

		-- Project picker (cd + load session)
		{ "<leader>pp", function() pick_project() end, desc = "[P]roject [P]icker" },

		-- Grep in specific directories
		{ "<leader>si", function() Snacks.picker.grep({ dirs = { "~/test-projects" } }) end, desc = "[S]earch [I]n test-projects" },
		{ "<leader>su", function() Snacks.picker.grep({ dirs = { "~/Projects" }, glob = { "*.js", "*.py", "*.md" } }) end, desc = "[S]earch [U]ser Projects" },

		-- Buffer/file scoped search
		{ "<leader>/", function() Snacks.picker.lines() end, desc = "[/] Fuzzily search in current buffer" },
		{ "<leader>s/", function() Snacks.picker.grep({ buffers = true }) end, desc = "[S]earch [/] in Open Files" },
		{ "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },

		-- Terminal
		{ "<leader>tt", function() Snacks.terminal() end, desc = "[T]oggle [T]erminal" },
		{ "<leader>tf", function() Snacks.terminal(nil, { win = { position = "float" } }) end, desc = "[T]erminal [F]loating" },
		{ "<c-\\>", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" } },

		-- Neovim News
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd

				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
			end,
		})
	end,
}
