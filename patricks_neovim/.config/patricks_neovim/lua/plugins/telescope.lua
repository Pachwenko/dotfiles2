-- Plugin: nvim-telescope/telescope.nvim
-- GitHub: https://github.com/nvim-telescope/telescope.nvim
-- Description: A highly extendable fuzzy finder over lists for Neovim, supporting file searching, LSP integration, and more.

return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",
			-- `build` is used to run some command when the plugin is installed/updated. This is only run then, not every time Neovim starts up.
			build = "make",
			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded. cond = function() return vim.fn.executable("make") == 1
		},
		{ -- https://github.com/nvim-telescope/telescope-file-browser.nvim
			-- To browse files!
			-- brew install fd
			"nvim-telescope/telescope-file-browser.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			-- pickers = {}
			extensions = {
				persisted = {
					layout_config = { width = 0.35, height = 0.55 },
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		require("telescope").load_extension("persisted")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")

		-- Keybindings using command strings with <CR> to open in normal mode
		vim.keymap.set("n", "<leader>sh", ":Telescope help_tags<Esc>", { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", ":Telescope keymaps<Esc>", { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", ":Telescope find_files<Esc>", { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sb", ":Telescope buffers<Esc>", { desc = "[F]ind [B]uffers" })
		vim.keymap.set("n", "<leader>so", ":Telescope oldfiles<Esc>", { desc = "[S]search for  [O]ld files" })
		vim.keymap.set("n", "<leader>sw", ":Telescope grep_string<Esc>", { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", ":Telescope live_grep<Esc>", { desc = "[S]earch by [G]rep" })
		vim.keymap.set(
			"n",
			"<leader>si",
			[[<cmd>lua require('telescope.builtin').live_grep({ search_dirs = { '~/test-projects' } })<CR>]]
		)
		vim.keymap.set(
			"n",
			"<leader>su",
			[[<cmd>lua require('telescope.builtin').live_grep({ search_dirs = { '~/Projects' }, additional_args = function() return { "--glob", "*.js", "--glob", "*.py", "--glob", "*.md" } end })<CR>]]
		)
		-- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", ":Telescope resume<Esc>", { desc = "[S]earch [R]esume" })
		vim.keymap.set(
			"n",
			"<leader>s.",
			":Telescope oldfiles<Esc>",
			{ desc = '[S]earch Recent Files ("." for repeat)' }
		)
		-- vim.keymap.set("n", "<leader><leader>", ":Telescope buffers<Esc>", { desc = "[ ] Find existing buffers" })
		-- instead use bafa plugin!
		vim.keymap.set("n", "<leader>ss", ":Telescope persisted<Esc>", { desc = "[S]earch [S]essions" })
		vim.keymap.set("n", "<leader>so", ":ObsidianSearch<Esc>", { desc = "[S]earch [O]bsidian" })
		vim.keymap.set("n", "<leader>st", ":Telescope treesitter<Esc>", { desc = "[S]earch [T]reesitter Symbols" })
		vim.keymap.set(
			"n",
			"<leader>sw",
			":Telescope lsp_workspace_symbols<Esc>",
			{ desc = "[L]SP [W]orkspace Symbols" }
		)
		vim.keymap.set("n", "<leader>fc", ":Telescope commands<Esc>", { desc = "[F]ind [C]ommands" })
		vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<Esc>", { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>ch", "<cmd>Telescope command_history<cr>", { desc = "Show [C]ommand [History" })

		-- Keybindings using Lua functions with additional configurations
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
