-- Key mappings
-- Also see plugins and other .lua files for keymaps (can be anywhere!)
-- Ideally plugin specific keympaps live with the plugin
--
-- This file is more for native vim keymappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- NOTE: the leader key is mapped in the init.lua file and not here
-- typically is space


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

-- Resize splits using arrow keys
vim.api.nvim_set_keymap("n", "<Up>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- Scroll and Center
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = "Scroll up and center"})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = "Scroll down and center"})

-- Search and center
vim.keymap.set("n", "n", "nzzzv", {desc = "Search and center"})
vim.keymap.set("n", "N", "Nzzzv", {desc = "Search and center"})

-- Move to first non-blank
vim.keymap.set("n", "<BS>", "^", {desc = "Move to first non-blank character"})
vim.keymap.set("n", "<S-BS>", "$", {desc = "Move to the end of the line"})

-- Convenience Search
vim.keymap.set("n", "<leader>ss", ":s/\\v", {desc = "Search and replace on line"})
vim.keymap.set("n", "<leader>SS", ":%s/\\v", {desc = "Search and replace on file"})
vim.keymap.set("v", "<leader>sV", ":s/\\%V", {desc = "Search and replace, only in visual selection"})
vim.keymap.set("v", "<C-S-d>", '"hy:%s/\\v<C-r>h//g<left><left>', {desc= "Change selected text, whole file"})
vim.keymap.set("v", "<C-d>", '"hy:%s/\\v<C-r>h//c<left><left>', {desc= "Change selected text, with confirmation"})
vim.keymap.set("n", "/", "/\\v", { desc = "Start search with very magic" })

-- go to top/bottom centered
vim.keymap.set("n", "<leader>gg", "ggzz", { desc = "Go to Top and Center" })
vim.keymap.set("n", "<leader>Gg", "Gzz", { desc = "Go to Bottom and Center" })

-- toggle options
vim.keymap.set("n", "<leader>tn", ":set relativenumber!<CR>", { desc = "Toggle Relative Numbers" })
vim.keymap.set("n", "<leader>ts", ":set spell!<CR>", { desc = "Toggle Spell Check" })
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "Toggle Line Wrap" })

-- Moving Lines Up and Down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Buffer Management
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })

-- Quick Save and Quit
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save File" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and Quit" })
