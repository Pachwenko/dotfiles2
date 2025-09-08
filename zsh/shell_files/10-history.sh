# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=20000
export SAVEHIST=20000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY

# Completion cache
: "${XDG_CACHE_HOME:=$HOME/.cache}"
mkdir -p "$XDG_CACHE_HOME/zsh" >/dev/null 2>&1

