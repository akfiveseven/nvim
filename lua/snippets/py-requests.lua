-- Load the LuaSnip module
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node


-- LUA SNIPPETS

ls.add_snippets("python", {
  s({ trig = "request", dscr = { "Basic GET Request", "Define a GET API request" } }, {
      t("response = requests.get(\""),
      i(1),
      t("\")")
    }),
})


-- Print a message to confirm snippets are loaded
print("Custom computercraft snippets loaded successfully!")
