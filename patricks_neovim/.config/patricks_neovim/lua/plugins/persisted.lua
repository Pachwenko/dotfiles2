return {
	"olimorris/persisted.nvim",
	lazy = false,
	autostart = true,

	config = function()
		require("persisted").setup({
			---@type fun(): boolean
			should_save = function()
				return true
			end,

			save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/neovim_persisted_sessions/"),

			follow_cwd = true,
			use_git_branch = false,
			autoload = false,

			---@type fun(): any
			on_autoload_no_session = function() end,

			allowed_dirs = { "~/Projects" },
			ignored_dirs = { "~/Downloads" },
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistedLoadPre",
			callback = function()
				require("persisted").save({ session = vim.g.persisted_loaded_session })
				vim.api.nvim_input("<ESC>:%bd!<CR>")
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistedSavePre",
			callback = function()
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.bo[buf].filetype == "pyc" then
						vim.api.nvim_buf_delete(buf, { force = true })
					end
					if vim.bo[buf].filetype == "neo-tree" then
						vim.api.nvim_buf_delete(buf, { force = true })
					end
				end
			end,
		})
	end,
}
