local map = require("util").map

-- Define a custom highlight group for Non-ASCII characters
vim.api.nvim_set_hl(0, "NonASCII", {
	fg = "#ffffff", -- Optional: sets text color to white
	bg = "#ff0000", -- Sets background color to red (change as desired)
})

-- Variable to store the match ID
vim.g.non_ascii_match_id = nil

-- Function to toggle non-ASCII highlighting
function Toggle_non_ascii_highlight()
	if vim.g.non_ascii_match_id then
		vim.fn.matchdelete(vim.g.non_ascii_match_id)
		vim.g.non_ascii_match_id = nil
		print("Non-ASCII highlighting disabled")
	else
		vim.g.non_ascii_match_id = vim.fn.matchadd("NonASCII", "[^\\x00-\\x7F]")
		print("Non-ASCII highlighting enabled")
	end
end

-- Map the toggle function to <leader>h-- Define a custom highlight group for Trailing Whitespace
vim.api.nvim_set_hl(0, "TrailingWhitespace", {
	bg = "#ff0000", -- Sets background color to red (change as desired)
})

-- Variable to store the match ID
vim.g.trailing_whitespace_match_id = nil

-- Function to toggle trailing whitespace highlighting
function Toggle_trailing_whitespace_highlight()
	if vim.g.trailing_whitespace_match_id then
		vim.fn.matchdelete(vim.g.trailing_whitespace_match_id)
		vim.g.trailing_whitespace_match_id = nil
		-- print("Trailing whitespace highlighting disabled")
	else
		vim.g.trailing_whitespace_match_id = vim.fn.matchadd("TrailingWhitespace", "\\s\\+$")
		-- print("Trailing whitespace highlighting enabled")
	end
end

map("<leader>hl", ":lua Toggle_non_ascii_highlight()<CR>", "[H]ilight non ascii characters")

map("<leader>hw", ":lua Toggle_trailing_whitespace_highlight()<CR>", "[h]ilight trailing [w]hitespace")
