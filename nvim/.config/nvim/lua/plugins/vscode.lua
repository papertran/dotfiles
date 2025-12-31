-- lua/plugins/vscode.lua

if not vim.g.vscode then
  return {}
end

-- Define the plugins we want to DISABLE
-- We return this table immediately so Lazy.nvim knows what to ignore
local plugins = {
  -- Disable UI/Search plugins that fight VS Code
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "ibhagwan/fzf-lua", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "folke/trouble.nvim", enabled = false },
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "nvim-treesitter/nvim-treesitter", enabled = false },
  { "mason-org/mason.nvim", enabled = false },
  { "neovim/nvim-lspconfig", enabled = false },
  { "hrsh7th/nvim-cmp", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- Enable text power-ups
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = { modes = { char = { enabled = false } } },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
  { "nvim-mini/mini.ai", enabled = true },
  { "nvim-mini/mini.surround", enabled = true },
}

-- Force Keymaps AFTER loading is complete
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    local vscode = require("vscode")

    -- Helper to force mapping
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true })
    end

    -- 1. Unmap conflicting keys explicitly
    pcall(vim.keymap.del, "n", "<space>ff")
    pcall(vim.keymap.del, "n", "<space>fg")
    pcall(vim.keymap.del, "n", "<space>e")
    pcall(vim.keymap.del, "n", "<space>qq")
    pcall(vim.keymap.del, "n", "<space>gg")

    -- 2. Set Leader
    vim.g.mapleader = " "

    -- 3. VS Code Actions
    -- Files
    map("n", "<space>ff", function() vscode.call("workbench.action.quickOpen") end)
    map("n", "<space>fg", function() vscode.call("workbench.action.findInFiles") end)
    map("n", "<space>e",  function() vscode.call("workbench.action.toggleSidebarVisibility") end)
    map("n", "<space>ps", function() vscode.call("workbench.action.openRecent") end)
    map("n", "<space>=",  function() vscode.call("editor.action.formatDocument") end)

    -- Window Management
    map("n", "<space>wv", function() vscode.call("workbench.action.splitEditor") end)
    map("n", "<space>ws", function() vscode.call("workbench.action.splitEditorDown") end)
    map("n", "<space>wq", function() vscode.call("workbench.action.closeActiveEditor") end)

    -- Navigation Fixes (Force Ctrl+h/j/k/l to work)
    map("n", "<C-j>", function() vscode.call("workbench.action.navigateDown") end)
    map("n", "<C-k>", function() vscode.call("workbench.action.navigateUp") end)
    map("n", "<C-h>", function() vscode.call("workbench.action.navigateLeft") end)
    map("n", "<C-l>", function() vscode.call("workbench.action.navigateRight") end)

    -- Lazygit
    map("n", "<space>gg", function()
        vscode.call("workbench.action.tasks.runTask", { args = { "Lazygit" } })
    end)

    -- AI / Cursor
    map("n", "<space>ak", function() vscode.call("aichat.trigger") end)
    map("n", "<space>ac", function() vscode.call("aichat.newchat") end)
    map("v", "<space>ae", function() vscode.call("aichat.insertselectionintochat") end)

    -- Editor Actions (G-Keys)
    map("n", "gr", function() vscode.call("editor.action.rename") end)
    map("n", "gd", function() vscode.call("editor.action.revealDefinition") end)
    map("n", "gD", function() vscode.call("editor.action.peekDefinition") end)
    map("n", "gb", function() vscode.call("editor.action.addSelectionToNextFindMatch") end)
  end,
})

return plugins
