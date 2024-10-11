-- Key mappings
-- Also see plugins and other .lua files for keymaps (can be anywhere!)
-- Ideally plugin specific keympaps live with the plugin
--
-- This file is more for native vim keymappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Visually move text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
--
-- Yank till end of line
keymap("n", "Y", "yg$", opts)

-- Keep cursor centered when searching
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Keep cursor in place when joining lines
keymap("n", "J", "mzJ`z", opts)

-- Create splits
keymap("n", "<Leader>\\", ":vsplit<CR>", opts)
keymap("n", "<Leader>-", ":split<CR>", opts)

-- Switch to previous buffer
keymap("n", "<Leader><Space>", "<C-^><CR>", opts)

-- Reload Neovim
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "Source Vim Configuration" })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Map H to move to the first non-blank character of the line
vim.api.nvim_set_keymap("n", "H", "^", { noremap = true, silent = true })

-- Map L to move to the end of the line
vim.api.nvim_set_keymap("n", "L", "$", { noremap = true, silent = true })
