-- Project picker using Snacks.picker
-- Scans ~/Projects and ~/Experiments for top-level directories,
-- cd's into the selection, and loads a persisted session if one exists.
local function pick_project()
	local dirs = {}
	for _, root in ipairs({ "~/Projects", "~/Experiments" }) do
		local expanded = vim.fn.expand(root)
		local entries = vim.fn.globpath(expanded, "*", false, true)
		for _, entry in ipairs(entries) do
			if vim.fn.isdirectory(entry) == 1 then
				table.insert(dirs, {
					text = vim.fn.fnamemodify(entry, ":t"),
					file = entry,
					root = vim.fn.fnamemodify(expanded, ":t"),
				})
			end
		end
	end

	Snacks.picker({
		title = "Projects",
		items = dirs,
		format = function(item)
			return {
				{ item.root .. "/", "Comment" },
				{ item.text, "Normal" },
			}
		end,
		confirm = function(picker, item)
			picker:close()
			if item then
				vim.cmd("cd " .. vim.fn.fnameescape(item.file))
				-- Try to load a persisted session for this project
				local ok, persisted = pcall(require, "persisted")
				if ok then
					pcall(persisted.load)
				end
			end
		end,
	})
end

vim.api.nvim_create_user_command("ProjectPicker", pick_project, {})

-- Expose for keybinds and dashboard
_G.pick_project = pick_project

vim.api.nvim_create_user_command("Newbuff", "silent! | :vsplit | enew", {})
vim.api.nvim_create_user_command("Black", "silent! | :!black --line-length 120 %", {})
vim.api.nvim_create_user_command("Isort", "silent! | :!isort -e %", {})
vim.api.nvim_create_user_command("Spellon", "setlocal spell spelllang=en_us", {})
vim.api.nvim_create_user_command("Spelloff", "setlocal nospell", {})
