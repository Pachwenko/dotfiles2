# Detect OS type for cross-platform compatibility
# Sets DOTFILES_OS to: macos, linux, wsl, or unknown

case "$(uname -s)" in
    Darwin)
        export DOTFILES_OS="macos"
        ;;
    Linux)
        if grep -qi microsoft /proc/version 2>/dev/null; then
            export DOTFILES_OS="wsl"
        else
            export DOTFILES_OS="linux"
        fi
        ;;
    *)
        export DOTFILES_OS="unknown"
        ;;
esac
