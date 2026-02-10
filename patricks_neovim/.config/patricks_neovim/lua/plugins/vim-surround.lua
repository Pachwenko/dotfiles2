return {
	"tpope/vim-surround",
	config = function()
		vim.api.nvim_set_keymap("n", "S", "cs", { noremap = true, silent = false })
	end,
}
