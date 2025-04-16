vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- vim.opt.foldmethod = "indent"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
<<<<<<< HEAD
--vim.cmd [[colorscheme material-deep-ocean]]
=======
-- vim.cmd [[colorscheme material-deep-ocean]]
>>>>>>> 3d59a11361df25506b064885f9e24dbb7a4a11ae

vim.opt.scrolloff = 4
vim.opt.signcolumn = "no"
vim.opt.isfname:append("@-@")

vim.opt.fillchars = {eob = " "}

vim.opt.updatetime = 50

vim.opt.conceallevel = 1

--vim.opt.colorcolumn = "80"

-- vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/lua_snippets"

