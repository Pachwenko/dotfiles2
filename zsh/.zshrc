setopt prompt_subst interactive_comments

for f in ~/patricks_dotfiles/zsh/shell_files/*.sh(N); do
    source "$f"
done

for f in ~/imtapps-custom-configs/*.sh(N); do
    source "$f"
done

for f in ~/patricks_configs/*.sh(N); do
    source "$f"
done

export PATH="/Users/patrick.mccartney/.antigravity/antigravity/bin:$PATH"
