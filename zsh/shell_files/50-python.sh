command -v direnv >/dev/null && eval "$(direnv hook zsh)"

if [[ -d "$HOME/.pyenv/shims" ]]; then
    export PATH="$HOME/.pyenv/shims:$PATH"
    export PYENV_SHELL=zsh
    pyenv() {
        unfunction pyenv
        eval "$(command pyenv init -)"
        pyenv "$@"
    }
fi

if command -v uv >/dev/null 2>&1; then
    alias pip="uv pip"
    alias python="uv python"
fi

export PIPENV_VENV_IN_PROJECT=1

mkvenv() { python -m venv .venv && source .venv/bin/activate; }
workon() { source .venv/bin/activate; }

_auto_venv() {
    local venv_activate=""
    for name in .venv venv env; do
        [[ -f "$name/bin/activate" ]] && venv_activate="$name/bin/activate" && break
    done

    if [[ -n "$_AUTO_VENV_ACTIVE" && "$PWD" != "$_AUTO_VENV_DIR"* ]]; then
        deactivate 2>/dev/null
        unset _AUTO_VENV_ACTIVE _AUTO_VENV_DIR
    fi

    if [[ -z "$_AUTO_VENV_ACTIVE" && -n "$venv_activate" ]]; then
        source "$venv_activate"
        _AUTO_VENV_ACTIVE=1
        _AUTO_VENV_DIR="$PWD"
    fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _auto_venv
_auto_venv
