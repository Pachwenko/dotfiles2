# fast docker helpers
dps()  { docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'; }
dim()  { docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}'; }
dclean(){ docker system prune -f; }

# compose shortcuts
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f --tail=200'

