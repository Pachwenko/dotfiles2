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
ln -s ~/newnewdotfiles/nvim/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -s ~/newnewdotfiles/nvim/.config/nvim/lua ~/.config/nvim/lua
```

Installing mac packages:
```
brew install ripgrep
brew install fzf

```
