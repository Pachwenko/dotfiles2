setopt prompt_subst interactive_comments

# Source everything under ~/patricks_dotfiles/zsh/shell_files
for f in ~/patricks_dotfiles/zsh/shell_files/*.sh(N); do
  source "$f"
done

# Source everything under ~/imtapps-custom-configs
for f in ~/imtapps-custom-configs/*.sh(N); do
  source "$f"
done
