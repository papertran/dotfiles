-- lua/plugins/vscode.lua

-- If we are NOT in VSCode, do nothing (load plugins as normal)
if not vim.g.vscode then return {} end

return {
  -- 1. DISABLE PLUGINS (VS Code handles these features natively)
  { "nvim-treesitter/nvim-treesitter", enabled = false }, -- VS Code does highlighting
  { "williamboman/mason.nvim", enabled = false },         -- VS Code manages tools
  { "neovim/nvim-lspconfig", enabled = false },           -- VS Code does IntelliSense
  { "hrsh7th/nvim-cmp", enabled = false },                -- VS Code does Autocomplete
  { "folke/tokyonight.nvim", enabled = false },           -- VS Code handles the theme
  { "folke/noice.nvim", enabled = false },                -- VS Code handles messages
  { "rcarriga/nvim-notify", enabled = false },            -- VS Code handles notifications
  { "nvim-lualine/lualine.nvim", enabled = false },       -- VS Code has a status bar
  { "akinsho/bufferline.nvim", enabled = false },         -- VS Code has tabs
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },     -- VS Code has the Explorer
  { "echasnovski/mini.pairs", enabled = false },          -- VS Code Auto-Closing is better integrated
  { "folke/persistence.nvim", enabled = false },          -- VS Code remembers sessions

  -- 2. ENABLE/CONFIGURE POWER PLUGINS
  -- These add specific Vim super-powers that work GREAT in VS Code

  -- Flash: Jump anywhere on screen with two keys (s)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {
      modes = {
        -- Disable "char" mode so standard 'f' and 't' keys work normally
        char = { enabled = false }, 
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },

  -- Mini.ai: Better text objects (e.g., ciq for "change inside quotes")
  { "echasnovski/mini.ai", enabled = true },

  -- Mini.surround: Add/Delete/Replace surroundings (e.g., saiw)
  { "echasnovski/mini.surround", enabled = true },
}