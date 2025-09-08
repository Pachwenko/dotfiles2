# fnm (fast Node version manager)
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi

# pnpm/npm/yarn completions if installed
for tool in pnpm npm yarn; do
  if command -v $tool >/dev/null 2>&1; then
    case $tool in
      pnpm) eval "$(pnpm completion zsh)" 2>/dev/null || true ;;
      npm)  eval "$(npm completion)" 2>/dev/null || true ;;
      yarn) yarn completion zsh >/dev/null 2>&1 && source <(yarn completion zsh) ;;
    esac
  fi
done

