-- Show the current line number in a gutter.
vim.opt.nu = true
-- Show relative line numbers for every line other than the current line.
vim.opt.relativenumber = true

-- Set indentation to 4 spaces.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Visualize irregular spaces such as tabs or spaces after end of line.
vim.opt.list = true
vim.opt.listchars = "tab:»·,trail:·,nbsp:·"

-- Keep word wrapping off by default.
-- To toggle on demand, run the command `:set wrap!`.
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

-- Keep undo steps long term across re-opening neovim.
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Adds column colorbars as indicators that the line is getting too long.
vim.opt.colorcolumn = "80,120"

-- Make copying also copy into system clipboard.
-- Helps get up and running when new to neovim, but is not an ideal solution.
-- Ideally, we may want a key that can copy the yank buffer into the clipboard,
-- instead of putting all yanks into the clipboard.
-- "unnamed" => Windows,MacOS
-- "unnamedplus" => "Linux"
--vim.opt.clipboard = "unnamed,unnamedplus"
