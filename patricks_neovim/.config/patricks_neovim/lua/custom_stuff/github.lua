-- Helper function to extract the GitHub URL from .git/config
local function get_repo_url(file_dir)
	-- Read the contents of the .git/config file using the file's directory as context
	local cmd = string.format("cd %s && git config --get remote.origin.url", vim.fn.shellescape(file_dir))
	local handle = io.popen(cmd)
	local git_config = handle:read("*a")
	handle:close()

	if not git_config or git_config == "" then return nil end
	git_config = git_config:gsub("\n", "") -- Remove newline characters

	-- Replace the Git URL with HTTPS (if it's a git@github.com URL)
	git_config = git_config:gsub("git@github.com:", "https://github.com/")
	git_config = git_config:gsub("%.git$", "") -- Remove the .git extension

	return git_config
end

-- Function to open the current line or selected lines in GitHub
function Open_in_github()
	local full_path = vim.fn.expand("%:p")
	local file_dir = vim.fn.expand("%:p:h")

	-- Get the repository URL relative to the file's directory
	local repo_url = get_repo_url(file_dir)

	if not repo_url or repo_url == "" then
		print("Could not determine repository URL for: " .. full_path)
		return
	end

	-- Run git commands from the file's directory to handle nested repos correctly
	local git_cmd_prefix = string.format("cd %s && ", vim.fn.shellescape(file_dir))

	-- Get the current file path relative to the git root
	local rel_cmd = git_cmd_prefix .. "git ls-files --full-name " .. vim.fn.shellescape(full_path)
	local relative_file_path = io.popen(rel_cmd):read("*a"):gsub("\n", "")

	if relative_file_path == "" then
		print("File is not tracked by git: " .. full_path)
		return
	end

	-- Get the current branch (or commit hash for more accuracy)
	local branch = io.popen(git_cmd_prefix .. "git rev-parse --abbrev-ref HEAD"):read("*a"):gsub("\n", "")

	-- Determine if we're in visual mode and selecting a range
	local line_start, line_end
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" or mode == " " then -- ' ' for visual block
		line_start = vim.fn.line("v")
		line_end = vim.fn.line(".")
		if line_start > line_end then
			line_start, line_end = line_end, line_start
		end
	else
		line_start = vim.fn.line(".")
		line_end = line_start
	end

	-- Construct the GitHub URL
	local github_url
	if line_start == line_end then
		github_url = string.format("%s/blob/%s/%s#L%d", repo_url, branch, relative_file_path, line_start)
	else
		github_url = string.format("%s/blob/%s/%s#L%d-L%d", repo_url, branch, relative_file_path, line_start, line_end)
	end

	-- Browser & Clipboard logic
	if vim.g.vscode then
		local vscode = require("vscode")
		vscode.eval("vscode.env.openExternal(vscode.Uri.parse(args.url))", { args = { url = github_url } })
		vscode.eval("vscode.env.clipboard.writeText(args.url)", { args = { url = github_url } })
	else
		if vim.fn.has("mac") == 1 then
			vim.fn.jobstart({ "open", github_url })
		elseif vim.fn.has("unix") == 1 then
			vim.fn.jobstart({ "xdg-open", github_url })
		elseif vim.fn.has("win32") == 1 then
			vim.fn.jobstart({ "start", github_url })
		end
		vim.fn.setreg("+", github_url)
	end

	print("GitHub URL copied: " .. github_url)
end

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>gh", ":lua Open_in_github()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>gh", ":<C-u>lua Open_in_github()<CR>", { noremap = true, silent = true })
