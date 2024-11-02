-- https://github.com/echasnovski/mini.nvim
-- Collection of various small independent plugins/modules

return {
	"echasnovski/mini.nvim",
	config = function()
		-- Utility function for key mappings
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { desc = desc })
		end

		-- Setup mini.ai
		require("mini.ai").setup({
			n_lines = 500,
		})

		-- Setup mini.git
		local mini_git = require("mini.git")
		mini_git.setup() -- Pass any specific options if needed

		-- Key mappings for mini.git
		map({ "n", "x" }, "<leader>ga", mini_git.show_at_cursor, "Git show at cursor")
		map({ "n", "v" }, "<leader>gh", mini_git.show_range_history, "Git show range history")
		map({ "n", "v" }, "<leader>gd", mini_git.show_diff_source, "Git show diff source")

		-- Setup mini.diff
		local mini_diff = require("mini.diff")
		mini_diff.setup() -- Pass any specific options if needed

		-- Key mapping for mini.diff
		map("n", "<leader>go", mini_diff.toggle_overlay, "Git toggle overlay")

		-- Setup mini.statusline
		local statusline = require("mini.statusline")
		statusline.setup({
			use_icons = vim.g.have_nerd_font,
		})

		-- Additional setups (e.g., mini.surround) can be added here
		-- Ensure that they do not conflict with other plugins
	end,
}
