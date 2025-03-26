vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
--map("i", "jk", "<ESC>")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<tab>", vim.cmd.bnext)
-- vim.keymap.set("n", "<S-tab>", vim.cmd.bprev)
vim.keymap.set("n", "<tab>", "gt")
vim.keymap.set("n", "<S-tab>", "gT")

vim.keymap.set("n", "<leader>x", vim.cmd.bd)
-- vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>Q", vim.cmd.qall)
vim.keymap.set("n", "<leader>z", vim.cmd.zt)

vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<C-p>", [[:resize +10<CR>:vertical resize +10<CR>]], { silent = true })

-- allows moving selected section up or down in code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append line below to current, and keep cursor at start
vim.keymap.set("n", "J", "mzJ`z")

-- move up and down and keep cursor in center
vim.keymap.set("n", "n", "nztzv")
vim.keymap.set("n", "N", "Nztzv")

-- when pasting, it keeps original yank content
vim.keymap.set("x", "<leader>dp", [["_dP]])

-- deletes without yanking
vim.keymap.set("n", "<leader>v", [["_d]])

-- search and replace globally the word the cursor is on
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>lsp", [[:lua vim.diagnostic.open_float(0, { scope = "line" })]])

vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
-- Optional: Create a keybinding
--
vim.keymap.set('n', '<leader>tc', ':colorscheme ')

vim.keymap.set('n', '<leader>K', '<C-w>K')
vim.keymap.set('n', '<leader>H', '<C-w>H')

-- vim.keymap.set('n', '<leader>mi', [[:let @o = join(readfile('init_macro.vim'), '\n')<CR>@o]])
-- vim.keymap.set('n', '<leader>ml', [[:let @a = join(readfile(''), '\n')]])
-- vim.keymap.set('n', '<leader>ms', [[:let @w = getreg('w')<CR>:call writefile(split(getreg('w'), '\n') '/path')]])

vim.keymap.set('n', '<leader>mi', [[:luafile init_macro.lua<CR><leader>mw]])
vim.keymap.set('n', '<leader>ml', [[:let @a = join(readfile(''), '\n')]])
vim.keymap.set('n', '<leader>ms', [[:let @w = getreg('w')<CR>:call writefile(split(getreg('w'), '\n') '/path')]])

vim.keymap.set('n', '<Down>', '<C-d>zz')
vim.keymap.set('n', '<Up>', '<C-u>zz')
