vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Make copying also copy into system clipboard.
-- Helps get up and running when new to neovim, but is not an ideal solution.
-- Ideally, we may want a key that can copy the yank buffer into the clipboard,
-- instead of putting all yanks into the clipboard.
-- "unnamed" => Windows,MacOS
-- "unnamedplus" => "Linux"
--vim.opt.clipboard = "unnamed,unnamedplus"

