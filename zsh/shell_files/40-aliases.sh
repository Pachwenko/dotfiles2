alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lha'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias lg='lazygit'
alias ts='lazygit'  # I prefer lazygit over "tig status"
alias v='vim'   # or nvim if you prefer
alias pv='NVIM_APPNAME=patricks_neovim nvim'  # custom neovim config
alias jv='NVIM_APPNAME=jims_neovim nvim'  # custom neovim config

# Editor aliases - cross-platform
if [[ "$DOTFILES_OS" == "macos" ]]; then
    code() {
        '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' "$@"
    }
    cursor() {
        '/Applications/Cursor.app/Contents/Resources/app/bin/cursor' "$@"
    }
fi
# On Linux/WSL, code and cursor are typically in PATH if installed

alias dc='docker compose'  # shorter
alias publish='git publish' # Shortcut for git publish alias
