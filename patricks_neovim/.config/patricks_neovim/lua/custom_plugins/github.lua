-- Helper function to extract the GitHub URL from .git/config
local function get_repo_url()
	-- Read the contents of the .git/config file
	local git_config = io.popen("git config --get remote.origin.url"):read("*a")
	git_config = git_config:gsub("\n", "") -- Remove newline characters

	-- Replace the Git URL with HTTPS (if it's a git@github.com URL)
	git_config = git_config:gsub("git@github.com:", "https://github.com/")
	git_config = git_config:gsub("%.git$", "") -- Remove the .git extension

	return git_config
end

-- Function to open the current line in GitHub
function Open_in_github()
	-- Get the repository URL
	local repo_url = get_repo_url()

	if not repo_url or repo_url == "" then
		print("Could not determine repository URL.")
		return
	end

	-- Get the current file path relative to the git root
	local file_path = vim.fn.expand("%:p") -- Full path of the current file
	local git_root = io.popen("git rev-parse --show-toplevel"):read("*a"):gsub("\n", "")
	local relative_file_path = file_path:gsub(git_root .. "/", "")

	-- Get the current line number
	local line_number = vim.fn.line(".")

	-- Get the current branch
	local branch = io.popen("git rev-parse --abbrev-ref HEAD"):read("*a"):gsub("\n", "")

	-- Construct the GitHub URL for the current file and line number
	local github_url = string.format("%s/blob/%s/%s#L%d", repo_url, branch, relative_file_path, line_number)

	-- Open the GitHub URL in the default browser
	if vim.fn.has("mac") == 1 then
		vim.fn.jobstart({ "open", github_url }) -- macOS
	elseif vim.fn.has("unix") == 1 then
		vim.fn.jobstart({ "xdg-open", github_url }) -- Linux
	elseif vim.fn.has("win32") == 1 then
		vim.fn.jobstart({ "start", github_url }) -- Windows
	else
		print("Unsupported OS")
	end
end

-- Keybinding to open the current line in GitHub
vim.api.nvim_set_keymap("n", "<leader>gh", ":lua Open_in_github()<CR>", { noremap = true, silent = true })
