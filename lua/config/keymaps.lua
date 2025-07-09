vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
--map("i", "jk", "<ESC>")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here


vim.keymap.set("n", "<leader>x", vim.cmd.bd, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>Q", vim.cmd.qall, { desc = "Quit Neovim without saving" })
vim.keymap.set("n", "<tab>", "gt", { desc = "Goto next tab" })
-- vim.keymap.set("n", "<C-b>", "<C-^>", { desc = "Goto last buffer" })
vim.keymap.set("n", "<S-tab>", "gT", { desc = "Goto prev tab" })
-- vim.keymap.set("n", "<S-tab>", vim.cmd.bp, { desc = "Goto previous buffer" })

vim.keymap.set({"n", "v"}, "<leader>p", [["+p]], { desc = "Paste from system clipboard after cursor" })
vim.keymap.set({"n", "v"}, "<leader>P", [["+P]], { desc = "Paste from system clipboard before cursor" })
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })

vim.keymap.set({"n", "i", "v"}, "<C-p>", [[:resize +10<CR>:vertical resize +10<CR>]], { desc = "Increase window size", silent = true })

-- allows moving selected section up or down in code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move code block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move code block up" })

-- append line below to current, and keep cursor at start
vim.keymap.set("n", "J", "mzJ`z", { desc = "Append line below to current" })

-- move up and down and keep cursor in center
vim.keymap.set({"n", "v"}, "n", "nztzv")
vim.keymap.set({"n", "v"}, "N", "Nztzv")

-- when pasting, it keeps original yank content
vim.keymap.set("x", "<leader>dp", [["_dP]], { desc = "Paste & keep yank content" })

-- deletes without yanking
vim.keymap.set({"n", "v"}, "<leader>dv", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set({"n", "v"}, "<leader>jq", [[:%!jq .<CR>]], { desc = "Format json" })

-- search and replace globally the word the cursor is on
vim.keymap.set("n", "<leader>rwg", [[:%s/<C-r><C-w>//gI<Left><Left><Left>]], { desc = "Replace word under cursor globally" })
vim.keymap.set("n", "<leader>rwl", [[:s/<C-r><C-w>//gI<Left><Left><Left>]], { desc = "Replace word under cursor current line" })
vim.keymap.set("v", "<leader>rws", [[:s//gI<Left><Left><Left>]], { desc = "Replace word in selection" })

vim.keymap.set("n", "<leader>li", [[:lua vim.diagnostic.open_float(0, { scope = "line" })<CR>]], { desc = "Lsp inspect" })
-- vim.keymap.set("n", "<leader>lspe", [[:LspStart<CR>]], { desc = "Start Lsp" })
-- vim.keymap.set("n", "<leader>lspd", [[:LspStop<CR>]], { desc = "Stop Lsp" })

-- VIM TMUX NAVIGATOR
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })
-- Optional: Create a keybinding
--
vim.keymap.set('n', '<leader>cs', ':colorscheme ', { desc = "Choose theme" })

vim.keymap.set('n', '<leader>K', '<C-w>K', { desc = "Switch panes vertically" })
vim.keymap.set('n', '<leader>da', ':Dashboard<CR>', { silent = true, desc = "Open dashboard" })
vim.keymap.set('n', '<leader>H', '<C-w>H', { desc = "Switch panes horizontally" })

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

vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Open Terminal", silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")

-- TELESCOPE
vim.keymap.set("n", "<leader>tn", ":Telescope find_files cwd=~/.config/nvim<CR>", { desc = "Open Nvim Config Files", silent = true })
-- vim.keymap.set("n", "<leader>to", ":Telescope find_files cwd=~/obsidian-vaults/obsidian-vault<CR>", { desc = "Open Obsidian Files", silent = true })
vim.keymap.set("n", "<leader>oo", ":Telescope find_files cwd=~/obsidian-vaults/obsidian-vault<CR>", { desc = "Open Obsidian Files", silent = true })

vim.keymap.set("n", "<leader>gs", ":Git status<CR>", { desc = "Open :Git status" })
vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Open :Git log" })
vim.keymap.set("n", "<leader>ga", ":Git add ", { desc = "Run :Git add .", silent = false })


