-- -- Function to perform initial grep search
-- function GrepSearch()
-- 	local search_term = vim.fn.input("Grep for: ")
-- 	vim.cmd('cgetexpr system("rg --vimgrep ' .. search_term .. '")')
-- 	vim.cmd("copen")
-- end
--
-- -- Function to exclude text from quickfix list
-- function ExcludeText()
-- 	local exclude_pattern = vim.fn.input("Exclude pattern: ")
-- 	local new_qf_list = {}
-- 	for _, item in ipairs(vim.fn.getqflist()) do
-- 		if not string.match(item.text, exclude_pattern) then
-- 			table.insert(new_qf_list, item)
-- 		end
-- 	end
-- 	vim.fn.setqflist(new_qf_list)
-- end
--
-- -- Function to include text in quickfix list
-- function IncludeText()
-- 	local include_pattern = vim.fn.input("Include pattern: ")
-- 	local new_qf_list = {}
-- 	for _, item in ipairs(vim.fn.getqflist()) do
-- 		if string.match(item.text, include_pattern) then
-- 			table.insert(new_qf_list, item)
-- 		end
-- 	end
-- 	vim.fn.setqflist(new_qf_list)
-- end
--
-- -- Key mappings
-- vim.api.nvim_set_keymap("n", "<leader>sp", ":lua GrepSearch()<CR>", { noremap = true, silent = true })
-- -- vim.api.nvim_set_keymap("n", "<leader>v", ":lua ExcludeText()<CR>", { noremap = true, silent = true })
-- -- vim.api.nvim_set_keymap("n", "<leader>g", ":lua IncludeText()<CR>", { noremap = true, silent = true })
-- --
-- -- Function to open selected quickfix entry
-- function QuickfixOpen()
-- 	-- Open the selected entry from quickfix list
-- 	local qf_item = vim.fn.getqflist({ idx = 0 }).idx -- Get the current quickfix entry index
-- 	vim.cmd("copen") -- Ensure the quickfix window is open
-- 	vim.cmd("cc " .. qf_item) -- Move to the selected quickfix item
-- 	vim.cmd("edit") -- Open the file under the cursor
-- end
--
-- -- Open the selected file from quickfix list
-- vim.api.nvim_set_keymap("n", "<CR>", ":call QuickfixOpen()<CR>", { noremap = true, silent = true })
--
-- -- Function to set key mappings for quickfix window
-- local function set_quickfix_keymaps()
-- 	vim.api.nvim_set_keymap("n", "<leader>v", "<cmd>lua ExcludeText()<CR>", { noremap = true, silent = true })
-- 	vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua IncludeText()<CR>", { noremap = true, silent = true })
-- end
--
-- -- Function to clear key mappings
-- local function clear_quickfix_keymaps()
-- 	vim.api.nvim_del_keymap("n", "<leader>v")
-- 	vim.api.nvim_del_keymap("n", "<leader>g")
-- end
--
-- -- Autocommand group to manage quickfix key mappings
-- vim.api.nvim_create_augroup("QuickfixKeymaps", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "qf",
-- 	callback = set_quickfix_keymaps,
-- 	group = "QuickfixKeymaps",
-- })
--
-- vim.api.nvim_create_autocmd("BufLeave", {
-- 	pattern = "*",
-- 	callback = function()
-- 		-- Check if we are leaving a quickfix buffer
-- 		if vim.bo.filetype == "qf" then
-- 			clear_quickfix_keymaps()
-- 		end
-- 	end,
-- 	group = "QuickfixKeymaps",
-- })

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

-- Function to open selected quickfix entry
function QuickfixOpen()
	-- Get the current cursor position in the quickfix window
	local cursor_pos = vim.fn.getcurpos()[2] -- Get the cursor's line number in the quickfix window

	-- Get the entire quickfix list
	local qf_list = vim.fn.getqflist()

	-- Get the quickfix item corresponding to the cursor position
	local qf_item = qf_list[cursor_pos]

	if qf_item and qf_item.bufnr and qf_item.lnum then
		-- Get the buffer name (file path) from the buffer number
		local filename = vim.fn.bufname(qf_item.bufnr)
		if filename ~= "" then
			-- Close the quickfix window and switch to the main window
			vim.cmd("wincmd p") -- Move to the previous window (main editor)
			-- Open the file and jump to the correct line and column
			vim.cmd("e " .. filename)
			vim.api.nvim_win_set_cursor(0, { qf_item.lnum, qf_item.col - 1 }) -- Move cursor to line and column
		else
			print("Unable to determine the file for the selected quickfix entry.")
		end
	else
		print("No valid quickfix entry selected.")
	end
end

-- Function to set key mappings for quickfix window
-- Avoids interfering with other keymaps by only applying to the quickfix window
-- local function set_quickfix_keymaps()
vim.api.nvim_set_keymap("n", "<leader>v", "<cmd>lua ExcludeText()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua IncludeText()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<CR>", ":lua QuickfixOpen()<CR>", { noremap = true, silent = true }) -- Specific to quickfix window
-- end

-- Autocommand group to manage quickfix key mappings
-- vim.api.nvim_create_augroup("QuickfixKeymaps", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "qf",
-- 	callback = set_quickfix_keymaps,
-- 	group = "QuickfixKeymaps",
-- })

-- Set the main keymap for this, <leader>sp to open the search interface
vim.api.nvim_set_keymap("n", "<leader>sp", ":lua GrepSearch()<CR>", { noremap = true, silent = true })
