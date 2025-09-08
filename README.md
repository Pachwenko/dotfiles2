# New new dotfiles
To replace the old stuff I had laying around.


### Dotfiles repo structure

This repo is organized using [GNU Stow](https://www.gnu.org/software/stow/) for easy management. Here's what you can grab:

#### 🖥️ **Shell Configuration** (`zsh/`)
- **Main config**: `zsh/.zshrc` - Main shell configuration file
- **Aliases**: `zsh/shell_files/40-aliases.sh` - Git, Docker, Editor aliases (`gs`, `gd`, `pv`, `code`, `cursor`, etc.)
- **Keybinds**: `zsh/shell_files/30-keybinds.sh` - Custom keybindings for terminal
- **History**: `zsh/shell_files/10-history.sh` - Shell history configuration
- **Completions**: `zsh/shell_files/20-completions.sh` - Auto-completion setup
- **Path setup**: `zsh/shell_files/00-path.sh` - PATH environment variables
- **Brew environment**: `zsh/shell_files/05-brewenv.sh` - Homebrew setup
- **Python**: `zsh/shell_files/50-python.sh` - Python environment setup
- **Node.js**: `zsh/shell_files/60-node.sh` - Node.js/npm configuration
- **Docker**: `zsh/shell_files/70-docker.sh` - Docker aliases and setup
- **Terraform**: `zsh/shell_files/terraform.sh` - Terraform configuration

#### 🎨 **Neovim Configuration** (`patricks_neovim/`)
- **Main config**: `patricks_neovim/.config/patricks_neovim/init.lua` - Entry point
- **Plugin manager**: `patricks_neovim/.config/patricks_neovim/lua/plugin_loader/lazy.lua` - Lazy.nvim setup
- **Core settings**: `patricks_neovim/.config/patricks_neovim/lua/core/` - Basic vim options, keymaps, colorscheme
- **Plugins**: `patricks_neovim/.config/patricks_neovim/lua/plugins/` - All plugin configurations
- **Custom functions**: `patricks_neovim/.config/patricks_neovim/lua/custom_stuff/` - Custom Lua functions
- **Snippets**: `patricks_neovim/.config/patricks_neovim/snippets/` - Code snippets

#### 🖥️ **Terminal Multiplexer** (`tmux/`)
- **Config**: `tmux/.tmux.conf` - Tmux configuration with Tokyo Night theme

#### 📦 **Package Management** (`homebrew/`)
- **Brewfile**: `homebrew/Brewfile` - All Homebrew packages and casks

#### 🔧 **Git Configuration** (`git/`)
- **Git config**: `git/.gitconfig` - Git configuration (user, colors, aliases, etc.)
- **Global gitignore**: `git/.gitignore_global` - Global gitignore patterns


### Installing the dotfiles:

Clone to the repo to your home directory:
```shell
git clone https://github.com/Pachwenko/dotfiles2.git ~/patricks_dotfiles
```

```bash
# to install a single module
stow patricks_neovim

# to mass install everything
stow homebrew patricks_neovim tmux zsh
```

Installing mac packages:
```bash
cd ~/patricks_dotfiles/Homebrew
brew bundle

# nerd font, make sure to configure your terminal to use this
# could be whichever fond you prefer
brew install --cask font-hack-nerd-font
```

Installing npm packages (for neovim autocompletions):
```terminal
npm i -g vscode-langservers-extracted
npm install -g @lifeart/ember-language-server
```

Installing tmux theme:
```terminal
git clone https://github.com/zMoooooritz/tokyonight-tmux.git ~/.tmux/plugins/tokyonight-tmux
```

Install iterm themes:

- [https://iterm2colorschemes.com/](https://iterm2colorschemes.com/)

### Uninstalling the dotfiles

```bash
# to uninstall a single module
stow -D patricks_neovim

# to mass uninstall everything
stow -D homebrew patricks_neovim tmux zsh
```

## Neovim Setup

If you are new to neovim you can enter the tutorial by running `nvim +Tutor`

### Useful Neovim key mappings

Firstly, you can launch MY neovim by using `pv` command. This allows you to add your own neovim stuff if you wish. Running `nvim` directly will use the default configuration, not this custom one. You probably don't want to do that.

**Option 1: Use the alias (recommended)**
```bash
pv  # This will launch nvim with the custom config
```

**Option 2: Use the environment variable**
```bash
NVIM_APPNAME=patricks_neovim nvim
```

NOTE: If you hit a key and wait a second, neovim will show all possible shortcuts! Uses which-key plugin.

##### Vim keymappings

- Leader:               spacebar!
- Swap to last buffer:  <leader><leader>
- Vertical Split:       <leader>\\
    - or :vs
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
- All possible:         <leader>s
- Search buffers:       <leader>sb
- Grep search:          <leader>sg
- Find file by name:    <leader>sf
- Search Files:         <leader>sg
- Resume search:        <leader>sr
- Search buffers:       <leader>sb
- Fuzzy search in file: <leader>/
- Search sessions:      <leader>ss

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
- Change surrounding (visual mode): S

##### [Persisted Sessions](https://github.com/olimorris/persisted.nvim)
Automatically saves your last session. Can be disabled in the plugins/persisted.lua file
- Search sessions: <leader>ss
  - or :Telescope persisted
- Save Session:    :SessionSave
- Load Session:    :SessionLoad

#### Other Keybindings

**comments**
In visual mode you can command and un-commend using `gc` or just to do the current like `gcl`


#### Interesting commands/plugins

**tokyonight**
This is the colorscheme, you can use whatever you want.

**Showkeys**
This plugin shows what keys you press, useful to showing people vim. Run the command :ShowkeysToggle

**Conform**
This plugin auto-formats your code, either automatically or with a command.