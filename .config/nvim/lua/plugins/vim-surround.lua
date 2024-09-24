-- https://github.com/tpope/vim-surround
return {
	"tpope/vim-surround",
	dependencies = {},
	config = function()
		-- Map 'S' to 'cs' in normal mode
		vim.api.nvim_set_keymap("n", "S", "cs", { noremap = true, silent = false })
	end,
}
