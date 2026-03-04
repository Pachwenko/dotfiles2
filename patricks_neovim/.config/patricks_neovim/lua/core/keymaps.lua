-- Key mappings
-- Also see plugins and other .lua files for keymaps (can be anywhere!)
-- Ideally plugin specific keympaps live with the plugin
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- NOTE: the leader key is mapped in the init.lua file and not here
-- typically is space
vim.g.mapleader = " "

-- Visually move text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Yank till end of line
vim.keymap.set("n", "Y", "yg$", { desc = "Yank to end of line" })

-- Search and center (Unified)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result and center" })

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- Create splits
vim.keymap.set("n", "<Leader>\\", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<Leader>-", ":split<CR>", { desc = "Horizontal split" })

-- Switch to previous buffer
vim.keymap.set("n", "<Leader><Space>", "<C-^><CR>", { desc = "Switch to prev buffer" })

-- Reload Neovim
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "Source Vim Configuration" })

-- Clear highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Navigation shortcuts
vim.keymap.set("n", "H", "^", { desc = "Start of line" })
vim.keymap.set("n", "L", "$", { desc = "End of line" })

-- Resize splits
vim.keymap.set("n", "<Up>", ":resize +2<CR>")
vim.keymap.set("n", "<Down>", ":resize -2<CR>")
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>")

-- Scroll and Center
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Move to first non-blank
vim.keymap.set("n", "<BS>", "^")
vim.keymap.set("n", "<S-BS>", "$")

-- Search and replace shortcuts
vim.keymap.set("n", "<leader>ss", ":s/\\v", { desc = "Search/Replace Line" })
vim.keymap.set("n", "<leader>SS", ":%s/\\v", { desc = "Search/Replace File" })
vim.keymap.set("v", "<leader>sV", ":s/\\%V", { desc = "Replace in Selection" })
vim.keymap.set("v", "<C-S-d>", '"hy:%s/\\v<C-r>h//g<left><left>', { desc = "Change selection (all)" })
vim.keymap.set("v", "<C-d>", '"hy:%s/\\v<C-r>h//c<left><left>', { desc = "Change selection (confirm)" })
vim.keymap.set("n", "/", "/\\v", { desc = "Very magic search" })

-- Top/Bottom centered
vim.keymap.set("n", "<leader>gg", "ggzz")
vim.keymap.set("n", "<leader>Gg", "Gzz")

-- Toggles
vim.keymap.set("n", "<leader>tn", ":set relativenumber!<CR>")
vim.keymap.set("n", "<leader>ts", ":set spell!<CR>")
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>")

-- Moving Lines (Alt+j/k)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")

-- Workspace
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>wq", ":wq<CR>")
vim.keymap.set("n", "<leader>ls", ":SessionLoad<CR>")

-- VS Code Specific Keymaps
if vim.g.vscode then
	local vscode = require("vscode")

	-- Navigation & Jumps
	vim.keymap.set("n", "<C-o>", function() vscode.action("workbench.action.navigateBack") end)
	vim.keymap.set("n", "<C-i>", function() vscode.action("workbench.action.navigateForward") end)

	-- Explorer
	vim.keymap.set("n", "<leader>tr", function() vscode.action("workbench.action.toggleSidebarVisibility") end)
	vim.keymap.set("n", "<leader>ee", function() vscode.action("workbench.view.explorer") end)
	vim.keymap.set("n", "\\", function() vscode.action("revealInExplorer") end)

	-- Search
	vim.keymap.set("n", "<leader>sf", function() vscode.action("workbench.action.quickOpen") end)
	vim.keymap.set("n", "<leader>sg", function() vscode.action("workbench.action.findInFiles") end)
	vim.keymap.set("n", "<leader>sb", function() vscode.action("workbench.action.showAllEditors") end)
	vim.keymap.set("n", "<leader>/", function() vscode.action("actions.find") end)

	-- Git
	vim.keymap.set("n", "<leader>lg", function() vscode.action("workbench.view.scm") end)
	vim.keymap.set("n", "<leader>gb", function() vscode.action("editor.action.showBlame") end)

	-- Intelligence
	vim.keymap.set("n", "gd", function() vscode.action("editor.action.revealDefinition") end)
	vim.keymap.set("n", "gr", function() vscode.action("editor.action.goToReferences") end)
	vim.keymap.set("n", "<leader>ca", function() vscode.action("editor.action.quickFix") end)
	vim.keymap.set("n", "<leader>rn", function() vscode.action("editor.action.rename") end)
	vim.keymap.set("n", "<leader>fm", function() vscode.action("editor.action.formatDocument") end)
	vim.keymap.set({ "n", "x" }, "<leader>r", function() vscode.action("editor.action.refactor") end)

	-- Terminal
	vim.keymap.set("n", "<leader>tt", function() vscode.action("workbench.action.terminal.toggleTerminal") end)

	-- Chat controls
	vim.keymap.set("n", "<leader>tc", function()
		vscode.action("antigravity.toggleChatFocus")
		vscode.action("workbench.action.focusAuxiliaryBar")
	end)
	vim.keymap.set("n", "<leader>cc", function()
		vscode.action("workbench.action.toggleAuxiliaryBar")
	end)
end
