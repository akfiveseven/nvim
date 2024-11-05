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
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.cmd [[colorscheme rose-pine]]

vim.opt.scrolloff = 4
vim.opt.signcolumn = "no"
vim.opt.isfname:append("@-@")

vim.opt.fillchars = {eob = " "}

vim.opt.updatetime = 50
--vim.opt.colorcolumn = "80"

-- vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/lua_snippets"
