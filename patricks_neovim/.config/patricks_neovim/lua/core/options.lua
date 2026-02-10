-- Disable unused providers (saves ~1s startup)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.have_nerd_font = true
vim.g.colorcolumn = 120

-- Disable GUI cursor
vim.opt.guicursor = ""

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Files
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"

-- UI
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.errorbells = false
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.mouse = "a"
vim.opt.scrolloff = 10
vim.opt.conceallevel = 2
vim.opt.updatetime = 250

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace display
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Live substitution preview
vim.opt.inccommand = "split"

-- Clipboard (scheduled to avoid startup delay)
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Session options
vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"

-- Custom filetypes
vim.filetype.add({
	extension = {},
	filename = {
		["ci.txt"] = "requirements",
		["dev.txt"] = "requirements",
		["dist.txt"] = "requirements",
		["base.txt"] = "requirements",
		["requirements.txt"] = "requirements",
	},
	pattern = {},
})
