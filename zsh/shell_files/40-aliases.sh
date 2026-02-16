export EDITOR="NVIM_APPNAME=patricks_neovim nvim"
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"

alias grep='rg -i'
alias ag='rg'

alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

alias ll='ls -lh'
alias la='ls -A'
alias lla='ls -lha'

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
    export BAT_THEME="ansi"
fi

alias gs='git status'
alias gd='git diff'
alias s='git status'
alias gc='git commit'
alias amend='git commit --amend'
alias co='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias publish='git publish'
alias push='git publish'
alias pull='git pull --rebase'
alias fetch='git fetch'
alias mm='git fetch && git merge origin/master'
alias gmm='git fetch && git rebase origin/main'
alias stash='git stash'
alias pop='git stash pop'
alias clone='gh repo clone'
alias lg='lazygit'
alias ts='lazygit'

gcm() {
    if git show-ref --quiet refs/heads/main; then
        git switch main
    elif git show-ref --quiet refs/heads/master; then
        git checkout master
    fi
}

alias v='vim'
alias pv='NVIM_APPNAME=patricks_neovim nvim'
alias jv='NVIM_APPNAME=jims_neovim nvim'

if [[ "$DOTFILES_OS" == "macos" ]]; then
    code() { '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' "$@"; }
    cursor() { '/Applications/Cursor.app/Contents/Resources/app/bin/cursor' "$@"; }
fi

if [[ "$DOTFILES_OS" == "macos" ]] && [[ "$(uname -m)" == "arm64" ]]; then
    alias ibrew='arch -x86_64 /usr/local/bin/brew'
    alias mbrew='arch -arm64e /opt/homebrew/bin/brew'
fi

alias dc='docker compose'

alias m='python manage.py'
alias mr='python manage.py remote_staging runserver'
alias mt='python manage.py test test'
alias mft='python manage.py test test --parallel=4 --failfast'
alias srcm='python src/manage.py'
alias srcmr='python src/manage.py remote_staging runserver'
alias srcmt='python src/manage.py test test'
alias srcmft='python src/manage.py test test --parallel=4 --failfast'

alias et='ember t --server'
alias es='ember serve'
alias essl='ember server --ssl --ssl-key ~/.tls/localhost.imtapps.com.key --ssl-cert ~/.tls/localhost.imtapps.com.crt --port 4200'

alias pft='pytest -n auto --disable-warnings --durations=10 --durations-min=1.0 -ra'
alias pyclean="find . -name '*.pyc' -delete -or -type d -name '__pycache__' -delete"

alias stopvpn='launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*'
alias startvpn='launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*'

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

p() {
    local dir
    dir=$(fd --type d --max-depth 1 . ~/Projects ~/Experiments 2>/dev/null \
        | fzf --query="${1:-}" --select-1 --exit-0 \
              --preview 'ls -1 {} | head -20' \
              --header 'Pick a project') \
    && cd "$dir"
}

rgi() {
    local file line result
    result=$(rg --color=always --line-number --no-heading --smart-case "${*:-}" \
        | fzf --ansi \
              --delimiter : \
              --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
              --preview-window 'up,60%,border-bottom,+{2}+3/3,~3') \
    && file=$(echo "$result" | cut -d: -f1) \
    && line=$(echo "$result" | cut -d: -f2) \
    && ${EDITOR:-vim} "+${line}" "$file"
}

extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xvjf "$1"   ;;
            *.tar.gz)  tar xvzf "$1"   ;;
            *.tar.xz)  tar xvJf "$1"   ;;
            *.bz2)     bunzip2 "$1"    ;;
            *.rar)     unrar x "$1"    ;;
            *.gz)      gunzip "$1"     ;;
            *.tar)     tar xvf "$1"    ;;
            *.tbz2)    tar xvjf "$1"   ;;
            *.tgz)     tar xvzf "$1"   ;;
            *.zip)     unzip "$1"      ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1"       ;;
            *.zst)     unzstd "$1"     ;;
            *)         echo "'$1' -- unknown archive format" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
