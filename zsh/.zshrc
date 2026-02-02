setopt prompt_subst interactive_comments

# Source everything under ~/patricks_dotfiles/zsh/shell_files
for f in ~/patricks_dotfiles/zsh/shell_files/*.sh(N); do
  source "$f"
done

# Source everything under ~/imtapps-custom-configs
for f in ~/imtapps-custom-configs/*.sh(N); do
  source "$f"
done

# Source everything under ~/patricks_configs
for f in ~/patricks_configs/*.sh(N); do
  source "$f"
done

for f in ~/old-matts-dotfiles/dotfiles/custom-configs/my-custom-configs/*.sh(N); do
  source "$f"
done

# Added by Antigravity
export PATH="/Users/patrick.mccartney/.antigravity/antigravity/bin:$PATH"
