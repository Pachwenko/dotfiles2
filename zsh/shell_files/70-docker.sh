# fast docker helpers
dps()  { docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'; }
dim()  { docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}'; }
dclean(){ docker system prune -f; }

# compose shortcuts
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f --tail=200'
alias dcr='docker compose restart'

# docker compose service completion
# Completes service names from compose.yml / docker-compose.yml for common dc* aliases
_dc_services() {
    local compose_file
    for f in compose.yml compose.yaml docker-compose.yml docker-compose.yaml; do
        [[ -f "$f" ]] && compose_file="$f" && break
    done
    [[ -z "$compose_file" ]] && return

    local services
    services=($(grep -E '^\s{2}\S+:' "$compose_file" 2>/dev/null | sed 's/://;s/^[[:space:]]*//' | grep -v '^#'))
    compadd -a services
}

# Wrapper that completes service names for docker compose subcommands
dce()  { docker compose exec "$@"; }
dcru() { docker compose run --rm "$@"; }
dcb()  { docker compose build "$@"; }
dclog(){ docker compose logs -f --tail=200 "$@"; }

compdef _dc_services dce dcru dcb dclog
