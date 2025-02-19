vim.g.mapleader = " "

-- easy copy & paste bindings
vim.keymap.set("v", "<leader>p", [["+p]])
vim.keymap.set("v", "<leader>P", [["+P]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("v", "<leader>Y", [["+Y]])

-- move lines of code up and down in visual mode an indent properly
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append current line to above and keep cursor where it started
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "n", "nztzv")
vim.keymap.set("n", "N", "Nztzv")

-- when pasting, it keeps original yank content
vim.keymap.set("x", "<leader>dp", [["_dP]])

-- deletes without yanking
vim.keymap.set("n", "<leader>v", [["_d]])

-- replace word cursor is hovering
vim.keymap.set("n", "<leader>rw", [[:%s/<C-r><C-w>//gI<Left><Left><Left>]])
