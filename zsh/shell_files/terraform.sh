if [[ -f ~/.terraform.d/plugin-cache ]]; then
    export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
fi

alias tfa='terraform apply'
alias tfp='terraform plan'
alias tfi='terraform init'

tf() (
    set -euo pipefail

    local profile="${AWS_PROFILE:-patrick.mccartney.root}"
    local region="${AWS_REGION:-us-west-2}"
    local env_unset="env -u AWS_ACCESS_KEY_ID -u AWS_SECRET_ACCESS_KEY -u AWS_SESSION_TOKEN -u AWS_SECURITY_TOKEN"

    if ! $=env_unset aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1; then
        echo "AWS session expired for '$profile'" >&2
        AWS_REGION="$region" aws login --profile "$profile"
    fi

    local creds
    creds="$($=env_unset aws configure export-credentials --profile "$profile" --format env)"

    local ak sk st
    ak="$(echo "$creds" | awk -F= '/^export AWS_ACCESS_KEY_ID=/{print $2}' | tr -d '"')"
    sk="$(echo "$creds" | awk -F= '/^export AWS_SECRET_ACCESS_KEY=/{print $2}' | tr -d '"')"
    st="$(echo "$creds" | awk -F= '/^export AWS_SESSION_TOKEN=/{print $2}' | tr -d '"')"

    [[ -n "$ak" && -n "$sk" && -n "$st" ]] || { echo "Failed to export credentials for $profile" >&2; return 1; }

    docker run --rm -it \
        -v "$(pwd):/workspace" \
        -w /workspace \
        -v "$HOME/.ssh:/root/.ssh:ro" \
        -e AWS_ACCESS_KEY_ID="$ak" \
        -e AWS_SECRET_ACCESS_KEY="$sk" \
        -e AWS_SESSION_TOKEN="$st" \
        -e AWS_REGION="$region" \
        -e AWS_DEFAULT_REGION="$region" \
        -e AWS_EC2_METADATA_DISABLED=true \
        hashicorp/terraform:latest "$@"
)
