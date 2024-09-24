-- Set leader key
vim.g.mapleader = " "

-- Key mappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Visually move text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
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

-- Move between splits
keymap("n", "<C-h>", ":wincmd h<CR>", opts)
keymap("n", "<C-j>", ":wincmd j<CR>", opts)
keymap("n", "<C-k>", ":wincmd k<CR>", opts)
keymap("n", "<C-l>", ":wincmd l<CR>", opts)

-- Switch to previous buffer
keymap("n", "<Leader><Space>", "<C-^><CR>", opts)
