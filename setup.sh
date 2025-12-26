#!/bin/bash

# Set fish as default shell
echo "Setting fish as default shell..."
if ! grep -q "/opt/homebrew/bin/fish" /etc/shells; then
    echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi
chsh -s /opt/homebrew/bin/fish

# Backup existing configs
echo "Backing up existing configs..."
mkdir -p ~/.config-backup
[ -d ~/.config/fish ] && mv ~/.config/fish ~/.config-backup/
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config-backup/
[ -d ~/.config/karabiner ] && mv ~/.config/karabiner ~/.config-backup/


# Stow all configs
echo "Stowing configs..."
cd ~/dotfiles
stow fish
stow nvim
stow karabiner
stow git

# Symlink VS Code and Cursor (stow doesn't handle spaces well)
ln -sf ~/dotfiles/vscode/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dotfiles/vscode/Library/Application\ Support/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf ~/dotfiles/cursor/Library/Application\ Support/Cursor/User/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
ln -sf ~/dotfiles/cursor/Library/Application\ Support/Cursor/User/keybindings.json ~/Library/Application\ Support/Cursor/User/keybindings.json

echo "Done! Restart your terminal."