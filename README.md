# Patrick's Dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Set up for Django, Ember, React, Terraform, and Docker development.

## Quick Start

```bash
git clone https://github.com/Pachwenko/dotfiles2.git ~/patricks_dotfiles
cd ~/patricks_dotfiles
stow homebrew tmux git zsh patricks_neovim
```

## What's Inside

| Module | What it does |
|--------|-------------|
| `zsh/` | Shell config, aliases, keybinds, Python/Node/Docker setup |
| `patricks_neovim/` | Full Neovim config with LSP, completions, and 30+ plugins ([details](./patricks_neovim/.config/patricks_neovim/PLUGINS.md)) |
| `tmux/` | Tmux config with Tokyo Night theme |
| `homebrew/` | Brewfile with all packages and casks |
| `git/` | Git config and global gitignore |

## Neovim

Launch with `pv` (not `nvim` — that uses the default config):

```bash
pv                                    # recommended
NVIM_APPNAME=patricks_neovim nvim     # or set the env var directly
```

Press any key and wait — [which-key](https://github.com/folke/which-key.nvim) will show all available shortcuts. Leader is `space`.

### Key Bindings (essentials)

| Key | Action |
|-----|--------|
| `space` | Leader key |
| `<leader>sf` | Find files |
| `<leader>sg` | Grep search |
| `<leader>lg` | Open lazygit |
| `<leader>ee` | Toggle file tree |
| `gd` | Go to definition |
| `gr` | Find references |
| `<leader>ca` | Code actions |
| `<leader>fm` | Format buffer |
| `<leader>dm` | Run Django test method (Docker) |

Full plugin reference: [PLUGINS.md](./patricks_neovim/.config/patricks_neovim/PLUGINS.md)

### LSP Servers

Managed by Mason (`:Mason` to view). Configured for:

- **Python**: pylsp (with black, isort, flake8, jedi)
- **JavaScript/TypeScript**: ts_ls, biome
- **Ember**: ember-language-server
- **Terraform**: terraform-ls
- **Docker**: dockerfile-ls, docker-compose-language-service
- **Web**: html, css, json, yaml
- **Lua**: lua_ls (for Neovim config)

### Config Structure

```
patricks_neovim/.config/patricks_neovim/
  init.lua                  # entry point
  lua/core/                 # options, keymaps, colorscheme
  lua/plugins/              # all plugin configs (lazy.nvim)
  lua/custom_stuff/         # custom scripts (Django test runner, GitHub links, grep)
  snippets/                 # code snippets
```

### Custom Scripts

- [Django test runner](./patricks_neovim/.config/patricks_neovim/lua/custom_stuff/django-test-runner.lua) — `<leader>dm` runs test method in Docker
- [GitHub link copier](./patricks_neovim/.config/patricks_neovim/lua/custom_stuff/github.lua) — `<leader>gh` copies code location to clipboard
- [Grep search](./patricks_neovim/.config/patricks_neovim/lua/custom_stuff/grep_search.lua) — `<leader>sp` project search with include/exclude

## Installation

### macOS

```bash
cd ~/patricks_dotfiles/homebrew
brew bundle
brew install --cask font-hack-nerd-font  # configure your terminal to use this
```

### Linux/WSL

```bash
cd ~/patricks_dotfiles
./linux-install.sh
```

Build Neovim from source if needed:
```bash
git clone https://github.com/neovim/neovim ~/neovim
cd ~/neovim && git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
```

### Tmux Theme

```bash
git clone https://github.com/zMoooooritz/tokyonight-tmux.git ~/.tmux/plugins/tokyonight-tmux
```

## Uninstalling

```bash
stow -D homebrew tmux git zsh patricks_neovim
```

## Shell Customization

Extra shell configs are sourced from `~/imtapps-custom-configs/`. Change the path in `.zshrc` if you want a different location.
