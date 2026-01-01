#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "======================================"
echo "Exporting system configs to dotfiles"
echo "======================================"
echo ""

# Fish
if [ -d "$HOME/.config/fish" ]; then
    echo "📦 Exporting Fish config..."
    mkdir -p "$DOTFILES_DIR/fish/.config/fish"
    rsync -a --exclude='fish_variables' "$HOME/.config/fish/" "$DOTFILES_DIR/fish/.config/fish/"
    echo "✅ Fish config exported"
else
    echo "⚠️  No Fish config found"
fi
echo ""

# Neovim
if [ -d "$HOME/.config/nvim" ]; then
    echo "📦 Exporting Neovim config..."
    mkdir -p "$DOTFILES_DIR/nvim/.config/nvim"
    rsync -a --exclude='plugin' --exclude='.netrwhist' --exclude='undo' --exclude='swap' --exclude='backup' \
        "$HOME/.config/nvim/" "$DOTFILES_DIR/nvim/.config/nvim/"
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
        rsync -a --exclude='config.local' --exclude='credentials' \
            "$HOME/.config/git/" "$DOTFILES_DIR/git/.config/git/"
    fi

    if [ -f "$HOME/.gitconfig" ]; then
        cp "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig" 2>/dev/null || true
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
    rsync -a "$HOME/.config/ghostty/" "$DOTFILES_DIR/ghostty/.config/ghostty/"
    echo "✅ Ghostty config exported"
else
    echo "⚠️  No Ghostty config found"
fi
echo ""

# Karabiner
if [ -d "$HOME/.config/karabiner" ]; then
    echo "📦 Exporting Karabiner config..."
    mkdir -p "$DOTFILES_DIR/karabiner/.config/karabiner"
    if [ -f "$HOME/.config/karabiner/karabiner.json" ]; then
        cp "$HOME/.config/karabiner/karabiner.json" "$DOTFILES_DIR/karabiner/.config/karabiner/" 2>/dev/null || true
        echo "✅ Karabiner config exported"
    else
        echo "⚠️  No karabiner.json found"
    fi
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

    [ -f "$VSCODE_USER_DIR/settings.json" ] && \
        cp "$VSCODE_USER_DIR/settings.json" "$VSCODE_DOTFILES_DIR/" 2>/dev/null || true
    [ -f "$VSCODE_USER_DIR/keybindings.json" ] && \
        cp "$VSCODE_USER_DIR/keybindings.json" "$VSCODE_DOTFILES_DIR/" 2>/dev/null || true
    [ -f "$VSCODE_USER_DIR/tasks.json" ] && \
        cp "$VSCODE_USER_DIR/tasks.json" "$VSCODE_DOTFILES_DIR/" 2>/dev/null || true

    if [ -d "$VSCODE_USER_DIR/snippets" ]; then
        rsync -a "$VSCODE_USER_DIR/snippets/" "$VSCODE_DOTFILES_DIR/snippets/"
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

    [ -f "$CURSOR_USER_DIR/settings.json" ] && \
        cp "$CURSOR_USER_DIR/settings.json" "$CURSOR_DOTFILES_DIR/" 2>/dev/null || true
    [ -f "$CURSOR_USER_DIR/keybindings.json" ] && \
        cp "$CURSOR_USER_DIR/keybindings.json" "$CURSOR_DOTFILES_DIR/" 2>/dev/null || true
    [ -f "$CURSOR_USER_DIR/tasks.json" ] && \
        cp "$CURSOR_USER_DIR/tasks.json" "$CURSOR_DOTFILES_DIR/" 2>/dev/null || true

    if [ -d "$CURSOR_USER_DIR/snippets" ]; then
        rsync -a "$CURSOR_USER_DIR/snippets/" "$CURSOR_DOTFILES_DIR/snippets/"
    fi

    echo "✅ Cursor config exported"
else
    echo "⚠️  No Cursor config found"
fi
echo ""


# VS Code Extensions
if command -v code &> /dev/null; then
    echo "📦 Exporting VS Code extensions..."
    VSCODE_DOTFILES_DIR="$DOTFILES_DIR/vscode/Library/Application Support/Code/User"
    mkdir -p "$VSCODE_DOTFILES_DIR"

    code --list-extensions > "$VSCODE_DOTFILES_DIR/extensions.txt"
    echo "✅ VS Code extensions exported ($(wc -l < "$VSCODE_DOTFILES_DIR/extensions.txt" | tr -d ' ') extensions)"
else
    echo "⚠️  VS Code CLI not found"
fi
echo ""

# Cursor Extensions
if command -v cursor &> /dev/null; then
    echo "📦 Exporting Cursor extensions..."
    CURSOR_DOTFILES_DIR="$DOTFILES_DIR/cursor/Library/Application Support/Cursor/User"
    mkdir -p "$CURSOR_DOTFILES_DIR"

    cursor --list-extensions > "$CURSOR_DOTFILES_DIR/extensions.txt"
    echo "✅ Cursor extensions exported ($(wc -l < "$CURSOR_DOTFILES_DIR/extensions.txt" | tr -d ' ') extensions)"
else
    echo "⚠️  Cursor CLI not found"
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
