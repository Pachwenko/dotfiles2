# direnv (per-project envs)
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# uv (fast Python package manager / venvs)
if command -v uv >/dev/null 2>&1; then
  alias pip="uv pip"
  alias python="uv python"  # optional; or leave python alone
fi

# pipx (global CLI tools)
if command -v pipx >/dev/null 2>&1; then
  eval "$(register-python-argcomplete pipx)" 2>/dev/null || true
fi

# pyenv (only if you actually use it)
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# helpers
mkvenv() { python -m venv .venv && source .venv/bin/activate; }
workon() { source .venv/bin/activate }

