vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.commands")

require('snippet-stash').setup()

-- In your init.lua or a separate colors.lua file
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     -- Override specific highlight groups
--     vim.api.nvim_set_hl(0, "Comment", { fg = "#000000", italic = true })
--     vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1a1a" })
--   end,
-- })

--vim.api.nvim_set_hl(0, "Comment", { fg = "#FFFFFF" })
--vim.api.nvim_set_hl(0, "LineNr", { fg = "#00ffff" })

--require('colors.custom_theme').setup()


vim.cmd(":TransparentEnable")
