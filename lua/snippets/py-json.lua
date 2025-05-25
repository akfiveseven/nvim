-- Load the LuaSnip module
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node


-- LUA SNIPPETS

ls.add_snippets("python", {
  s({ trig = "json.dumps", dscr = { "Python -> string", "Turn a python dictionary into a JSON string" } }, {
    t("json.dumps("),
    i(1),
    t(")")
  }),
  s({ trig = "json.loads", dscr = { "JSON string -> Python object", "Turn a JSON string into a Python object" } }, {
    t("json.loads("),
    i(1),
    t(")")
  }),
  s({ trig = "json.dump", dscr = { "Python -> JSON file", "Turn a Python dictionary into a JSON file" } }, {
    t("json.dump("),
    i(1),
    t(")")
  }),
  s({ trig = "json.load", dscr = { "JSON file -> Python", "Turn a JSON file into a object" } }, {
    t("json.load("),
    i(1),
    t(")")
  }),
  s({ trig = "json.pretty", dscr = { "Pretty print JSON" } }, {
    t("json.dumps("),
    i(1),
    t(", indent=4)")
  }),
})


-- Print a message to confirm snippets are loaded
print("Custom JSON python lib snippets loaded successfully!")
