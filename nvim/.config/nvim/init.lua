-- ============================================================================
-- GENERAL SETTINGS (Applied everywhere)
-- ============================================================================

-- Set <Space> as the leader key. This is the standard for modern Vim configs.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Sync clipboard between OS and Neovim.
-- This allows you to 'y' (yank) code and Cmd+V it elsewhere, or Cmd+C and 'p' (paste) it here.
vim.opt.clipboard = "unnamedplus"

-- ============================================================================
-- SEARCH & NAVIGATION
-- ============================================================================

-- Ignore case when searching (e.g., /foo finds Foo).
vim.opt.ignorecase = true

-- ...unless you type a capital letter (e.g., /Foo only finds Foo).
vim.opt.smartcase = true

-- highlight matching search results
vim.opt.hlsearch = true

-- Allow the cursor to move one character past the end of the line.
-- Useful for appending text to the end of a line easily.
vim.opt.virtualedit = "block"

-- ============================================================================
-- INDENTATION (Frontend Standard)
-- ============================================================================

-- Convert tabs to spaces. Standard for JS/TS/HTML.
vim.opt.expandtab = false

-- Number of spaces that a <Tab> in the file counts for.
vim.opt.tabstop = 2

-- Number of spaces to use for each step of (auto)indent (>> and <<).
vim.opt.shiftwidth = 2

-- Rounds indent to multiple of 'shiftwidth'.
-- If you are at 3 spaces and hit >>, it snaps to 4, not 5.
vim.opt.shiftround = true

-- ============================================================================
-- TEXT BEHAVIOR
-- ============================================================================

-- Treat dash-separated-words as a single word?
-- Frontend devs often work with CSS classes (my-class-name).
-- By default, 'w' stops at the hyphen. Uncomment the line below to make 'w' jump the whole string.
-- vim.opt.iskeyword:append("-")


-- When doing Find & Replace, show a "Split" preview of what will change.
-- (Note: In VS Code, this might be less visible, but it's great default behavior).
vim.opt.inccommand = "split"

-- ============================================================================
-- CLIPBOARD FIXES
-- ============================================================================

-- "Paste over selection" normally deletes the selection into the register,
-- causing you to lose your clipboard. This fixes that.
-- Now, pressing 'p' in Visual mode will delete the selection to the
-- "Black Hole" register ("_d) and then Paste (P).
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- Optional: If you ACTUALLY want to cut the selected text while pasting,
-- use Shift+P (P) instead.
-- (This creates a nice separation: p = strict paste, P = swap text)


-- ============================================================================
-- VS CODE SPECIFIC LOADING
-- ============================================================================

if vim.g.vscode then
    -- If we are inside VS Code, load the specialized config we created.
    require("vscode_config")
else
    -- ========================================================================
    -- TERMINAL FALLBACKS
    -- These only run if you accidentally open 'nvim' in a terminal window.
    -- VS Code handles these features natively, so we don't enable them above.
    -- ========================================================================
    vim.opt.termguicolors = true  -- Better colors
end
