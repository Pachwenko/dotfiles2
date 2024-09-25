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
ln -s ~/newnewdotfiles/.config/.flake8 ~/.flake8
ln -s ~/newnewdotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/newnewdotfiles/.config/nvim/lua ~/.config/nvim/lua
ln -s ~/newnewdotfiles/.config/nvim/snippets ~/.config/nvim/snippets
```

Installing mac packages:
```
brew install ripgrep
brew install fzf

```

### Useful key mappings
If you hit the leader it will show possible keys combinations!

##### [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua)
- File Browser:   <leader>tr
- Actions when browser is open:
    - a: Add file or directory
    - TODO: add more examples

##### Project Searching
- Change surrounding (normal mode): S

##### [Autocomplete with nvim-cmp](https://github.com/hrsh7th/nvim-cmp):
- Search project:   <leader>sp
    - Include term: <leader>g
    - Exclude term: <leader>v

##### [Telescope](https://github.com/nvim-telescope/telescope.nvim):
- All possible:   <leader>s
- Search buffers: <leader>sb
- Grep search:    <leader>sg
- Search word:    <leader>sw
- Resume search:  <leader>sr
- Search Buffers: <leader><leader>

##### [Vim-Surround](https://github.com/tpope/vim-surround)
- Change surrounding (normal mode): S

##### [Auto session](https://github.com/rmagatti/auto-session)
Automatically saves your last session. Can be disabled.
- Search sessions: <leader>sb
  - or :SearchSessions
- Save Session:    :SessionSave
- Load Session:    :SessionRestore

##### [Vim-Surround](https://github.com/tpope/vim-surround)
- Change surrounding (normal mode): S

