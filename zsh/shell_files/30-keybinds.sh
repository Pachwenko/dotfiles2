bindkey -e
bindkey '^R' history-incremental-search-backward
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P'  up-line-or-beginning-search
bindkey '^N'  down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
