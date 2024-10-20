# New new dotfiles
To replace the old stuff I had laying around.

## Neovim Setup

If you are new to neovim you can enter the tutorial by running `nvim +Tutor`

Project structure:
patricks_neovim/.config/patricks_neovim/lua
- config/lazy.pua has the lazy plugin manager definition
- custom_plugins
  - home to stuff like keymaps, settings
  - also home to some custom lua functions
- plugins
  - See lazy plugin docs here https://lazy.folke.io/
  - only put lazy lua plugins in here!
- snippets
  - not sure if these are working yet, haven't got around to really testing snippets

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

### Useful Neovim key mappings
First, to run neovim with my profile do `NVIM_APPNAME=patricks_neovim nvim`
> the author has this aliased to `pv` =)

NOTE: If you hit a key and wait a second, neovim will show all possible shortcuts! Uses which-key plugin.

##### [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua)
- File Browser:   <leader>tr
- Actions when browser is open:
    - a: Add file or directory
    - x: cut a file (to move it
    - p: paste a file (to move it)

#### Grep search utility
This is a custom lua plugin in the custom_plugins folder
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

##### [Persisted Sessions](https://github.com/olimorris/persisted.nvim)
Automatically saves your last session. Can be disabled in the plugins/persisted.lua file
- Search sessions: <leader>ss
  - or :Telescope persisted
- Save Session:    :SessionSave
- Load Session:    :SessionLoad

##### [Vim-Surround](https://github.com/tpope/vim-surround)
- Change surrounding (normal mode): S

