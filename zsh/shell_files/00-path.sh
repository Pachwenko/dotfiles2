# Prefer user bin first
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Homebrew (Apple Silicon default)
if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [[ -d /usr/local/bin ]]; then
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

