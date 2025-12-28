#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "======================================"
echo "Exporting system configs to dotfiles"
echo "======================================"
echo ""

# Fish
if [ -d "$HOME/.config/fish" ]; then
    echo "📦 Exporting Fish config..."
    mkdir -p "$DOTFILES_DIR/fish/.config/fish"
    cp -r "$HOME/.config/fish/"* "$DOTFILES_DIR/fish/.config/fish/"
    echo "✅ Fish config exported"
else
    echo "⚠️  No Fish config found"
fi
echo ""

# Neovim
if [ -d "$HOME/.config/nvim" ]; then
    echo "📦 Exporting Neovim config..."
    mkdir -p "$DOTFILES_DIR/nvim/.config/nvim"
    cp -r "$HOME/.config/nvim/"* "$DOTFILES_DIR/nvim/.config/nvim/"
    echo "✅ Neovim config exported"
else
    echo "⚠️  No Neovim config found"
fi
echo ""

# Git
if [ -d "$HOME/.config/git" ] || [ -f "$HOME/.gitconfig" ]; then
    echo "📦 Exporting Git config..."
    mkdir -p "$DOTFILES_DIR/git/.config/git"

    if [ -d "$HOME/.config/git" ]; then
        cp -r "$HOME/.config/git/"* "$DOTFILES_DIR/git/.config/git/"
    fi

    if [ -f "$HOME/.gitconfig" ]; then
        cp "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig"
    fi

    echo "✅ Git config exported"
else
    echo "⚠️  No Git config found"
fi
echo ""

# Ghostty
if [ -d "$HOME/.config/ghostty" ]; then
    echo "📦 Exporting Ghostty config..."
    mkdir -p "$DOTFILES_DIR/ghostty/.config/ghostty"
    cp -r "$HOME/.config/ghostty/"* "$DOTFILES_DIR/ghostty/.config/ghostty/"
    echo "✅ Ghostty config exported"
else
    echo "⚠️  No Ghostty config found"
fi
echo ""

# Karabiner
if [ -d "$HOME/.config/karabiner" ]; then
    echo "📦 Exporting Karabiner config..."
    mkdir -p "$DOTFILES_DIR/karabiner/.config/karabiner"
    cp "$HOME/.config/karabiner/karabiner.json" "$DOTFILES_DIR/karabiner/.config/karabiner/" 2>/dev/null || true
    echo "✅ Karabiner config exported"
else
    echo "⚠️  No Karabiner config found"
fi
echo ""

# VS Code
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "$VSCODE_USER_DIR" ]; then
    echo "📦 Exporting VS Code config..."
    VSCODE_DOTFILES_DIR="$DOTFILES_DIR/vscode/Library/Application Support/Code/User"
    mkdir -p "$VSCODE_DOTFILES_DIR"

    [ -f "$VSCODE_USER_DIR/settings.json" ] && cp "$VSCODE_USER_DIR/settings.json" "$VSCODE_DOTFILES_DIR/"
    [ -f "$VSCODE_USER_DIR/keybindings.json" ] && cp "$VSCODE_USER_DIR/keybindings.json" "$VSCODE_DOTFILES_DIR/"
    [ -f "$VSCODE_USER_DIR/tasks.json" ] && cp "$VSCODE_USER_DIR/tasks.json" "$VSCODE_DOTFILES_DIR/"

    if [ -d "$VSCODE_USER_DIR/snippets" ]; then
        cp -r "$VSCODE_USER_DIR/snippets" "$VSCODE_DOTFILES_DIR/"
    fi

    echo "✅ VS Code config exported"
else
    echo "⚠️  No VS Code config found"
fi
echo ""

# Cursor
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
if [ -d "$CURSOR_USER_DIR" ]; then
    echo "📦 Exporting Cursor config..."
    CURSOR_DOTFILES_DIR="$DOTFILES_DIR/cursor/Library/Application Support/Cursor/User"
    mkdir -p "$CURSOR_DOTFILES_DIR"

    [ -f "$CURSOR_USER_DIR/settings.json" ] && cp "$CURSOR_USER_DIR/settings.json" "$CURSOR_DOTFILES_DIR/"
    [ -f "$CURSOR_USER_DIR/keybindings.json" ] && cp "$CURSOR_USER_DIR/keybindings.json" "$CURSOR_DOTFILES_DIR/"
    [ -f "$CURSOR_USER_DIR/tasks.json" ] && cp "$CURSOR_USER_DIR/tasks.json" "$CURSOR_DOTFILES_DIR/"

    if [ -d "$CURSOR_USER_DIR/snippets" ]; then
        cp -r "$CURSOR_USER_DIR/snippets" "$CURSOR_DOTFILES_DIR/"
    fi

    echo "✅ Cursor config exported"
else
    echo "⚠️  No Cursor config found"
fi
echo ""

# Raycast
RAYCAST_SOURCE="$HOME/Library/Application Support/Raycast"
if [ -d "$RAYCAST_SOURCE" ]; then
    echo "📦 Exporting Raycast config..."
    RAYCAST_DEST="$DOTFILES_DIR/raycast/Library/Application Support/Raycast"
    mkdir -p "$RAYCAST_DEST"

    [ -d "$RAYCAST_SOURCE/Scripts" ] && cp -r "$RAYCAST_SOURCE/Scripts" "$RAYCAST_DEST/"
    [ -d "$RAYCAST_SOURCE/Snippets" ] && cp -r "$RAYCAST_SOURCE/Snippets" "$RAYCAST_DEST/"
    [ -f "$RAYCAST_SOURCE/quicklinks.json" ] && cp "$RAYCAST_SOURCE/quicklinks.json" "$RAYCAST_DEST/"
    [ -f "$RAYCAST_SOURCE/hotkeys.json" ] && cp "$RAYCAST_SOURCE/hotkeys.json" "$RAYCAST_DEST/"
    [ -f "$RAYCAST_SOURCE/aliases.json" ] && cp "$RAYCAST_SOURCE/aliases.json" "$RAYCAST_DEST/"

    if [ -d "$RAYCAST_SOURCE/Extensions" ]; then
        mkdir -p "$RAYCAST_DEST/Extensions"
        find "$RAYCAST_SOURCE/Extensions" -name "*.json" -not -path "*/node_modules/*" \
            -exec rsync -R {} "$RAYCAST_DEST/" \; 2>/dev/null || true
    fi

    echo "✅ Raycast config exported"
else
    echo "⚠️  No Raycast config found"
fi
echo ""

echo "======================================"
echo "✅ Export complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "1. Review changes: cd $DOTFILES_DIR && git status"
echo "2. Commit changes: git add . && git commit -m 'Update configs'"
echo "3. Push to remote: git push"
