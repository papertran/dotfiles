# Modern replacements for default tools
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias la="eza -a --icons"
alias lt="eza --tree --icons"
alias cat="bat"
alias find="fd"
alias grep="rg"
alias vi="nvim"


# Better defaults
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias mkdir="mkdir -pv"

# Git shortcuts
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias lg="lazygit"


# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# FZF configuration
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'

# Enable fzf key bindings if available
if type -q fzf_key_bindings
    fzf_key_bindings
end

# Node version manager (fnm)
if type -q fnm
    fnm env --use-on-cd | source
end

# Bat theme
set -x BAT_THEME "TwoDark"

# Eza colors
set -x EZA_COLORS "da=1;34:gm=1;34"

# Git delta as pager
set -x GIT_PAGER "delta"

# Editor
set -x EDITOR "nvim"
set -x VISUAL "nvim"

# Homebrew
set -x HOMEBREW_NO_ANALYTICS 1

# PATH modifications
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.local/bin

# Greeting
set fish_greeting ""
