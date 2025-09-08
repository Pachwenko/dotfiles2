alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lha'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias v='vim'   # or nvim if you prefer
alias pv='NVIM_APPNAME=patricks_neovim nvim'  # custom neovim config
# Editor aliases - using functions to handle spaces in paths better
code() {
    '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' "$@"
}

cursor() {
    '/Applications/Cursor.app/Contents/Resources/app/bin/cursor' "$@"
}
alias dc='docker compose'  # shorter

