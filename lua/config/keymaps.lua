
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
--map("i", "jk", "<ESC>")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-b>", "<C-^>")

vim.keymap.set("n", "<leader>x", vim.cmd.bd)
vim.keymap.set("n", "<leader>Q", vim.cmd.qall)
vim.keymap.set("n", "<tab>", vim.cmd.bn)
vim.keymap.set("n", "<S-tab>", vim.cmd.bp)

vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set({"n", "v"}, "<leader>P", [["+P]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>Y", [["+Y]])

vim.keymap.set({"n", "i", "v"}, "<C-i>", [[:resize +10<CR>:vertical resize +10<CR>]], { silent = true })

-- allows moving selected section up or down in code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append line below to current, and keep cursor at start
vim.keymap.set("n", "J", "mzJ`z")


vim.keymap.set("n", "gg", "m'gg")
vim.keymap.set("n", "G", "m'G")

-- move up and down and keep cursor in center
vim.keymap.set({"n", "v"}, "n", "nztzv")
vim.keymap.set({"n", "v"}, "N", "Nztzv")

-- when pasting, it keeps original yank content
vim.keymap.set("x", "<leader>dp", [["_dP]])

-- deletes without yanking
vim.keymap.set({"n", "v"}, "<leader>dv", [["_d]])

-- search and replace globally the word the cursor is on
vim.keymap.set("n", "<leader>rwg", [[:%s/<C-r><C-w>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>rws", [[:'<,'>s/<C-r><C-w>//gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>rws", [[:s/]])

vim.keymap.set("n", "<leader>lsp", [[:lua vim.diagnostic.open_float(0, { scope = "line" })]])

-- VIM TMUX NAVIGATOR
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
-- Optional: Create a keybinding
--
vim.keymap.set('n', '<leader>cs', ':colorscheme ')

vim.keymap.set('n', '<leader>K', '<C-w>K')
vim.keymap.set('n', '<leader>H', '<C-w>H')

vim.keymap.set('n', '<Down>', '<C-d>zz')
vim.keymap.set('n', '<Up>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set("n", 'H', '^')
vim.keymap.set("n", 'L', '$')
vim.keymap.set("n", 'cH', 'c^')
vim.keymap.set("n", 'cL', 'c$')
vim.keymap.set("n", 'dH', 'd^')
vim.keymap.set("n", 'dL', 'd$')

vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "CMD enter command mode", silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "CMD enter command mode", silent = true })
