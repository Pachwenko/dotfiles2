setopt prompt_subst interactive_comments

# Source everything under ~/patricks_dotfiles/shell-files
for f in ~/patricks_dotfiles/shell_files/*.sh(N); do
  source "$f"
done

# Source everything under ~/custom-configs
for f in ~/shell_files/*.sh(N); do
  source "$f"
done
