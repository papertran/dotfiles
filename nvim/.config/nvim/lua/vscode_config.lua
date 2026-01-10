-- ~/.config/nvim/lua/vscode_config.lua

-- 1. BOOTSTRAP PLUGIN MANAGER (LAZY.NVIM)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- 2. PLUGINS
require("lazy").setup({
    -- Flash: Jump navigation (s key)
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        opts = { modes = { char = { enabled = false } } }, -- Keep 'f' normal
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        },
    },
    -- Mini.ai: Better text objects (ciq, cib, etc)
    { "nvim-mini/mini.ai", enabled = true, opts = {} },
    -- Mini.surround: saiw", sd", etc
    { "nvim-mini/mini.surround", enabled = true, opts = {} },
})

-- 3. VS CODE KEYMAPPINGS
local vscode = require("vscode")

-- Helper to make mappings clean
local function map(mode, key, cmd)
    vim.keymap.set(mode, key, function() vscode.call(cmd) end, { noremap = true, silent = true })
end

-- --- Files & Project ---
map("n", "<Space>ff", "workbench.action.quickOpen")
map("n", "<Space>fg", "workbench.action.findInFiles")
map("n", "<Space>e",  "workbench.action.toggleSidebarVisibility")
map("n", "<Space>ps", "workbench.action.openRecent")
map("n", "<Space>=",  "editor.action.formatDocument")

-- --- Window Management ---
map("n", "<Space>wv", "workbench.action.splitEditor")
map("n", "<Space>ws", "workbench.action.splitEditorDown")
map("n", "<Space>wq", "workbench.action.closeActiveEditor")

-- --- Tab Navigation ---
map("n", "H", "workbench.action.previousEditor")
map("n", "L", "workbench.action.nextEditor")

-- Force Ctrl+h/j/k/l to navigate VS Code windows
map("n", "<C-h>", "workbench.action.navigateLeft")
map("n", "<C-j>", "workbench.action.navigateDown")
map("n", "<C-k>", "workbench.action.navigateUp")
map("n", "<C-l>", "workbench.action.navigateRight")

-- --- LazyGit ---
-- Run Lazygit and Maximize the Terminal Panel
vim.keymap.set("n", "<Space>gg", function()
    -- 1. Launch the Task
    vscode.call("workbench.action.tasks.runTask", { args = { "Lazygit" } })
end, { noremap = true, silent = true })

-- --- AI / Cursor ---
-- map("n", "<Space>ak", "aichat.trigger")
-- map("n", "<Space>ac", "aichat.newchat")
-- map("v", "<Space>ae", "aichat.insertselectionintochat")

-- --- Refactoring (The 'g' keys) ---
map("n", "gr", "editor.action.rename")
map("n", "gd", "editor.action.revealDefinition")
map("n", "gD", "editor.action.peekDefinition")
map("n", "gb", "editor.action.addSelectionToNextFindMatch")
