# macOS handles ssh-agent via launchd, only needed on Linux/WSL
if [[ "$DOTFILES_OS" != "macos" && -z "$SSH_AUTH_SOCK" ]]; then
    local running
    running=$(pgrep -c ssh-agent 2>/dev/null || echo 0)
    if [[ "$running" == "0" ]]; then
        ssh-agent -s &> "$HOME/.ssh/ssh-agent"
    fi
    eval "$(< "$HOME/.ssh/ssh-agent")"
fi
