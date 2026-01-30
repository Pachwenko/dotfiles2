# Terraform autocomplete (if installed with brew: `terraform -install-autocomplete`)
if [[ -f ~/.terraform.d/plugin-cache ]]; then
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
fi

alias tfa='terraform apply'
alias tfp='terraform plan'
alias tfi='terraform init'


# USE THIS, not "terraform"
tf() {
  set -euo pipefail

  local profile="${AWS_PROFILE:-patrick.mccartney.root}"
  local region="${AWS_REGION:-us-west-2}"

  # Check host session WITHOUT letting old AWS_* env vars interfere
  if ! env -u AWS_ACCESS_KEY_ID -u AWS_SECRET_ACCESS_KEY -u AWS_SESSION_TOKEN -u AWS_SECURITY_TOKEN \
      aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1; then
    echo "AWS session expired/missing for '$profile' — opening login..." >&2
    AWS_REGION="$region" aws login --profile "$profile"
  fi

  # Get fresh temp creds from the profile for this one command (does NOT re-auth)
  local creds
  creds="$(
    env -u AWS_ACCESS_KEY_ID -u AWS_SECRET_ACCESS_KEY -u AWS_SESSION_TOKEN -u AWS_SECURITY_TOKEN \
      aws configure export-credentials --profile "$profile" --format env
  )"

  # Run terraform in docker with ONLY these creds (not your shell env)
  docker run --rm -it \
    -v "$(pwd):/workspace" \
    -w /workspace \
    -e AWS_REGION="$region" \
    -e AWS_DEFAULT_REGION="$region" \
    -e AWS_EC2_METADATA_DISABLED=true \
    $(printf "%s\n" "$creds" | sed -n 's/^export /-e /p') \
    hashicorp/terraform:latest "$@"
}

tf2() {
  set -euo pipefail

  local profile="${AWS_PROFILE:-patrick.mccartney.root}"
  local region="${AWS_REGION:-us-west-2}"

  # 1) Validate host session from shared AWS cache (ignore any AWS_* env in this pane)
  if ! env -u AWS_ACCESS_KEY_ID -u AWS_SECRET_ACCESS_KEY -u AWS_SESSION_TOKEN -u AWS_SECURITY_TOKEN \
      aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1; then
    echo "AWS session expired/missing for '$profile' — run login..." >&2
    AWS_REGION="$region" aws login --profile "$profile"
  fi

  # 2) Export temp creds from the shared cache (still ignoring pane env)
  local ak sk st
  ak="$(
    env -u AWS_ACCESS_KEY_ID -u AWS_SECRET_ACCESS_KEY -u AWS_SESSION_TOKEN -u AWS_SECURITY_TOKEN \
      aws configure export-credentials --profile "$profile" --format env |
      awk -F= '/^export AWS_ACCESS_KEY_ID=/{print $2}' | tr -d '"'
  )"
  sk="$(
    env -u AWS_ACCESS_KEY_ID -u AWS_SECRET_ACCESS_KEY -u AWS_SESSION_TOKEN -u AWS_SECURITY_TOKEN \
      aws configure export-credentials --profile "$profile" --format env |
      awk -F= '/^export AWS_SECRET_ACCESS_KEY=/{print $2}' | tr -d '"'
  )"
  st="$(
    env -u AWS_ACCESS_KEY_ID -u AWS_SECRET_ACCESS_KEY -u AWS_SESSION_TOKEN -u AWS_SECURITY_TOKEN \
      aws configure export-credentials --profile "$profile" --format env |
      awk -F= '/^export AWS_SESSION_TOKEN=/{print $2}' | tr -d '"'
  )"

  [ -n "$ak" ] && [ -n "$sk" ] && [ -n "$st" ] || { echo "Failed to export credentials for $profile" >&2; return 1; }

  # 3) Inject creds directly into Docker (no reliance on profile inside container)
  docker run --rm -it \
    -v "$(pwd):/workspace" \
    -w /workspace \
    -e AWS_ACCESS_KEY_ID="$ak" \
    -e AWS_SECRET_ACCESS_KEY="$sk" \
    -e AWS_SESSION_TOKEN="$st" \
    -e AWS_REGION="$region" \
    -e AWS_DEFAULT_REGION="$region" \
    -e AWS_EC2_METADATA_DISABLED=true \
    hashicorp/terraform:latest "$@"
}
