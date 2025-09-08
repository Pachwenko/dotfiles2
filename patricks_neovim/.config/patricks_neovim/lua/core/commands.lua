-- This is a lua command that does the following:
-- 1.	Runs a ripgrep search in the projects_dir for all files and folders, filtering out hidden files and node_modules, then piping to fzf to format in a nice way. 2.	Uses vim.fn.systemlist() to capture the output of fzf, which returns the selected directory.
-- 3.	Changes the current directory in Neovim to the selected directory if a valid selection is made.
--
-- TODO: fix this so it works??
-- TODO: make this a telescope plugin/shortcut
vim.api.nvim_create_user_command("FZFGlobal", function()
	local projects_dir = "~/Projects"
	local fzf_cmd = "rg --files --null --glob '!.*' --glob '!**/node_modules/**' "
		.. projects_dir
		.. " | xargs -0 dirname | sort -u | sed 's#^/Users/patrick.mccartney/Projects/##' | fzf --ansi --color 'fg+:#e1dcd6,hl:+2,hl+:+2' --color='gutter:-1' --layout=reverse"
	local pick = vim.fn.systemlist(fzf_cmd)[1]

	if pick and pick ~= "" then
		vim.cmd("cd " .. vim.fn.fnameescape(projects_dir .. pick))
	end
end, {})


vim.api.nvim_create_user_command('Newbuff', 'silent! | :vsplit | enew', {})
vim.api.nvim_create_user_command('Black', 'silent! | :!black --line-length 120 %', {})
vim.api.nvim_create_user_command('Isort', 'silent! | :!isort -e %', {})
vim.api.nvim_create_user_command('Spellon', 'setlocal spell spelllang=en_us', {})
vim.api.nvim_create_user_command('Spelloff', 'setlocal nospell', {})
