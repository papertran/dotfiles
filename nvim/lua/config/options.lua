-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- try this: vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

opt.ignorecase = true

-- scrolling
opt.number = false
opt.relativenumber = false
opt.scrolloff = 8

--
vim.g.mkdp_browser = "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"

vim.g.lazygit_config = false
