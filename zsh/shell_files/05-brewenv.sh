if [[ -d /opt/homebrew ]]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
    export HOMEBREW_REPOSITORY="/opt/homebrew"
    fpath[1,0]="/opt/homebrew/share/zsh/site-functions"
    [[ -z "${MANPATH-}" ]] || export MANPATH=":${MANPATH#:}"
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"
elif command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

