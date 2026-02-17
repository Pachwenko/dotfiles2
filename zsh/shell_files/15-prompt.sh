autoload -Uz vcs_info add-zsh-hook

zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:git:*' max-exports 1
add-zsh-hook precmd vcs_info

PROMPT='%F{green}%d%f%F{yellow}${vcs_info_msg_0_}%f%(1j. %F{blue}%j%f.) %F{cyan}→%f '
RPROMPT='%F{magenta}%T%f'
