-- Load the LuaSnip module
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Add snippets for specific filetypes
--
-- Example for Lua (adding to existing Python snippets)
ls.add_snippets("typescriptreact", {
  s({ name = "use client", trig = "use client", dscr = { "Add use client" } }, {
    t("\"use client\""),
  }),
  s({ name = "useSession", trig = "import { useSession }", dscr = { "Import useSession" } }, {
    t("import { useSession } from \"next-auth/react\";"),
  }),
  s({ name = "navigation", trig = "import { useRouter, usePathname }", dscr = { "Import navigation" } }, {
    t("import { useRouter, usePathname } from \"next/navigation\";")
  }),
  s({ name = "useEffect", trig = "import { useEffect }", dscr = { "Import useEffect" } }, {
    t("import { useEffect } from \"react\";")
  }),
})

-- Print a message to confirm snippets are loaded
print("Custom snippets loaded successfully!")
