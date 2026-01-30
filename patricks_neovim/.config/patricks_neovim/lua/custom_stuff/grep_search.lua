--[[ 
  Grep Search Plugin

  This plugin makes it easy to search through your project and refine the search results
  directly within Neovim.

  Features:
    - Search for a term: Perform a project-wide search for a specific term using Ripgrep.
      - Supports "Smart Case" (insensitive if all lowercase, sensitive if upper case used).
      - Async execution (doesn't freeze Neovim).
    - Visual Selection Search: Highlight text and press <leader>sp to search for it.
    - Exclude/Include terms: Refine your search results by filtering the quickfix list.

  Usage:
    1. Search for a term:
       - Normal Mode: Press `<leader>sp` (or run `:lua GrepSearch()`).
       - Visual Mode: Select text and press `<leader>sp` to search for selection.
       - Enter the search term when prompted.
       - The results will be displayed in the quickfix window.
       
    2. Exclude specific entries:
       - Press `<leader>v` (or run `:lua FilterQuickfix("exclude")`).
       - Enter the pattern you want to exclude.
       - Entries matching the pattern (filename or text) are removed.

    3. Include specific entries:
       - Press `<leader>g` (or run `:lua FilterQuickfix("include")`).
       - Enter the pattern you want to keep.
       - Only entries matching the pattern are kept.

    4. Navigating the results:
       - Use vim keys (j, k) in the quickfix window.
       - Press `<CR>` (Enter) to open the result in the main window.
       
  Keybindings:
    - `<leader>sp`: Start a new search (Normal/Visual).
    - `<leader>v`: Exclude results.
    - `<leader>g`: Include results.
]]

-- Helper: Get visual selection
local function get_visual_selection()
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	return table.concat(lines, "\n")
end

-- Core Search Function
function GrepSearch(query)
	-- If called without query (e.g. from normal mode mapping), ask user
	if not query then
		query = vim.fn.input("Grep for: ")
	end

	-- Check validity
	if query == "" or query:match("^%s*$") then
		print(" Search canceled")
		return
	end

	print(" Searching for: " .. query .. "...")

	-- Use vim.system for async execution (requires Neovim 0.10+)
	-- This prevents UI freezing on large searches and handles quoting safely
	local cmd = { "rg", "--vimgrep", "--smart-case", query }

	vim.system(cmd, { text = true }, function(obj)
		vim.schedule(function()
			if obj.code == 0 and obj.stdout and obj.stdout ~= "" then
				-- Parse the output into the quickfix list
				vim.fn.setqflist({}, "r", {
					title = "Grep: " .. query,
					lines = vim.split(obj.stdout, "\n", { trimempty = true }),
				})
				vim.cmd("copen")
				print(" Found results for: " .. query)
			else
				print(" No results found for: " .. query)
			end
		end)
	end)
end

-- Unified Filter Function (DRY)
function FilterQuickfix(mode)
	local prompt = mode == "include" and "Include pattern: " or "Exclude pattern: "
	local pattern = vim.fn.input(prompt)

	if pattern == "" or pattern:match("^%s*$") then
		return
	end

	local qf_list = vim.fn.getqflist()
	local new_qf_list = {}
	local count_removed = 0

	for _, item in ipairs(qf_list) do
		local filename = item.filename or (item.bufnr and vim.fn.bufname(item.bufnr)) or ""
		local text = item.text or ""

		-- Check matches
		local match_found = string.match(text, pattern) or string.match(filename, pattern)

		local keep = false
		if mode == "include" then
			if match_found then
				keep = true
			end
		else -- exclude
			if not match_found then
				keep = true
			end
		end

		if keep then
			table.insert(new_qf_list, item)
		else
			count_removed = count_removed + 1
		end
	end

	vim.fn.setqflist(new_qf_list)
	print(string.format(" Filtered: %s | Removed %d entries", pattern, count_removed))
end

-- Backward compatibility wrappers
function IncludeText()
	FilterQuickfix("include")
end
function ExcludeText()
	FilterQuickfix("exclude")
end

-- Custom Open Function
function QuickfixOpen()
	local cursor_pos = vim.fn.getcurpos()[2]
	local qf_list = vim.fn.getqflist()
	local qf_item = qf_list[cursor_pos]

	if qf_item and (qf_item.bufnr or qf_item.filename) then
		local bufnr = qf_item.bufnr
		if not bufnr or bufnr == 0 then
			-- Try to get buffer from filename if bufnr is missing
			bufnr = vim.fn.bufadd(qf_item.filename)
		end

		if bufnr then
			-- Standard way to jump to file from QF (preserves split layout better)
			vim.cmd("wincmd p") -- Go to previous window (editor)
			vim.api.nvim_set_current_buf(bufnr)
			vim.api.nvim_win_set_cursor(0, { qf_item.lnum, math.max(0, qf_item.col - 1) })
			vim.cmd("normal! zz") -- Center screen
		end
	end
end

-- Mappings
-- 1. Normal Mode Search
vim.keymap.set("n", "<leader>sp", function()
	GrepSearch()
end, { noremap = true, silent = true, desc = "Grep Search" })

-- 2. Visual Mode Search (New!)
vim.keymap.set("v", "<leader>sp", function()
	local saved_reg = vim.fn.getreg("v")
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", saved_reg) -- Restore register

	-- Sanitize newlines for search
	text = string.gsub(text, "\n", " ")
	GrepSearch(text)
end, { noremap = true, silent = true, desc = "Grep Visual Selection" })

-- 3. Filter mappings
vim.keymap.set("n", "<leader>v", "<cmd>lua ExcludeText()<CR>", { noremap = true, silent = true, desc = "Filter Exclude" })
vim.keymap.set("n", "<leader>g", "<cmd>lua IncludeText()<CR>", { noremap = true, silent = true, desc = "Filter Include" })

-- 4. Quickfix Window Specific Mapping (Fixes global <CR> bug)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "<CR>", "<cmd>lua QuickfixOpen()<CR>", { buffer = true, silent = true })
	end,
})
