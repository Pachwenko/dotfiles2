export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

_auto_nvm() {
    local version_file=""
    for f in .nvmrc .node-version .tool-versions; do
        [[ -f "$f" ]] && version_file="$f" && break
    done
    [[ -z "$version_file" ]] && return

    local wanted current
    if [[ "$version_file" == ".tool-versions" ]]; then
        wanted=$(awk '/^nodejs / {print $2}' .tool-versions)
        [[ -z "$wanted" ]] && return
    else
        wanted=$(< "$version_file")
    fi
    current=$(nvm current 2>/dev/null)
    if [[ "$current" != "$wanted" && "$current" != "v$wanted" ]]; then
        nvm use --silent
    fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _auto_nvm
_auto_nvm

# uncomment to switch from nvm to fnm
# if command -v fnm >/dev/null 2>&1; then
#   eval "$(fnm env --use-on-cd)"
# fi
