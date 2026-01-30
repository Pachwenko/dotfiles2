# ZSH Completion Configuration
# Enables fuzzy/substring tab completion that matches anywhere in words, not just the beginning.
# Provides case-insensitive matching, menu selection, and approximate matching for typos.

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump" 2>/dev/null

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' special-dirs true

setopt COMPLETE_IN_WORD ALWAYS_TO_END AUTO_MENU MENU_COMPLETE GLOB_COMPLETE
