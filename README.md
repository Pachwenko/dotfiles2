# New new dotfiles
To replace the old stuff I had laying around.

## Neovim Setup

If you are new to neovim you can enter the tutorial by running `nvim +Tutor`

### Installing the dotfiles:

Clone to the repo to your home directory:
```shell
git clone https://github.com/Pachwenko/dotfiles2.git ~/patricks_dotfiles
```

```bash
# to install a single module
stow patricks_neovim

# to mass install everything
stow *
```

Installing mac packages:
```bash
cd ~/patricks_dotfiles
brew bundle
brew install fzf
```

Installing npm packages:
```terminal
npm i -g vscode-langservers-extracted
npm install -g @lifeart/ember-language-server
```

### Uninstalling the dotfiles

```bash
# to uninstall a single module
stow -D patricks_neovim

# to mass uninstall everything
stow -D *
```

### Useful Neovim key mappings
First, to run neovim with my profile do `NVIM_APPNAME=patricks_neovim nvim`

NOTE: If you hit a key and wait a second, neovim will show all possible shortcuts! Uses which-key plugin.

##### Vim keymappings

- Leader:               spacebar!
- Swap to last buffer:  <leader><leader>
- Vertical Split:       <leader>\\
- Horizontal Split:     <leader>-
- Save file             <leader>w
- Close file            <leader>q

##### Autocomplete

This project uses nvim-cmp and nvim-lsp. Mason is used to install autocomplete engines like pyright.

The normal autocomplete keys work like Enter and tab. You can add and remove tools using `:Mason`

##### [Custom Github Script](./patricks_neovim/.config/patricks_neovim/lua/custom_stuff/github.lua)
- Copy code location to clipboard: <leader>gh

##### [Custom Django Test Runner](./patricks_neovim/.config/patricks_neovim/lua/custom_stuff/django-test-runner.lua)
- Run test method: <leader>dm
    - may be kind of buggy, needs some work

##### [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua)
- File Browser:   <leader>tr
- Actions when browser is open:
    - a: Add file or directory
    - x: cut a file (to move it
    - p: paste a file (to move it)

##### Grep search utility
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
- Search buffers: <leader>sb
- Fuzzy search in file: <leader>/
- Fuzzy search in file: <leader>/

##### [Bafa](https://github.com/mistweaverco/bafa.nvim)
- Buffer Menu: <leader>bb

##### [Nvim-Tree](https://github.com/nvim-tree/nvim-tree.lua)
- Open file explorer:     <leader>tr
- Open file under cursor: l
- Add a file:             a
- Rename a file:          r
- Cut a file:             x
- Paste a file:           p
- Delete a file:          d

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

## Project structure:

`patricks_neovim/.config/patricks_neovim/lua`
- plugin_loader/lazy.lua has the lazy plugin manager definition
- core
  - vanilla stuff like vim options and keymappings
- custom_stuff
  - home to some custom lua functions
  - could be anything in here really
- plugins
  - only put lazy lua plugins in here! See lazy plugin docs here https://lazy.folke.io/
  - this is where you'll find most of the keymappings
- snippets
  - not sure if these are working, haven't got around to testing snippets yet

