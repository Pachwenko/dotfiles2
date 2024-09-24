-- Function to perform initial grep search
function GrepSearch()
	local search_term = vim.fn.input("Grep for: ")
	vim.cmd('cgetexpr system("rg --vimgrep ' .. search_term .. '")')
	vim.cmd("copen")
end

-- Function to exclude text from quickfix list
function ExcludeText()
	local exclude_pattern = vim.fn.input("Exclude pattern: ")
	local new_qf_list = {}
	for _, item in ipairs(vim.fn.getqflist()) do
		if not string.match(item.text, exclude_pattern) then
			table.insert(new_qf_list, item)
		end
	end
	vim.fn.setqflist(new_qf_list)
end

-- Function to include text in quickfix list
function IncludeText()
	local include_pattern = vim.fn.input("Include pattern: ")
	local new_qf_list = {}
	for _, item in ipairs(vim.fn.getqflist()) do
		if string.match(item.text, include_pattern) then
			table.insert(new_qf_list, item)
		end
	end
	vim.fn.setqflist(new_qf_list)
end

-- Key mappings
vim.api.nvim_set_keymap("n", "<leader>sp", ":lua GrepSearch()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>v", ":lua ExcludeText()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>g", ":lua IncludeText()<CR>", { noremap = true, silent = true })

-- Open file from quickfix list
vim.api.nvim_set_keymap("n", "<CR>", ":copen<CR>:cc<CR>", { noremap = true, silent = true })

-- Function to set key mappings for quickfix window
local function set_quickfix_keymaps()
	vim.api.nvim_set_keymap("n", "<leader>v", "<cmd>lua ExcludeText()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua IncludeText()<CR>", { noremap = true, silent = true })
end

-- Function to clear key mappings
local function clear_quickfix_keymaps()
	vim.api.nvim_del_keymap("n", "<leader>v")
	vim.api.nvim_del_keymap("n", "<leader>g")
end

-- Autocommand group to manage quickfix key mappings
vim.api.nvim_create_augroup("QuickfixKeymaps", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = set_quickfix_keymaps,
	group = "QuickfixKeymaps",
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	callback = function()
		-- Check if we are leaving a quickfix buffer
		if vim.bo.filetype == "qf" then
			clear_quickfix_keymaps()
		end
	end,
	group = "QuickfixKeymaps",
})
