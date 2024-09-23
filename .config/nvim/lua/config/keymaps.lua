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


-- Telescope commands
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Nvim Tree (use telescope instead)
-- vim.api.nvim_set_keymap('n', '<Leader>tr', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Leader>gr', ':NvimTreeToggle<CR>', { noremap = true, silent = true })


-- Telescope file browser
vim.keymap.set("n", "<leader>tr", function()
	require("telescope").extensions.file_browser.file_browser()
end)

