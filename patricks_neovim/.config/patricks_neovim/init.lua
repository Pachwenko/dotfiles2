-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

if vim.g.vscode then
  -- VS Code extension limits: We only need core keymaps, options, and autocommands
  require("core.options")
  require("core.keymaps")
  require("core.autocommands")
  require("custom_stuff.load_files")  -- Load custom scripts like grep_search, github, etc.
else
  -- Ordinary Neovim features
  require("plugin_loader.lazy") -- plugin manager, :Lazy
  require("core.load_files") -- basic neovim stuff, does not have ALL the keymappings (see individual plugin files for more, like telescope.lua)
  require("custom_stuff.load_files")  -- all the extra stuff, could be pseudo-plugins in here
end
