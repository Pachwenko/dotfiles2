# Terraform autocomplete (if installed with brew: `terraform -install-autocomplete`)
if [[ -f ~/.terraform.d/plugin-cache ]]; then
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
fi

alias tf='terraform'
alias tfa='terraform apply'
alias tfp='terraform plan'
alias tfi='terraform init'

