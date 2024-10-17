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

### Installing the dotfiles:

Clone to the repo to your home directory:
```shell
git clone https://github.com/Pachwenko/dotfiles2.git ~/patricks_dotfiles
```


```bash
# to install a single module
stow nvim

# to mass install everything
stow *
```

Installing mac packages:
```bash
brew bundle
brew install fzf
```

### Uninstalling the dotfiles

```bash
# to uninstall a single module
stow -D nvim

# to mass uninstall everything
stow -D *
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

##### [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua)
- Open file explorer:   <leader>tr
- Add a file:           a
- Rename a file:        r
- Cut a file:           x
- Paste a file:         p
- Delete a file:        d

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

