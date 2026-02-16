autoload -U colors && colors
autoload -Uz vcs_info add-zsh-hook

zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:*' enable git
add-zsh-hook precmd vcs_info

PROMPT='%F{green}%d%f%F{yellow}${vcs_info_msg_0_}%f%(1j. %F{blue}%j%f.) %F{cyan}→%f '
RPROMPT='%F{magenta}%T%f'
