# Nvim Setup

Leave very minimal config in your init.lua file

Project structure:
lua
- config has general lua files
  - keymaps
  - colorscheme
- plugins
  - See lazy plugin docs here https://lazy.folke.io/
  - only put lazy lua plugins in here!

### Setting up the dotfiles:

Creating symbolic links:
```
ln -s ~/newnewdotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -s ~/newnewdotfiles/.config/nvim/lua ~/.config/nvim/lua
```

Installing mac packages:
```
brew install ripgrep
brew install fzf

```

### Useful key mappings
If you hit the leader it will show possible keys combinations!

##### [Autocomplete with nvim-cmp](https://github.com/hrsh7th/nvim-cmp):
- Cycle options down <C-n>
- Cycle options up   <C-p>
- Accept             <C-y>

##### [Telescope](https://github.com/nvim-telescope/telescope.nvim):
- All possible:   <leader>s
- Search project: <leader>sp
- Search buffers: <leader>sb
- File Browser:   <leader>tr
- Grep search:    <leader>sg
- Search word:    <leader>sw
- Resume search:  <leader>sr
- Search Buffers: <leader><leader>

##### [Auto session](https://github.com/rmagatti/auto-session)
- Search sessions: <leader>sb
  - or :SearchSessions
- Save Session:    :SessionSave
- Load Session:    :SessionRestore

##### [Vim-Surround](https://github.com/tpope/vim-surround)
- Change surrounding (normal mode): S

