return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      -- local extras = require("luasnip.extras")
      -- local rep = extras.rep
      -- local fmt = require("luasnip.extras.fmt").fmt

      vim.keymap.set({ "i", "s" }, "<tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<s-tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })



      ls.add_snippets("python", {
        s("if", {
          t("if "),
          i(1),
          t(":"),
          t({"", "\t"}),
          i(2)
        }),
        s("else", {
          t("else:"),
          t({"", "\t"}),
          i(1)
        }),
        s("elif", {
          t("elif "),
          i(1),
          t(":"),
          t({"", "\t"}),
          i(2)
        }),
        s("forRange", {
          t("for "),
          i(1),
          t(" in range("),
          i(2),
          t("):"),
          t({"", "\t"}),
          i(3)
        }),
        s("forDict", {
          -- for key, value in person.items():
            -- print(f"{key}: {value}")
          t("for key, value in "),
          i(1),
          t(".items():"),
          t({"", "\t"}),
          t("print(f\"{key}: {value}\")"),
          i(2)
        }),
        s("function", {
          t("def "),
          i(1),
          t("("),
          i(2),
          t("):"),
          t({"", "\t"}),
          i(3)
        }),
        s("list", {
          i(1),
          t(" = ["),
          i(2),
          t("]")
        }),
        s("tuple", {
          t("point = (3, 4)"),
          t({"", ""}),
          t("x, y = point # tuple unpacking")
        }),
        s("set", {
          t("unique_vals = {1, 2, 3}")
        }),
        s("dictionary", {
          t("person = {\"name\": \"Alice\", \"age\": 30}")
        }),
        s("class", {
          t("class "),
          i(1),
          t(":"),
          t({"", "\t"}),
          t("def __init__(self"),
          i(2),
          t(")"),
          t({"", "\t\t"}),
          i(3)
        }),
        s("inherit", {
          t("class Animal:"),
          t({"", "\t"}),
          t("def __init__(self, name):"),
          t({"", "\t\t"}),
          t("self.name = name"),
          t({"", "\t"}),
          t("def speak(self):"),
          t({"", "\t\t"}),
          t("return f\"{self.name} makes a sound\""),
          t({"", ""}),
          t("class Dog(Animal):"),
          t({"", "\t"}),
          t("def speak(self):"),
          t({"", "\t\t"}),
          t("return f\"{self.name} barks\""),
        }),
        s("try", {
          t("try:"),
          t({"", "\t"}),
          i(2),
          t({"", ""}),
          t("except "),
          i(1),
          t(":"),
          t({"", "\t"}),
          i(3),
          t({"", ""}),
          t("finally:"),
          t({"", "\t"}),
          i(4)
        }),
        s("type", {
          t("type("),
          i(1),
          t(")")
        }),
        s("type", {
          t("isinstance(\"hi\", str) # True"),
        }),

      })

      -- Traverse a Map in C++
      -- unordered_map<string, int>

      ls.add_snippets("cpp", {
        s("myTraverseMap", {
          t("unordered_map<string, int> map;"),
          t({ "", "" }),
          t("for (const auto& pair : map) {"),
          t({ "", "\t" }),
          i(1),
          t({ "", "" }),
          t("}"),
        }),
      })

      ls.add_snippets("css", {
        s("root", {
          t("myroot"),
        }),
      })


      ls.add_snippets("javascriptreact", {
        s("component", {
          t("const "),
          i(1),
          t(" = ("),
          i(2),
          t(") => {"),
          t({ "", "\t" }),
          t("return ("),
          t({ "", "\t\t" }),
          t("<>"),
          t({ "", "\t\t\t" }),
          i(0),
          t({ "", "\t\t" }),
          t("</>"),
          t({ "", "\t" }),
          t(")"),
          t({ "", "};" }),
        }),
        s("div", {
          t("<div className=\""),
          i(1),
          t("\">"),
          t({ "", "\t" }),
          i(0),
          t({ "", "" }),
          t("</div>"),
        }),
        s("useEffect", {
          t("useEffect(() => {"),
          t({ "", "\t" }),
          t("// Side effect logic"),
          t({ "", "\t" }),
          t("return () => {"),
          t({ "", "\t\t" }),
          t("// Optional cleanup logic"),
          t({ "", "\t" }),
          t("};"),
          t({ "", "" }),
          t("}, []);"),

        }),
        s("className", {
          t("className=\""),
          i(1),
          t("\"")
        }),
        s("key", {
          t("key={"),
          i(1),
          t("}")
        }),
        s("map", {
          t("map(("),
          i(1),
          t(") => ("),
          t({"", "\t"}),
          i(2),
          t({"", ""}),
          t("))")
        }),
        s("onClick", {
          t("onClick={"),
          i(1),
          t("}")
        }),
        s("useState", {
          t("const ["),
          i(1),
          t(", "),
          i(2),
          t("] = useState("),
          i(3),
          t(");")
        }),
      })

      ls.add_snippets("typescriptreact", {
        s("component", {
          t("const "),
          i(1),
          t(" = ("),
          i(2),
          t(") => {"),
          t({ "", "\t" }),
          t("return ("),
          t({ "", "\t\t" }),
          t("<>"),
          t({ "", "\t\t\t" }),
          i(0),
          t({ "", "\t\t" }),
          t("</>"),
          t({ "", "\t" }),
          t(")"),
          t({ "", "};" }),
        }),
        s("div", {
          t("<div className='"),
          i(1),
          t("'>"),
          t({ "", "\t" }),
          i(0),
          t({ "", "" }),
          t("</div>"),
        }),
        s("useEffect", {
          t("useEffect(() => {"),
          t({ "", "\t" }),
          t("// Side effect logic"),
          t({ "", "\t" }),
          t("return () => {"),
          t({ "", "\t\t" }),
          t("// Optional cleanup logic"),
          t({ "", "\t" }),
          t("};"),
          t({ "", "" }),
          t("}, []);"),

        }),
      })


      -- local ls = require("luasnip")
      -- ls.filetype_extend("javascript", { "jsdoc" })
      --
      -- --- TODO: What is expand?
      -- vim.keymap.set({"i"}, "<C-s>e", function() ls.expand() end, {silent = true})
      --
      -- vim.keymap.set({"i", "s"}, "<C-s>;", function() ls.jump(1) end, {silent = true})
      -- vim.keymap.set({"i", "s"}, "<C-s>,", function() ls.jump(-1) end, {silent = true})
      --
      -- vim.keymap.set({"i", "s"}, "<C-E>", function()
      --     if ls.choice_active() then
      --         ls.change_choice(1)
      --     end
      -- end, {silent = true})
    end,
  }
}

