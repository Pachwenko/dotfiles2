# Prefer user bin first
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Homebrew paths (macOS)
if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [[ -d /usr/local/bin ]]; then
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Linuxbrew (Linux)
if [[ -d /home/linuxbrew/.linuxbrew/bin ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# Postgres.app (macOS)
if [[ -d /Applications/Postgres.app/Contents/Versions/latest/bin ]]; then
  export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
fi

