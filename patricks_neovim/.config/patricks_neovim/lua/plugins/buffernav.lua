return {
	"wojciech-kulik/filenav.nvim",
	config = function()
		require("filenav").setup({
			max_history = 100,
			remove_duplicates = false,
		})
		vim.keymap.set("n", "<leader>bp", "<cmd>FilenavPrev<CR>", { silent = true, desc = "Go Back in file history" })
		vim.keymap.set("n", "<leader>bn", "<cmd>FilenavNext<CR>", { silent = true, desc = "Go Next in file history" })
	end,
}
