return {
	"echasnovski/mini.nvim",
	config = function()
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { desc = desc })
		end

		require("mini.ai").setup({
			n_lines = 500,
		})

		local mini_git = require("mini.git")
		mini_git.setup()

		map({ "n", "x" }, "<leader>ga", mini_git.show_at_cursor, "Git show at cursor")
		map({ "n", "v" }, "<leader>gh", mini_git.show_range_history, "Git show range history")
		map({ "n", "v" }, "<leader>gd", mini_git.show_diff_source, "Git show diff source")

		local mini_diff = require("mini.diff")
		mini_diff.setup()

		map("n", "<leader>go", mini_diff.toggle_overlay, "Git toggle overlay")

		local statusline = require("mini.statusline")
		statusline.setup({
			use_icons = vim.g.have_nerd_font,
		})
	end,
}
