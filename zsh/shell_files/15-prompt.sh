# Custom ZSH Prompt
# A clean, informative prompt with git status and directory info

# Enable colors
autoload -U colors && colors

# Git prompt functions
autoload -Uz vcs_info
precmd() { vcs_info }

# Configure git info format
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:*' enable git

# Set up the prompt
setopt PROMPT_SUBST

# Custom prompt with:
# - Full current directory path in green
# - Git branch in yellow (if in a git repo)
# - Clean arrow separator
PROMPT='%F{green}%d%f%F{yellow}${vcs_info_msg_0_}%f%(1j. %F{blue}%j%f.) %F{cyan}→%f '


# Right prompt with timestamp
RPROMPT='%F{magenta}%T%f'
