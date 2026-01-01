#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "======================================"
echo "Importing dotfiles to system"
echo "======================================"
echo ""

# Create backup directory
BACKUP_DIR="$HOME/.config-backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "📁 Backups will be saved to: $BACKUP_DIR"
echo ""

# Set fish as default shell
echo "🐚 Setting Fish as default shell..."
if ! grep -q "/opt/homebrew/bin/fish" /etc/shells 2>/dev/null; then
    echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi
if [ "$SHELL" != "/opt/homebrew/bin/fish" ]; then
    chsh -s /opt/homebrew/bin/fish
    echo "✅ Fish set as default shell (restart terminal to take effect)"
else
    echo "✅ Fish already default shell"
fi
echo ""

# Backup and remove existing configs
echo "💾 Backing up existing configs..."

[ -d "$HOME/.config/fish" ] && mv "$HOME/.config/fish" "$BACKUP_DIR/"
[ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim" "$BACKUP_DIR/"
[ -d "$HOME/.config/git" ] && mv "$HOME/.config/git" "$BACKUP_DIR/"
[ -d "$HOME/.config/ghostty" ] && mv "$HOME/.config/ghostty" "$BACKUP_DIR/"
[ -d "$HOME/.config/karabiner" ] && mv "$HOME/.config/karabiner" "$BACKUP_DIR/"
[ -f "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$BACKUP_DIR/"

echo "✅ Existing configs backed up"
echo ""

# Stow configs (for directories without spaces)
echo "🔗 Stowing configs with GNU Stow..."
cd "$DOTFILES_DIR"

if [ -d "$DOTFILES_DIR/fish" ]; then
    stow fish
    echo "✅ Fish config stowed"
fi

if [ -d "$DOTFILES_DIR/nvim" ]; then
    stow nvim
    echo "✅ Neovim config stowed"
fi

if [ -d "$DOTFILES_DIR/git" ]; then
    stow git
    echo "✅ Git config stowed"
fi

if [ -d "$DOTFILES_DIR/ghostty" ]; then
    stow ghostty
    echo "✅ Ghostty config stowed"
fi

if [ -d "$DOTFILES_DIR/karabiner" ]; then
    stow karabiner
    echo "✅ Karabiner config stowed"
fi
echo ""

# Symlink VS Code (manual because of spaces in path)
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
VSCODE_DOTFILES_DIR="$DOTFILES_DIR/vscode/Library/Application Support/Code/User"

if [ -d "$VSCODE_DOTFILES_DIR" ]; then
    echo "🔗 Symlinking VS Code config..."
    mkdir -p "$VSCODE_USER_DIR"

    [ -f "$VSCODE_DOTFILES_DIR/settings.json" ] && \
        ln -sf "$VSCODE_DOTFILES_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"

    [ -f "$VSCODE_DOTFILES_DIR/keybindings.json" ] && \
        ln -sf "$VSCODE_DOTFILES_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"

    [ -f "$VSCODE_DOTFILES_DIR/tasks.json" ] && \
        ln -sf "$VSCODE_DOTFILES_DIR/tasks.json" "$VSCODE_USER_DIR/tasks.json"

    if [ -d "$VSCODE_DOTFILES_DIR/snippets" ]; then
        ln -sf "$VSCODE_DOTFILES_DIR/snippets" "$VSCODE_USER_DIR/snippets"
    fi

    echo "✅ VS Code config symlinked"
else
    echo "⚠️  No VS Code config in dotfiles"
fi
echo ""

# Symlink Cursor (manual because of spaces in path)
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
CURSOR_DOTFILES_DIR="$DOTFILES_DIR/cursor/Library/Application Support/Cursor/User"

if [ -d "$CURSOR_DOTFILES_DIR" ]; then
    echo "🔗 Symlinking Cursor config..."
    mkdir -p "$CURSOR_USER_DIR"

    [ -f "$CURSOR_DOTFILES_DIR/settings.json" ] && \
        ln -sf "$CURSOR_DOTFILES_DIR/settings.json" "$CURSOR_USER_DIR/settings.json"

    [ -f "$CURSOR_DOTFILES_DIR/keybindings.json" ] && \
        ln -sf "$CURSOR_DOTFILES_DIR/keybindings.json" "$CURSOR_USER_DIR/keybindings.json"

    [ -f "$CURSOR_DOTFILES_DIR/tasks.json" ] && \
        ln -sf "$CURSOR_DOTFILES_DIR/tasks.json" "$CURSOR_USER_DIR/tasks.json"

    if [ -d "$CURSOR_DOTFILES_DIR/snippets" ]; then
        ln -sf "$CURSOR_DOTFILES_DIR/snippets" "$CURSOR_USER_DIR/snippets"
    fi

    echo "✅ Cursor config symlinked"
else
    echo "⚠️  No Cursor config in dotfiles"
fi
echo ""


# Install VS Code Extensions
VSCODE_DOTFILES_DIR="$DOTFILES_DIR/vscode/Library/Application Support/Code/User"
if [ -f "$VSCODE_DOTFILES_DIR/extensions.txt" ] && command -v code &> /dev/null; then
    echo "📦 Installing VS Code extensions..."

    extension_count=$(wc -l < "$VSCODE_DOTFILES_DIR/extensions.txt" | tr -d ' ')
    echo "Found $extension_count extensions to install"

    while IFS= read -r extension; do
        if [ -n "$extension" ]; then
            echo "  Installing: $extension"
            code --install-extension "$extension" --force 2>/dev/null || echo "  ⚠️  Failed to install $extension"
        fi
    done < "$VSCODE_DOTFILES_DIR/extensions.txt"

    echo "✅ VS Code extensions installed"
else
    if [ ! -f "$VSCODE_DOTFILES_DIR/extensions.txt" ]; then
        echo "⚠️  No VS Code extensions list found"
    elif ! command -v code &> /dev/null; then
        echo "⚠️  VS Code CLI not found"
    fi
fi
echo ""

# Install Cursor Extensions
CURSOR_DOTFILES_DIR="$DOTFILES_DIR/cursor/Library/Application Support/Cursor/User"
if [ -f "$CURSOR_DOTFILES_DIR/extensions.txt" ] && command -v cursor &> /dev/null; then
    echo "📦 Installing Cursor extensions..."

    extension_count=$(wc -l < "$CURSOR_DOTFILES_DIR/extensions.txt" | tr -d ' ')
    echo "Found $extension_count extensions to install"

    while IFS= read -r extension; do
        if [ -n "$extension" ]; then
            echo "  Installing: $extension"
            cursor --install-extension "$extension" --force 2>/dev/null || echo "  ⚠️  Failed to install $extension"
        fi
    done < "$CURSOR_DOTFILES_DIR/extensions.txt"

    echo "✅ Cursor extensions installed"
else
    if [ ! -f "$CURSOR_DOTFILES_DIR/extensions.txt" ]; then
        echo "⚠️  No Cursor extensions list found"
    elif ! command -v cursor &> /dev/null; then
        echo "⚠️  Cursor CLI not found"
    fi
fi
echo ""



echo "======================================"
echo "✅ Import complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "1. Restart your terminal (or run: exec fish)"
echo "2. Restart Raycast if it's running"
echo "3. Your old configs are backed up in: $BACKUP_DIR"
