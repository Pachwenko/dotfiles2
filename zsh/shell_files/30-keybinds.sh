# Enable vim-style keybindings
bindkey -v

# Keep existing search functionality
bindkey '^R' history-incremental-search-backward
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P'  up-line-or-beginning-search
bindkey '^N'  down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Additional vim-style keybindings
# ESC enters normal mode (already default with bindkey -v)
# In normal mode:
# - 'i' or 'a' enters insert mode
# - 'h', 'j', 'k', 'l' for movement
# - 'w', 'b', 'e' for word movement
# - '0', '$' for beginning/end of line
# - 'dd' to delete line
# - 'x' to delete character
# - 'u' to undo
# - 'r' to replace character
# - 'cw' to change word
# - 'cc' to change line

# Note: Removed 'v' binding to edit-command-line as it interfered with vi mode
# If you want to edit a command in your editor, use Ctrl+X Ctrl+E instead
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd 'v' edit-command-line
