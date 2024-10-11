-- A file explorer!
-- :NvimTreeOpen
--
-- To see possible mappings: :g?
-- https://github.com/nvim-tree/nvim-tree.lua
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			-- Other nvim-tree settings...
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				local opts = function(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- Custom function to open file and close nvim-tree
				local function open_file_or_folder()
					local node = api.tree.get_node_under_cursor() -- Get the current node (file or folder)

					if node and node.type == "file" then
						api.node.open.edit() -- Open the file
						vim.cmd("NvimTreeClose") -- Close nvim-tree only if it's a file
					elseif node and node.type == "directory" then
						api.node.open.edit() -- Open the directory without closing nvim-tree
					end
				end

				-- Custom mappings
				vim.keymap.set("n", "l", open_file_or_folder, opts("Open File and Close Tree"))
				vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
				-- Additional mappings for file operations
				vim.keymap.set("n", "a", api.fs.create, opts("Create a file or folder"))
				vim.keymap.set("n", "d", api.fs.remove, opts("Delete a file or folder"))
				vim.keymap.set("n", "r", api.fs.rename, opts("Rename a file or folder"))
				vim.keymap.set("n", "m", api.fs.cut, opts("Move a file or folder")) -- Move (cut)
				vim.keymap.set("n", "p", api.fs.paste, opts("Paste file or folder")) -- Paste (after moving or copying)
				vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy file or folder")) -- Copy node
				vim.keymap.set("n", "x", api.fs.cut, opts("Cut file or folder")) -- Cut node
				-- Add more mappings as needed
			end,
		})
		vim.keymap.set("n", "<leader>tr", ":NvimTreeToggle<CR>", { desc = "[T]ree [T]oggle" })
	end,
}
