-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Autoformat setting
local set_autoformat = function(pattern, bool_val)
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = pattern,
		callback = function()
			vim.b.autoformat = bool_val
		end,
	})
end

set_autoformat({ "python" }, true)
set_autoformat({ "javascript" }, false)
