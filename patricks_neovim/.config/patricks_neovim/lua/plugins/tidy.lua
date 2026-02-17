return {
	"mcauley-penney/tidy.nvim",
	opts = {
		enabled_on_save = true,
		filetype_exclude = { "diff" },
	},
	init = function()
		vim.keymap.set("n", "<leader>tw", require("tidy").run, { desc = "[T]idy up your [whitespace]" })
	end,
}
