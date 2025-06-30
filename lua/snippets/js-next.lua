-- Load the LuaSnip module
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Add snippets for specific filetypes
--
-- Example for Lua (adding to existing Python snippets)
ls.add_snippets("lua", {
  s("use client", {
    t("\"use client\""),
  }),
})

-- Print a message to confirm snippets are loaded
print("Custom snippets loaded successfully!")
