vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.expandtab = true -- pressing <Tab> inserts spaces instead of a tab character (\t)
opt.shiftwidth = 2 -- number of spaces used for each level of indentation (e.g., >> or <<)
opt.tabstop = 2 -- how many spaces a tab character (\t) *looks like* when displayed
opt.softtabstop = 2 -- how many spaces Neovim inserts/deletes when pressing <Tab>/<Backspace>
opt.smarttab = true -- when at the start of a line, <Tab> inserts 'shiftwidth' spaces; <Backspace> deletes them smartly
opt.smartindent = true -- adds basic auto-indenting logic for C-like languages (after `{`, `}`, etc.)
opt.autoindent = true -- copies indentation from the previous line when creating a new line

opt.number = true -- shows absolute line numbers on the left
opt.relativenumber = true -- shows relative line numbers for easier line-based motions

opt.undofile = true -- enables persistent undo so changes can be undone even after closing a file

opt.mouse = "a" -- enables mouse support in all modes (normal, visual, insert, etc.)

opt.showmode = false -- hides the mode display since the statusline or lualine already shows it

opt.breakindent = true -- preserves indentation when wrapping long lines

opt.ignorecase = true -- makes search case-insensitive unless uppercase letters are used
opt.smartcase = true -- overrides 'ignorecase' if the search pattern contains uppercase letters

opt.updatetime = 200 -- reduces delay before triggering events like CursorHold (faster diagnostics and updates)

opt.splitright = true -- opens vertical splits to the right of the current window
opt.splitbelow = true -- opens horizontal splits below the current window

opt.list = true -- shows invisible characters like tabs and trailing spaces
opt.listchars = { tab = "  ", trail = ".", nbsp = "␣" } -- defines symbols for tabs, trailing spaces, and non-breaking spaces

opt.clipboard = "unnamedplus" -- uses the system clipboard for all yank, delete, paste operations

opt.termguicolors = true -- enables true color support in the terminal

opt.scrolloff = 4 -- keeps 4 lines visible above and below the cursor while scrolling vertically
opt.sidescrolloff = 8 -- keeps 8 columns visible to the left and right of the cursor while scrolling horizontally

opt.wrap = true -- enables line wrapping so long lines break and continue on the next screen line

opt.spelllang = { "en", "pt_br" } -- spell languages

opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
