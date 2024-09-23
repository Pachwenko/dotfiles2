-- Disable GUI cursor
vim.opt.guicursor = ""

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Other options
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamedplus"

-- Enable plugins and syntax
vim.cmd("filetype plugin on")
vim.cmd("syntax on")

require('config.lazy')
require('config.colorscheme')
require('config.autocomplete')
require('config.django-test-runner')
require('config.keymaps')
