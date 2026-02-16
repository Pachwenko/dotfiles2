bindkey -v
export KEYTIMEOUT=1

if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    export FZF_DEFAULT_OPTS='--bind ctrl-j:down,ctrl-k:up,ctrl-d:half-page-down,ctrl-u:half-page-up'

    _fzf_lazy_load() {
        unfunction _fzf_lazy_load
        source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
        source /opt/homebrew/opt/fzf/shell/completion.zsh
        bindkey '^G' fzf-cd-widget
    }

    fzf-file-widget() { _fzf_lazy_load; fzf-file-widget; }
    fzf-cd-widget() { _fzf_lazy_load; fzf-cd-widget; }
    fzf-history-widget() { _fzf_lazy_load; fzf-history-widget; }

    zle -N fzf-file-widget
    zle -N fzf-cd-widget
    zle -N fzf-history-widget

    bindkey '^T' fzf-file-widget
    bindkey '^G' fzf-cd-widget
    bindkey '^R' fzf-history-widget
else
    bindkey '^R' history-incremental-search-backward
fi

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P'  up-line-or-beginning-search
bindkey '^N'  down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# ... expands to ../..
traverse_up() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N traverse_up
bindkey . traverse_up
